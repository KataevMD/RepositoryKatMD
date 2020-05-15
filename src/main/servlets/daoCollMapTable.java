package main.servlets;

import main.hibernate.HibernateUtil;

import main.dao.collMapTable;
import main.model.MapTable;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "daoCollMapTable", urlPatterns = {"/daoCollOpen"})
public class daoCollMapTable extends HttpServlet {
    private SessionFactory sessionFactory;
    @Override
    public void init() throws ServletException {
        super.init();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getServletPath();
        System.out.println(action);
            switch (action) {
//                case "/new":
//                    showNewForm(request, response);
//                    break;
                case "/daoCollOpen":
                    findAllMapTable(request, response);
                    break;
//                case "/insert":
//                    insertUser(request, response);
//                    break;
//                case "/delete":
//                    deleteUser(request, response);
//                    break;
//                case "/edit":
//                    showEditForm(request, response);
//                    break;
//                case "/update":
//                    updateUser(request, response);
//                    break;
//                default:
//                    listUser(request, response);
//                    break;
            }

    }
    /*
    Метод поиска всех карт трудового номирования техпроцессов
     */
    private void findAllMapTable(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Long id = Long.parseLong(request.getParameter("collection_id"));

        sessionFactory = HibernateUtil.getSessionFactory();
        List<MapTable> MapTables = collMapTable.findMapbyId(id);

        request.setAttribute("MapTables", MapTables);
        getServletContext().getRequestDispatcher("/WEB-INF/user/userMapTable.jsp").forward(request, response);
    }
}
