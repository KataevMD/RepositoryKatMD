package main.servlets;

import main.dao.collMapTable;
import main.dao.mapTables;
import main.hibernate.HibernateUtil;
import main.model.MapTable;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "daoMapTable", urlPatterns = {"/deleteMapTable", "/addNewMapTable", "/updateMapTable"})
public class daoMapTable extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        String action = request.getServletPath();
        if ("/deleteMapTable".equals(action)) {
            deleteMap(request, response);
        }
    }

    private void addMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        String nameCollMapTable = request.getParameter("nameCollMapTable").trim();

        if (ajax) {
            if (nameCollMapTable.length() > 0) {
                collMapTable.createCollMapTable(nameCollMapTable);
                String answer = "success";
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
