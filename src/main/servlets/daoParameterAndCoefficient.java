package main.servlets;

import main.dao.mapTables;
import main.dao.parameterAndCoefficient;
import main.hibernate.HibernateUtil;
import main.model.Coefficient;
import main.model.Parameter;
import main.model.ValueCoefficient;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "daoParameterAndCoefficient", urlPatterns = {"/getValueCoefficient"})
public class daoParameterAndCoefficient extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        doGet(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        if ("/getValueCoefficient".equals(action)) {
            getValueCoefficient(request, response);
        }
    }

    private void getValueCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));
        List<ValueCoefficient> valueCoefficients = parameterAndCoefficient.findValueCoefficientByIdCoefficient(coefficient_id);
        request.setAttribute("ValueCoefficient", valueCoefficients);

        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
    }
}
