package servlets;

import dao.DAO;
import hibernate.HibernateUtil;
import model.CollectionMapTable;
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

@WebServlet(urlPatterns = "/authUsers", name = "authUsers")
public class auth extends HttpServlet {
    private SessionFactory sessionFactory;
    private UsersAdmin usersAdmins ;
    @Override
    public void init() throws ServletException {
        super.init();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        sessionFactory = HibernateUtil.getSessionFactory();

        String login = request.getParameter("login");
        String passw = request.getParameter("password");
        String shaPassw = DAO.getHash(passw);
        HttpSession httpSession = request.getSession();

            usersAdmins = DAO.findByUserNameAndPassword(login, shaPassw);

            if(usersAdmins != null){
                httpSession.setAttribute("user", usersAdmins);
                List<CollectionMapTable> collectionMapTables = DAO.FindColl();
                request.setAttribute("name", usersAdmins.getFirstName() +" "+usersAdmins.getLastName());
                request.setAttribute("collectionMapTables", collectionMapTables);
                getServletContext().getRequestDispatcher("/mainAdmins.jsp").forward(request, response);

            }else{
                request.setAttribute("enter", "Неверен логин или пароль");
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }



    }
}
