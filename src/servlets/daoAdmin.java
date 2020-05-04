package servlets;

import dao.admin;
import hibernate.HibernateUtil;
import model.UsersAdmin;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "daoAdmins", urlPatterns = {"/OpenListManager", "/NewManager"})
public class daoAdmin extends HttpServlet {
    private SessionFactory sessionFactory;
    private HttpSession httpSession;

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

        switch (action) {
            case "/NewManager":
                showNewForm(request, response);
                break;
            case "/OpenListManager":
                showAllManager(request, response);
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

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        getServletContext().getRequestDispatcher("/register.jsp").forward(request, response);
    }

    private void showAllManager(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        sessionFactory = HibernateUtil.getSessionFactory();
        List<UsersAdmin> usersAdminList = admin.FindAdmins();
        httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        request.setAttribute("UsersAdmin", usersAdminList);
        getServletContext().getRequestDispatcher("/listAdmins.jsp").forward(request, response);
    }

}
