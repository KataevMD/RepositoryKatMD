package main.servlets;

import main.dao.*;

import main.model.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ServletOpenPages", urlPatterns = {"/openRegisterAdmins", "/openListAdminPage", "/openMainAdminsPage",
        "/openListMapTablePage", "/openListParameterAndCoefficientPage", "/myAccount", "/openImportPage", "/openStructureCollectionPage", "/openRewriteStructureCollectionPage",
        "/returnBackStructureCollection", "/openStructureCollectionPageWithMap"})
public class openPages extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Метод возвращает пользователю страницу,
     * на которую тот совершил переход
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/openRegisterAdmins":
                openRegisterAdmin(request, response);
                break;
            case "/openListAdminPage":
                openListAdmins(request, response);
                break;
            case "/openMainAdminsPage":
                openCollMapTables(request, response);
                break;
            case "/openStructureCollectionPage":
                openStructureCollectionPage(request, response);
                break;
            case "/openListParameterAndCoefficientPage":
                openListParameterAndCoefficient(request, response);
                break;
            case "/openStructureCollectionPageWithMap":
                openStructureCollectionPageWithMap(request, response);
                break;
            case "/myAccount":
                openMyAccount(request, response);
                break;
            case "/openImportPage":
                openImportPage(request, response);
                break;
            case "/openRewriteStructureCollectionPage":
                openRewriteStructureCollectionPage(request, response);
                break;
        }

    }

    private void openStructureCollectionPageWithMap(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(collection_id);

        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        MapTable mapTable = mapTables.findMapTableById(mapTable_id);


        FileMapTable fileMapTable = mapTables.findFileMapTableByMapTable_id(mapTable.getMapTable_id());
        List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
        List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
        List<Discharge> dischargeList = discharges.findAllDischarge();
        if (fileMapTable != null) {
            request.setAttribute("downloadFileMap", "http://localhost:8081/cstrmo/downloadFile?mapTable_id=" + mapTable_id.toString());
        } else {
            request.setAttribute("disabledDownloadFile", "disabled");
        }

        List<Chapter> lChapter = chapter.findChaptersByIdColl(collection_id);
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

        request.setAttribute("map", mapTable);
        request.setAttribute("TypeMapTable", lTypeMapTable);
        request.setAttribute("TypeTime", lTypeTime);
        request.setAttribute("Discharge", dischargeList);
        request.setAttribute("showPage", "http://localhost:8081/cstrmo/openListParameterAndCoefficientPage?mapTable_id=" + mapTable_id.toString());
        request.setAttribute("showPageRewriteStructureCollection", "http://localhost:8081/cstrmo/openRewriteStructureCollectionPage?collection_id=" + collection_id);
        request.setAttribute("viewParam", "disabled");
        request.setAttribute("selectFile", "disabled");
        request.setAttribute("disabledDownloadFile", "disabled");
        request.setAttribute("save", "disabled");
        request.setAttribute("delete", "disabled");

        request.setAttribute("Chapter", lChapter);
        request.setAttribute("Section", lSection);
        request.setAttribute("MapTable", lMapTable);
        request.setAttribute("collection", collectionMapTable);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);

    }

    private void openRewriteStructureCollectionPage(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(collection_id);
        List<Chapter> lChapter = chapter.findChaptersByIdColl(collection_id);
        List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
        List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
        List<Discharge> dischargeList = discharges.findAllDischarge();
        request.setAttribute("TypeMapTable", lTypeMapTable);
        request.setAttribute("TypeTime", lTypeTime);
        request.setAttribute("Discharge", dischargeList);
        request.setAttribute("Chapter", lChapter);
        request.setAttribute("collection", collectionMapTable);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
    }

    private void openImportPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CollectionMapTable> lCollection = collMapTable.findAllCollectionMapTable();
        List<Chapter> lChapter = null;
        List<Section> lSections = null;
        CollectionMapTable collectionMapTable;
        Chapter chapters;
        Section section;
        TypeMapTable typeMapTables;
        TypeTime typeTimes;
        Discharge discharge;
        Long section_id = null;
        Long typeTime_id = null;
        Long typeMapTable_id = null;
        Long discharge_id = null;
        if (lCollection != null) {
            collectionMapTable = lCollection.get(0);
             lChapter = chapter.findChaptersByIdColl(collectionMapTable.getCollection_id());
            if (lChapter != null) {
                chapters = lChapter.get(0);
                lSections = chapter.findSectionByIdChapter(chapters.getChapter_id());
                if(lSections != null){
                    section = lSections.get(0);
                    section_id = section.getSection_id();
                }
            }
        }
        List<TypeMapTable> lTypeMapTables = typeMapTable.findAllTypeMapTable();
        if(lTypeMapTables != null){
            typeMapTables = lTypeMapTables.get(0);
            typeMapTable_id = typeMapTables.getType_id();
        }
        List<TypeTime> lTypeTimes = typeTime.findAllTypeTime();
        if(lTypeTimes != null){
            typeTimes = lTypeTimes.get(0);
            typeTime_id = typeTimes.getTypeTime_id();
        }
        List<Discharge> lDischarge = discharges.findAllDischarge();
        if(lDischarge != null){
            discharge = lDischarge.get(0);
            discharge_id = discharge.getDischarge_id();
        }
        request.setAttribute("section_id", section_id);
        request.setAttribute("typeMapTable_id", typeMapTable_id);
        request.setAttribute("typeTime_id", typeTime_id);
        request.setAttribute("discharge_id", discharge_id);
        request.setAttribute("lCollection", lCollection);
        request.setAttribute("lChapter", lChapter);
        request.setAttribute("lSections", lSections);
        request.setAttribute("lTypeMapTables", lTypeMapTables);
        request.setAttribute("lTypeTimes", lTypeTimes);
        request.setAttribute("lDischarge", lDischarge);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/importMapTable.jsp").forward(request, response);

    }

    private void openMyAccount(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        String idUser = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("iduser")) {
                    idUser = cookie.getValue();
                }
            }
        }
        if (idUser != null) {
            Long id = Long.parseLong(idUser);
            UsersAdmin usersAdmin = admin.findAdminById(id);
            request.setAttribute("usersAdmin", usersAdmin);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/myAccount.jsp").forward(request, response);
        }

    }

    private void openListParameterAndCoefficient(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("mapTable_id"));
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        MapTable mapTable = mapTables.findMapTableById(id);
        List<Coefficient> coefficients = parameterAndCoefficient.findCoefficientByIdMap(id);
        List<Parameter> parameter = parameterAndCoefficient.findParametersByIdMapTable(id);
        FileMapTable fileMapTable = mapTables.findFileMapTableByMapTable_id(id);

        if (fileMapTable != null) {
            request.setAttribute("downloadFileMap", "http://localhost:8081/cstrmo/downloadFile?mapTable_id=" + id.toString());
            request.setAttribute("selectFile", "disabled");
        } else {
            request.setAttribute("disabledDownloadFile", "disabled");
            request.setAttribute("disabledDeleteFile", "disabled");
        }
        request.setAttribute("Parameter", parameter);
        request.setAttribute("collection_id", collection_id);
        request.setAttribute("Coefficient", coefficients);
        request.setAttribute("mapTable", mapTable);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listParameterAndCoefficient.jsp").forward(request, response);
    }

    private void openStructureCollectionPage(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("collection_id"));
        CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(id);
        if (collectionMapTable != null) {
            List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
            List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
            List<Discharge> dischargeList = discharges.findAllDischarge();
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

            request.setAttribute("showPageRewriteStructureCollection", "http://localhost:8081/cstrmo/openRewriteStructureCollectionPage?collection_id=" + id);
            request.setAttribute("viewParam", "disabled");
            request.setAttribute("selectFile", "disabled");
            request.setAttribute("disabledDownloadFile", "disabled");
            request.setAttribute("save", "disabled");
            request.setAttribute("delete", "disabled");
            request.setAttribute("Chapter", lChapter);
            request.setAttribute("Section", lSection);
            request.setAttribute("MapTable", lMapTable);
            request.setAttribute("TypeMapTable", lTypeMapTable);
            request.setAttribute("TypeTime", lTypeTime);
            request.setAttribute("Discharge", dischargeList);
            request.setAttribute("collection", collectionMapTable);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
        } else {
            String message = "Страницы с таким справочником не существует. \n Вернитесь на предыдущую страницу, и обновите ее";
            request.setAttribute("message", message);
            getServletContext().getRequestDispatcher("/WEB-INF/pageException/error404.jsp").forward(request, response);
        }
    }

    private void openRegisterAdmin(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        HttpSession httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/register.jsp").forward(request, response);
    }

    private void openListAdmins(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<UsersAdmin> usersAdminList = admin.FindAdmins();
        HttpSession httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        request.setAttribute("UsersAdmin", usersAdminList);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/listAdmins.jsp").forward(request, response);
    }

    private void openCollMapTables(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        HttpSession httpSession = request.getSession();
        String user = (String) httpSession.getAttribute("user");
        request.setAttribute("name", user);
        List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
        request.setAttribute("collectionMapTables", collectionMapTables);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/mainAdmins.jsp").forward(request, response);
    }
}
