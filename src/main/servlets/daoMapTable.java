package main.servlets;

import main.dao.collMapTable;
import main.dao.mapTables;
import main.model.MapTable;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "daoMapTable", urlPatterns = {"/deleteMapTable", "/addNewMapTable", "/updateMapTable", "/deleteFile","/cloneableMapTable"})
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
            case "/deleteFile":
                deleteFile(request, response);
                break;
            case "/cloneableMapTable":
                cloneMap(request, response);
                break;
        }
    }

    private void cloneMap(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if(ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            Long collection_id = Long.parseLong(request.getParameter("collection_id"));
            mapTables.cloneableMapTable(mapTable_id,collection_id);
            List<MapTable> MapTables = collMapTable.findMapByIdColl(collection_id);
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
                List<MapTable> MapTables = collMapTable.findMapByIdColl(collection_id);
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
                    List<MapTable> MapTables = collMapTable.findMapByIdColl(collection_id);
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
            List<MapTable> MapTables = collMapTable.findMapByIdColl(collection_id);
            request.setAttribute("MapTables", MapTables);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listMapTable.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }

    }
}
