package main.servlets;

import main.dao.*;
import main.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "daoMapTable", urlPatterns = {"/deleteMapTable", "/findMapTable", "/addNewMapTable", "/updateMapTable", "/deleteFile", "/cloneableMapTable"})
public class daoMapTable extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        synchronized (this) {
            response.setContentType("text/html;charset=utf-8");
            response.setCharacterEncoding("UTF-8");
            String action = request.getServletPath();
            switch (action) {
                case "/addNewMapTable":
                    addMapTable(request, response);
                    break;
                case "/updateMapTable":
                    upMapTable(request, response);
                    break;
                default:
                    doGet(request, response);
                    break;
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/deleteMapTable":
                deleteMap(request, response);
                break;
            case "/findMapTable":
                findMap(request, response);
                break;
            case "/deleteFile":
                deleteFile(request, response);
                break;
            case "/cloneableMapTable":
                cloneMap(request, response);
                break;
        }
    }

    //    Поиск карты трудового нормирования по ее идентификатору
    private void findMap(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            String collection_id = request.getParameter("collection_id");
            MapTable mapTable = mapTables.findMapTableById(mapTable_id);
            if (mapTable != null) {
                List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
                List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
                List<Discharge> dischargeList = discharges.findAllDischarge();
                FileMapTable fileMapTable = mapTables.findFileMapTableByMapTable_id(mapTable.getMapTable_id());
                if (fileMapTable != null) {
                    request.setAttribute("downloadFileMap", "http://localhost:8081/cstrmo/downloadFile?mapTable_id=" + mapTable_id.toString());
                } else {
                    request.setAttribute("disabledDownloadFile", "disabled");
                }
                request.setAttribute("collection_id", collection_id);
                request.setAttribute("map", mapTable);
                request.setAttribute("TypeMapTable", lTypeMapTable);
                request.setAttribute("TypeTime", lTypeTime);
                request.setAttribute("Discharge", dischargeList);
                request.setAttribute("showPage", "http://localhost:8081/cstrmo/openListParameterAndCoefficientPage?mapTable_id=" + mapTable_id.toString() + "&collection_id=" + collection_id);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
            }
        }
    }

    //Клонирование карты трудового нормирования
    private void cloneMap(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            Long section_id = Long.parseLong(request.getParameter("section_id"));
            mapTables.cloneableMapTable(mapTable_id, section_id);
            String answer = "success";
            response.getWriter().write(answer);
        }
    }

    //Удаление бумажного представления карты трудового нормирования
    private void deleteFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            boolean res = mapTables.deleteFileByIdMapTable(mapTable_id);
            if (res) {
                String answer = "success";
                response.getWriter().write(answer);
            } else {
                String answer = "fail";
                response.getWriter().write(answer);
            }
        }
    }

    //Создание новой карты трудового нормирования
    private void addMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (ajax) {
            Long section_id = Long.parseLong(request.getParameter("sections"));
            String numberTable = request.getParameter("numberMapTable").trim();
            String nameMapTable = request.getParameter("nameMapTable").trim();


            Long typeTime_id = Long.parseLong(request.getParameter("typeTimes"));
            Long discharge_id = Long.parseLong(request.getParameter("discharge"));
            Long type_id = Long.parseLong(request.getParameter("typeMapTable"));

            boolean res = mapTables.createMapTable(section_id, nameMapTable, numberTable, type_id, discharge_id, typeTime_id);
            if (res) {
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
            } else {
                String answer = "fail";
                response.getWriter().write(answer);
            }
        }
    }

    //Обновление данных карты трудового нормирования
    private void upMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (ajax) {
            String nameMapTable = request.getParameter("nameMapTable").trim();
            String numberTable = request.getParameter("numberMapTable").trim();

            Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
            Long collection_id = Long.parseLong(request.getParameter("collection_Id"));
            Long typeTime_id = Long.parseLong(request.getParameter("typeTimes"));
            Long discharge_id = Long.parseLong(request.getParameter("discharge"));
            Long type_id = Long.parseLong(request.getParameter("typeMapTable"));

            String formulasList = request.getParameter("formulaMap");
            boolean res = mapTables.rewriteMapTable(nameMapTable, mapTable_id, numberTable, formulasList, type_id, discharge_id, typeTime_id);
            if (res) {
                MapTable mapTable = mapTables.findMapTableById(mapTable_id);
                List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
                List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
                FileMapTable fileMapTable = mapTables.findFileMapTableByMapTable_id(mapTable.getMapTable_id());
                if (fileMapTable != null) {
                    request.setAttribute("downloadFileMap", "http://localhost:8081/cstrmo/downloadFile?mapTable_id=" + mapTable_id.toString());
                } else {
                    request.setAttribute("disabledDownloadFile", "disabled");
                }
                List<Discharge> dischargeList = discharges.findAllDischarge();
                request.setAttribute("map", mapTable);

                request.setAttribute("TypeMapTable", lTypeMapTable);
                request.setAttribute("TypeTime", lTypeTime);
                request.setAttribute("Discharge", dischargeList);
                request.setAttribute("showPage", "http://localhost:8081/cstrmo/openListParameterAndCoefficientPage?mapTable_id=" + mapTable_id.toString() + "&collection_id=" + collection_id);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
            } else {
                String answer = "fail";
                response.getWriter().write(answer);
            }
        }
    }

    //Удаление карты трудового нормирования
    private void deleteMap(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long id = Long.parseLong(request.getParameter("mapTable_id"));
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        boolean res = mapTables.deleteMapTableById(id);
        if (res) {

            CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(collection_id);
            if (collectionMapTable != null) {
                List<TypeTime> lTypeTime = typeTime.findAllTypeTime();
                List<TypeMapTable> lTypeMapTable = typeMapTable.findAllTypeMapTable();
                List<Discharge> dischargeList = discharges.findAllDischarge();
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
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
            } else {
                String message = "Страницы с таким справочником не существует. \n Вернитесь на предыдущую страницу, и обновите ее";
                request.setAttribute("message", message);
                getServletContext().getRequestDispatcher("/WEB-INF/pageException/error404.jsp").forward(request, response);
            }
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }

    }
}
