package main.servlets;

import main.dao.collMapTable;
import main.dao.mapTables;
import main.hibernate.HibernateUtil;
import main.model.FileMapTable;
import main.model.MapTable;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "daoMapTable", urlPatterns = {"/deleteMapTable", "/addNewMapTable", "/updateMapTable", "/deleteFile"})
public class daoMapTable extends HttpServlet {
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
        String formul = request.getParameter("formul");
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        if (ajax) {
            if (nameMapTable.length() > 0 && numberTable.length() > 0 && formul.length() > 0) {
                boolean res = mapTables.rewriteMapTable(nameMapTable, mapTable_id, numberTable, formul);
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
