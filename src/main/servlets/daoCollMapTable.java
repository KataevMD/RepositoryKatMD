package main.servlets;

import main.dao.admin;
import main.dao.chapter;
import main.dao.collMapTable;
import main.hibernate.HibernateUtil;
import main.model.Chapter;
import main.model.CollectionMapTable;
import main.model.Section;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "daoCollMapTables", urlPatterns = {"/deleteCollMapTable", "/addNewCollMapTable", "/updateCollMapTable", "/getListChapter", "/getListSections"})
public class daoCollMapTable extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getServletPath();
        switch (action) {
            case "/addNewCollMapTable":
                addCollMapTable(request, response);
                break;
            case "/updateCollMapTable":
                upCollMapTable(request, response);
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
            case "/deleteCollMapTable":
                deleteColl(request, response);
                break;
            case "/getListChapter":
                getListChapter(request, response);
                break;
            case "/getListSections":
                getListSection(request, response);
                break;
        }
    }

    private void getListSection(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        Long chapter_id = Long.parseLong(request.getParameter("chapter_id"));
        if (ajax) {
            List<Section> lSection = chapter.findSectionByIdChapter(chapter_id);
            if (lSection != null) {
                request.setAttribute("listSectionChapter", lSection);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
            }

        }


    }

    private void getListChapter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Long collection_id = Long.parseLong(request.getParameter("collection_id"));


            List<Chapter> lChapter = chapter.findChaptersByIdColl(collection_id);
            if (lChapter != null) {
                request.setAttribute("listChapterCollection", lChapter);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
            }
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);


    }

    private void addCollMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        String nameCollMapTable = request.getParameter("nameCollMapTable").trim();

        if (ajax) {
            if (nameCollMapTable.length() > 0) {
                collMapTable.createCollMapTable(nameCollMapTable);
                List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
                request.setAttribute("collectionMapTables", collectionMapTables);
                getServletContext().getRequestDispatcher("/WEB-INF/administrator/mainAdmins.jsp").forward(request, response);
            }
        }
    }

    private void upCollMapTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        String nameCollMapTable = request.getParameter("nameCollMapTable").trim();
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));

        if (ajax) {
            if (nameCollMapTable.length() > 0) {
                collMapTable.rewriteCollMapTable(nameCollMapTable, collection_id);
                CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(collection_id);
                request.setAttribute("collection", collectionMapTable);

                getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
            }
        }
    }

    private void deleteColl(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long id = Long.parseLong(request.getParameter("collection_id"));
        collMapTable.deleteCollMapTableById(id);
        List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();
        request.setAttribute("collectionMapTables", collectionMapTables);
        getServletContext().getRequestDispatcher("/WEB-INF/administrator/mainAdmins.jsp").forward(request, response);
    }
}
