package main.servlets;

import main.dao.collMapTable;
import main.dao.mapTables;
import main.dao.parameterAndCoefficient;
import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.mapping.Value;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "daoParameterAndCoefficient", urlPatterns = {"/getValueCoefficient", "/addNewParameter", "/addNewCoefficient",
        "/addNewValueCoefficient", "/deleteParameter", "/deleteCoefficient", "/deleteValueCoefficient", "/updateParameter", "/updateCoefficient",
        "/updateValueCoefficient","/updateFormula"})
public class daoParameterAndCoefficient extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/addNewParameter":
                addParameter(request, response);
                break;
            case "/addNewCoefficient":
                addCoefficient(request, response);
                break;
            case "/addNewValueCoefficient":
                addValueCoefficient(request, response);
                break;
            case "/updateParameter":
                updateParameter(request, response);
                break;
            case "/updateCoefficient":
                updateCoefficient(request, response);
                break;
            case "/updateValueCoefficient":
                updateValueCoefficient(request, response);
                break;
            case "/updateFormula":
                updateFormula(request, response);
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
            case "/getValueCoefficient":
                getValueCoefficient(request, response);
                break;
            case "/deleteParameter":
                deleteParameter(request, response);
                break;
            case "/deleteValueCoefficient":
                deleteValueCoefficient(request, response);
                break;
            case "/deleteCoefficient":
                deleteCoefficient(request, response);
                break;
        }
    }

    private void updateValueCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));

        String valName = request.getParameter("valName").trim();
        Long coeffValue_id = Long.parseLong(request.getParameter("coeffValue_id"));
        Double value = Double.parseDouble(request.getParameter("value").trim());
        boolean res = parameterAndCoefficient.rewriteValueCoefficient(valName, value, coeffValue_id);
        if (res) {
            List<ValueCoefficient> valueCoefficients = parameterAndCoefficient.findValueCoefficientByIdCoefficient(coefficient_id);
            request.setAttribute("ValueCoefficient", valueCoefficients);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }

    }

    private void updateCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        String nameCoefficient = request.getParameter("nameCoefficient").trim();
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));

        boolean res = parameterAndCoefficient.rewriteCoefficient(nameCoefficient, coefficient_id);
        if (res) {
            List<Coefficient> coefficients = parameterAndCoefficient.findCoefficientByIdMap(mapTable_id);
            request.setAttribute("Coefficient", coefficients);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }

    private void updateParameter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        String nameParameter = request.getParameter("nameParameter").trim();
        Double step = Double.parseDouble(request.getParameter("step").trim());
        Long parameter_id = Long.parseLong(request.getParameter("parameter_id"));

        boolean res = parameterAndCoefficient.rewriteParameter(nameParameter, parameter_id, step);
        if (res) {
            List<Parameter> parameters = parameterAndCoefficient.findParametersByIdMapTable(mapTable_id);
            request.setAttribute("Parameter", parameters);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }
    private void updateFormula(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        String formula = request.getParameter("nFormula").trim();
        Long formula_id = Long.parseLong(request.getParameter("formula_id"));

        boolean res = parameterAndCoefficient.rewriteFormula(formula, formula_id);
        if (res) {
            List<Formula> formulas = parameterAndCoefficient.findFormulasByIdMapTable(mapTable_id);
            request.setAttribute("Formula", formulas);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }
    private void deleteCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));
        boolean res = parameterAndCoefficient.deleteCoefficientById(coefficient_id);
        if (res) {
            List<Coefficient> coefficients = parameterAndCoefficient.findCoefficientByIdMap(mapTable_id);
            request.setAttribute("Coefficient", coefficients);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }

    private void deleteValueCoefficient(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));
        Long coeffValue_id = Long.parseLong(request.getParameter("coeffValue_id"));
        boolean res = parameterAndCoefficient.deleteValueCoefficientById(coeffValue_id);
        if (res) {
            List<ValueCoefficient> valueCoefficients = parameterAndCoefficient.findValueCoefficientByIdCoefficient(coefficient_id);
            request.setAttribute("ValueCoefficient", valueCoefficients);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }

    private void deleteParameter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        Long parameter_id = Long.parseLong(request.getParameter("parameter_id"));
        boolean res = parameterAndCoefficient.deleteParameterById(parameter_id);
        if (res) {
            List<Parameter> parameters = parameterAndCoefficient.findParametersByIdMapTable(mapTable_id);
            request.setAttribute("Parameter", parameters);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }


    private void addValueCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));
        String valName = request.getParameter("valName").trim();
        Double value = Double.parseDouble(request.getParameter("value").trim());
        if (valName.length() > 0) {

            parameterAndCoefficient.createValueCoefficient(coefficient_id, valName, value);
            List<ValueCoefficient> valueCoefficients = parameterAndCoefficient.findValueCoefficientByIdCoefficient(coefficient_id);
            request.setAttribute("ValueCoefficient", valueCoefficients);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);

        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }

    private void addCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        String nameCoefficient = request.getParameter("nameCoefficient").trim();

        if (nameCoefficient.length() > 0) {
            parameterAndCoefficient.createCoefficient(mapTable_id, nameCoefficient);
            List<Coefficient> coefficients = parameterAndCoefficient.findCoefficientByIdMap(mapTable_id);
            request.setAttribute("Coefficient", coefficients);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }

    private void addParameter(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        String nameParameter = request.getParameter("nameParameter").trim();
        Double step = Double.parseDouble(request.getParameter("stepParameter").trim());
        if (nameParameter.length() > 0) {
            parameterAndCoefficient.createParameter(mapTable_id, nameParameter, step);
            List<Parameter> parameters = parameterAndCoefficient.findParametersByIdMapTable(mapTable_id);
            request.setAttribute("Parameter", parameters);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }


    }

    private void getValueCoefficient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long coefficient_id = Long.parseLong(request.getParameter("coefficient_id"));
        List<ValueCoefficient> valueCoefficients = parameterAndCoefficient.findValueCoefficientByIdCoefficient(coefficient_id);
        request.setAttribute("ValueCoefficient", valueCoefficients);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
    }
    private void updatePageListParameter(){

    }
}
