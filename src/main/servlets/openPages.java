package main.servlets;

import main.dao.admin;
import main.dao.collMapTable;
import main.dao.mapTables;
import main.dao.parameterAndCoefficient;
import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletOpenPages", urlPatterns = {"/openRegisterAdmins", "/openListAdminPage", "/openMainAdminsPage","/openListMapTablePage","/openListParameterAndCoefficientPage"})
public class openPages extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    /**
     * Метод возвращает пользователю страницу,
     * на которую тот совершил переход
     * */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/openRegisterAdmins":
                openRegisterAdmin(request, response);
                break;
            case "/openListAdminPage":
                openListAdmins(request, response);
                break;
            case "/openMainAdminsPage":
                openCollMapTables(request, response);
                break;
            case "/openListMapTablePage":
                openListMapTables(request, response);
                break;
            case "/openListParameterAndCoefficientPage":
                openListParameterAndCoefficient(request, response);
                break;
        }
    }

    private void openListParameterAndCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("mapTable_id"));
        String nameMap = request.getParameter("nameMapTable");
        List<Coefficient> coefficients = mapTables.findCoefficientByIdMap(id);
        List<Parameter> parameter = parameterAndCoefficient.findParametersByIdMapTable(id);
        request.setAttribute("Parameter", parameter);
        request.setAttribute("Coefficient", coefficients);
        request.setAttribute("nameMapTable", nameMap);
        request.setAttribute("mapTable_Id", id);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
    }

    private void openListMapTables(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Long id = Long.parseLong(request.getParameter("collection_id"));
        String nameColl = request.getParameter("nameCollectionMapTable");
        List<MapTable> MapTables = collMapTable.findMapByIdColl(id);
        request.setAttribute("collection_Id", id);
        request.setAttribute("MapTables", MapTables);
        request.setAttribute("nameCollMapTable", nameColl);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listMapTable.jsp").forward(request, response);
    }

    private void openRegisterAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/register.jsp").forward(request, response);
    }

    private void openListAdmins(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idUser = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("iduser")) {
                    idUser = cookie.getValue();
                }
            }
        }
        List<UsersAdmin> usersAdminList = admin.FindAdmins(idUser);
        HttpSession httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        request.setAttribute("UsersAdmin", usersAdminList);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listAdmins.jsp").forward(request, response);
    }
    private void openCollMapTables(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
        request.setAttribute("collectionMapTables", collectionMapTables);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/mainAdmins.jsp").forward(request, response);
    }
}
