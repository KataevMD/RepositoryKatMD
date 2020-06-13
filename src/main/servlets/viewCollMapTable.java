package main.servlets;

import main.dao.collMapTable;
import main.dao.parameterAndCoefficient;
import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.MapTable;
import main.model.Parameter;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "daoCollMapTable", urlPatterns = {"/daoCollOpen", "/viewParamAndCoeff", "/out", "/loadCollForUsers"})
public class viewCollMapTable extends HttpServlet {


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
            case "/out":
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
                break;
            case "/daoCollOpen":
                findAllMapTable(request, response);
                break;
            case "/viewParamAndCoeff":
                findParamAndCoeffById(request, response);
                break;
            case "/loadCollForUsers":
                openMainUser(request, response);
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

    /*
    Метод поиска всех карт трудового номирования техпроцессов
     */
    private void findAllMapTable(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("collection_id"));
        String nameColl = request.getParameter("nameCollectionMapTable");
        List<MapTable> MapTables = collMapTable.findMapByIdSection(id);

        request.setAttribute("MapTables", MapTables);
        request.setAttribute("nameCollMapTable", nameColl);
        getServletContext().getRequestDispatcher("/WEB-INF/user/userMapTable.jsp").forward(request, response);
    }

    /*
    Метод поиска всех параметров по id выбранной карты
     */
    private void findParamAndCoeffById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("mapTable_id").trim());
        //  String nameColl = request.getParameter("nameCollectionMapTable");
        List<Parameter> parameters = parameterAndCoefficient.findParametersByIdMapTable(id);


        request.setAttribute("Parameter", parameters);
        getServletContext().getRequestDispatcher("/WEB-INF/user/userMapTable.jsp").forward(request, response);
    }

    private void openMainUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
        request.setAttribute("collectionMapTables", collectionMapTables);
        getServletContext().getRequestDispatcher("/WEB-INF/user/mainUsers.jsp").forward(request, response);
    }
}
