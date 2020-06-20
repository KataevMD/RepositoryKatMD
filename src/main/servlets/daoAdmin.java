package main.servlets;

import main.dao.admin;
import main.model.UsersAdmin;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet(name = "daoAdmins", urlPatterns = {"/createAccAdmin", "/deleteAccAdminById", "/updatePassword", "/updateAccAdmin"})
public class daoAdmin extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/createAccAdmin":
                createAccountAdmin(request, response);
                break;
            case "/updateAccAdmin":
                updateAccAdmin(request, response);
                break;
            case "/updatePassword":
                updatePassword(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/deleteAccAdminById":
                deleteAdmin(request, response);
                break;
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

    private void updatePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idUser = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("iduser")) {
                    idUser = cookie.getValue();
                }
            }
        }
        String answer = null;
        if (idUser != null) {
            UsersAdmin user = admin.findAdminById(Long.parseLong(idUser));
            String oldPassword = request.getParameter("odlPassword").trim();
            String newPassword = request.getParameter("newPassword").trim();
            String retNewPassword = request.getParameter("retNewPassword").trim();
            oldPassword = admin.getHash(oldPassword);

            if(newPassword.equals(retNewPassword)){
                if (oldPassword.equals(user.getPassword()) ) {

                    String hashPassw = admin.getHash(newPassword);
                    user.setPassword(hashPassw);
                    admin.updatePassword(user);
                    answer = "success";
                }else {
                    answer = "notValid";
                }
            }
             else {
                answer = "passNotEquals";
            }
            response.getWriter().write(answer);
        }


    }

    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String answer;
        String idUser = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("iduser")) {
                    idUser = cookie.getValue();
                }
            }
        }
        if (id.toString().equals(idUser)) {
            answer = "yoursAcc";
        } else {
            answer = "success";
            admin.deleteAdmin(id);
        }
        response.getWriter().write(answer);
    }

    private void createAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String patronymic = request.getParameter("patronymic").trim();
        String login = request.getParameter("login").trim();
        String passw = request.getParameter("password").trim();
        if (ajax) {
            if (login.length() > 0 && firstName.length() > 0 && passw.length() > 0 && lastName.length() > 0) {
                Boolean res = admin.findAdminByLogin(login);
                if (res) {

                    admin.createAdmin(firstName, lastName, patronymic, passw, login);
                    String answer = "success";
                    response.getWriter().write(answer);
                } else {
                    String answer = "fail";
                    response.getWriter().write(answer);
                }
            }
        }
    }

    private void updateAccAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            String firstName = request.getParameter("firstName").trim();
            String lastName = request.getParameter("lastName").trim();
            String patronymic = request.getParameter("patronymic").trim();
            String login = request.getParameter("login").trim();
            Long id = Long.parseLong(request.getParameter("user_id"));
            admin.updateDataAcc(firstName,lastName,patronymic,login,id);
            String answer = "success";
            response.getWriter().write(answer);
        }
    }
}
