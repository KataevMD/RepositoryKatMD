package main.servlets;

import main.dao.*;
import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "daoCollMapTable", urlPatterns = {"/daoCollOpen", "/viewParamAndCoeff","/viewMapTable", "/out", "/loadCollForUsers"})
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
            case "/viewMapTable":
                viewMapTable(request, response);
                break;
        }

    }
    /*
        Метод поиска карты трудового нормирования, и отправка данных на страницу пользователя
         */
    private void viewMapTable(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            MapTable mapTable = mapTables.findMapTableById(mapTable_id);
            if (mapTable != null) {
                List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
                List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
                List<Discharge> dischargeList = discharges.findAllDischarge();
                FileMapTable fileMapTable = mapTables.findFileMapTableByMapTable_id(mapTable.getMapTable_id());
                List<Parameter> lParameter = parameterAndCoefficient.findParametersByIdMapTable(mapTable_id);
                List<Coefficient> lCoefficient = parameterAndCoefficient.findCoefficientByIdMap(mapTable_id);
                if (fileMapTable != null) {
                    request.setAttribute("downloadFileMap", "http://localhost:8081/cstrmo/downloadFile?mapTable_id=" + mapTable_id.toString());
                } else {
                    request.setAttribute("disabledDownloadFile", "disabled");
                }
                request.setAttribute("map", mapTable);
                request.setAttribute("Parameter", lParameter);
                request.setAttribute("Coefficient", lCoefficient);
                request.setAttribute("TypeMapTable", lTypeMapTable);
                request.setAttribute("TypeTime", lTypeTime);
                request.setAttribute("Discharge", dischargeList);
                getServletContext().getRequestDispatcher("/WEB-INF/user/viewStructureCollection.jsp").forward(request, response);
            }
        }
    }

    /*
    Метод поиска всех карт трудового номирования техпроцессов
     */
    private void findAllMapTable(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("collection_id"));
        CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(id);
        if (collectionMapTable != null) {
            List<Chapter> lChapter = chapter.findChaptersByIdColl(id);
            List<Section> lSection = new ArrayList<>();
            List<MapTable> lMapTable = new ArrayList<>();
            if (lChapter != null) {
                for (Chapter chapters : lChapter) {
                    List<Section> sectionList = chapter.findSectionByIdChapter(chapters.getChapter_id());
                    if (sectionList != null) {
                        lSection.addAll(sectionList);
                    }
                }
                for (Section section : lSection) {
                    List<MapTable> mapTableList = collMapTable.findMapByIdSection(section.getSection_id());
                    if (mapTableList != null) {
                        lMapTable.addAll(mapTableList);
                    }
                }
            }
            request.setAttribute("disabled", "disabled");
            request.setAttribute("disabledDownloadFile", "disabled");
            request.setAttribute("Chapter", lChapter);
            request.setAttribute("Section", lSection);
            request.setAttribute("MapTable", lMapTable);
            request.setAttribute("collection", collectionMapTable);
            getServletContext().getRequestDispatcher("/WEB-INF/user/viewStructureCollection.jsp").forward(request, response);
        } else {
            String message = "Страницы с таким справочником не существует. \n Вернитесь на предыдущую страницу, и обновите ее";
            request.setAttribute("message", message);
            getServletContext().getRequestDispatcher("/WEB-INF/pageException/error404.jsp").forward(request, response);
        }
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
