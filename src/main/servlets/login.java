package main.servlets;

import main.dao.collMapTable;
import main.dao.admin;
import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.UsersAdmin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
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

                    String encodedLogin = Base64.getEncoder().encodeToString(login.getBytes());
                    String encodedPassw = Base64.getEncoder().encodeToString(passw.getBytes());


                    Cookie cLogin = new Cookie("cooklogin", encodedLogin);
                    Cookie cPassword = new Cookie("cookpass", encodedPassw);
                    Cookie cRemember = new Cookie("cookrem", remember.trim());
                    cLogin.setMaxAge(60 * 60 * 24);// хранение 1 день
                    cPassword.setMaxAge(60 * 60 * 24);
                    cRemember.setMaxAge(60 * 60 * 24);
                    response.addCookie(cLogin);
                    response.addCookie(cPassword);
                    response.addCookie(cRemember);
                }
                String who = usersAdmins.getLastName()+usersAdmins.getFirstName();
                Cookie cId = new Cookie("iduser", usersAdmins.getId().toString());
                Cookie cUserName = new Cookie("cookuser", who);
                cUserName.setMaxAge(60 * 60 * 24);
                cId.setMaxAge(60*60*24);
                response.addCookie(cId);
                response.addCookie(cUserName);
                httpSession.setAttribute("sessuser", usersAdmins.getLogin());
                if(passw.equals("Passw0rd")){
                    request.setAttribute("message", "Для продолжения работы в системе требуется изменить пароль.\nЭто можно сделать ниже, в графе изменения пароля! ");
                    request.setAttribute("hiddenNav", "hidden");
                    request.setAttribute("mess", 1);
                    request.setAttribute("disableCancel", "disabled");
                    request.setAttribute("login", usersAdmins.getLogin());
                    request.setAttribute("firstName", usersAdmins.getFirstName());
                    request.setAttribute("lastName", usersAdmins.getLastName());
                    request.setAttribute("patronymic", usersAdmins.getPatronymic());
                    getServletContext().getRequestDispatcher("/WEB-INF/administrator/myAccount.jsp").forward(request, response);
                }else {
                    List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
                    request.setAttribute("collectionMapTables", collectionMapTables);
                    getServletContext().getRequestDispatcher("/WEB-INF/administrator/mainAdmins.jsp").forward(request, response);
                }
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
