package main.servlets;

import main.dao.collMapTable;
import main.dao.admin;
import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.UsersAdmin;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Base64;
import java.util.List;

@WebServlet(urlPatterns = "/login", name = "login")
public class login extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    /*
    *Процесс авторизации пользователя в системе
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String login = request.getParameter("login");
        String passw = request.getParameter("password");

        if(login != null && login.trim().length() > 0 && passw != null && passw.trim().length() > 0){

            String shaPassw = admin.getHash(passw);
            HttpSession httpSession = request.getSession();
            UsersAdmin usersAdmins = admin.findByUserNameAndPassword(login, shaPassw);

            if(usersAdmins != null){
                if (request.getParameter("remember") != null) {
                    String remember = request.getParameter("remember");

//                    byte [] encodedLogin = Base64.getEncoder().encode(login.getBytes());
//                    byte [] encodedPassw = Base64.getEncoder().encode(passw.getBytes());

                    Cookie cUserName = new Cookie("cookuser", login.trim());
                    Cookie cPassword = new Cookie("cookpass", passw.trim());
                    Cookie cRemember = new Cookie("cookrem", remember.trim());
                    cUserName.setMaxAge(60 * 60 * 24);// хранение 1 день
                    cPassword.setMaxAge(60 * 60 * 24);
                    cRemember.setMaxAge(60 * 60 * 24);
                    response.addCookie(cUserName);
                    response.addCookie(cPassword);
                    response.addCookie(cRemember);
                }


                httpSession.setAttribute("sessuser", usersAdmins.getLogin());
                List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
                request.setAttribute("name", usersAdmins.getFirstName() +" "+ usersAdmins.getLastName());
                request.setAttribute("collectionMapTables", collectionMapTables);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/mainAdmins.jsp").forward(request, response);

            }else{
                request.setAttribute("msg", "Неверен логин или пароль.");
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }else {
            request.setAttribute("msg", "Логин и пароль являются обязательными полями.");
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }




    }
}
