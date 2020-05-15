package main.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = "/logout", name = "logout")
public class logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie cUserName = new Cookie("cookuser", null);
        Cookie cPassword = new Cookie("cookpass", null);
        Cookie cRemember = new Cookie("cookrem", null);
        cUserName.setMaxAge(0);
        cPassword.setMaxAge(0);
        cRemember.setMaxAge(0);
        response.addCookie(cUserName);
        response.addCookie(cPassword);
        response.addCookie(cRemember);
        HttpSession httpSession = request.getSession();
        httpSession.invalidate();
        request.setAttribute("msg", "Вы успешно вышли из системы.");
        getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);

    }
}
