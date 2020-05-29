package main.servlets;

import main.dao.admin;
import main.dao.collMapTable;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "daoCollMapTables", urlPatterns = {"/deleteCollMapTable","/addNewCollMapTable","/updateCollMapTable"})
public class daoCollMapTable extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/addNewCollMapTable":
                addCollMapTable(request, response);
                break;
            case "/updateCollMapTable":
                upCollMapTable(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/deleteCollMapTable":
                deleteColl(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void addCollMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
    private void upCollMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        String nameCollMapTable = request.getParameter("nameCollMapTable").trim();
        Long collection_id = Long.parseLong(request.getParameter("idColl"));
        if (ajax) {
            if (nameCollMapTable.length() > 0) {
                collMapTable.rewriteCollMapTable(nameCollMapTable, collection_id);
                String answer = "success";
                response.getWriter().write(answer);
            }
        }
    }
    private void deleteColl(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("collection_id"));
        collMapTable.deleteCollMapTableById(id);
        String answer = "success";
        response.getWriter().write(answer);
    }
}
