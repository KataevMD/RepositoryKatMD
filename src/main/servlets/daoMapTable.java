package main.servlets;

import main.dao.*;
import main.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "daoMapTable", urlPatterns = {"/deleteMapTable","/findMapTable", "/addNewMapTable", "/updateMapTable", "/deleteFile","/cloneableMapTable"})
public class daoMapTable extends HttpServlet{
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        synchronized (this) {
            response.setContentType("text/html;charset=utf-8");
            response.setCharacterEncoding("UTF-8");
            String action = request.getServletPath();
            switch (action) {
                case "/addNewMapTable":
                    addMapTable(request, response);
                    break;
                case "/updateMapTable":
                    upMapTable(request, response);
                    break;
                default:
                    doGet(request, response);
                    break;
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/deleteMapTable":
                deleteMap(request, response);
                break;
            case "/findMapTable":
                findMap(request, response);
                break;
            case "/deleteFile":
                deleteFile(request, response);
                break;
            case "/cloneableMapTable":
                cloneMap(request, response);
                break;
        }
    }

    private void findMap(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if(ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            MapTable mapTable =  mapTables.findMapTableById(mapTable_id);
            if(mapTable != null){
                List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
                List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
                FileMapTable fileMapTable = mapTables.findFileMapTableByMapTable_id(mapTable.getMapTable_id());
                List<Formula> lFormula = parameterAndCoefficient.findFormulasByIdMapTable(mapTable.getMapTable_id());
                if(fileMapTable != null){
                    request.setAttribute("downloadFileMap","http://localhost:8081/cstrmo/downloadFile?mapTable_id="+mapTable_id.toString());
                    request.setAttribute("selectFile","disabled");
                }else{
                    request.setAttribute("disabledDownloadFile","disabled");
                    request.setAttribute("disabledDeleteFile","disabled");
                }

                request.setAttribute("map", mapTable);
                request.setAttribute("Formula", lFormula);
                request.setAttribute("TypeMapTable", lTypeMapTable);
                request.setAttribute("TypeTime", lTypeTime);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
            }
        }
    }

    private void cloneMap(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if(ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            Long collection_id = Long.parseLong(request.getParameter("collection_id"));
            mapTables.cloneableMapTable(mapTable_id,collection_id);
            List<MapTable> MapTables = collMapTable.findMapByIdSection(collection_id);
            request.setAttribute("MapTables", MapTables);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listMapTable.jsp").forward(request, response);
        }
    }

    private void deleteFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if(ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
           boolean res =  mapTables.deleteFileByIdMapTable(mapTable_id);
           if(res){
               String answer = "success";
               response.getWriter().write(answer);
           }else {
               String answer = "fail";
               response.getWriter().write(answer);
           }
        }
    }

    private void addMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        String nameMapTable = request.getParameter("nameMapTable").trim();
        String formulMapTable = request.getParameter("formulMapTable");
        String numberMapTable = request.getParameter("numberMapTable");
        Long collection_id = Long.parseLong(request.getParameter("collection_Id").trim());

        if (ajax) {
            if (nameMapTable.length() > 0) {
                mapTables.createMapTable(nameMapTable, formulMapTable, numberMapTable, collection_id);
                List<MapTable> MapTables = collMapTable.findMapByIdSection(collection_id);
                request.setAttribute("MapTables", MapTables);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/listMapTable.jsp").forward(request, response);
            } else {
                String answer = "fail";
                response.getWriter().write(answer);
            }
        }
    }

    private void upMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        String nameMapTable = request.getParameter("nameMapTable").trim();
        String numberTable = request.getParameter("numberTable").trim();
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        if (ajax) {
            if (nameMapTable.length() > 0 && numberTable.length() > 0 ) {
                boolean res = mapTables.rewriteMapTable(nameMapTable, mapTable_id, numberTable);
                if (res) {
                    List<MapTable> MapTables = collMapTable.findMapByIdSection(collection_id);
                    request.setAttribute("MapTables", MapTables);
                    getServletContext().getRequestDispatcher("/WEB-INF/administrator/listMapTable.jsp").forward(request, response);
                } else {
                    String answer = "fail";
                    response.getWriter().write(answer);
                }

            }
        }
    }

    private void deleteMap(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long id = Long.parseLong(request.getParameter("mapTable_id"));
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        boolean res = mapTables.deleteMapTableById(id);
        if (res) {
            List<MapTable> MapTables = collMapTable.findMapByIdSection(collection_id);
            request.setAttribute("MapTables", MapTables);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listMapTable.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }

    }
}
