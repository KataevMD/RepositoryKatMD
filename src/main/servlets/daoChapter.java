package main.servlets;

import main.dao.chapter;
import main.dao.collMapTable;
import main.dao.mapTables;
import main.dao.parameterAndCoefficient;
import main.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ServletDaoChapter", urlPatterns = {"/findChapter", "/getListSection", "/findSection", "/updateChapter", "/updateSection"})
public class daoChapter extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/updateChapter":
                updateChapter(request, response);
                break;
            case "/updateSection":
                updateSection(request, response);
                break;
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/getListSection":
                getListSection(request, response);
                break;
            case "/findSection":
                findSection(request, response);
                break;
            case "/findChapter":
                findChapter(request, response);
                break;
        }
    }
    private void updateSection(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long chapter_id = Long.parseLong(request.getParameter("chapter_id"));
        String nameSection = request.getParameter("nameSection").trim();
        Long section_id = Long.parseLong(request.getParameter("section_id"));

        boolean res = chapter.rewriteSection(nameSection, section_id);
        if (res) {
            Section section = chapter.findSectionById(chapter_id);
            List<Section> sections = chapter.findSectionByIdChapter(chapter_id);
            request.setAttribute("listSection", section);
            request.setAttribute("Section", sections);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }
    }

    private void updateChapter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long collection_id = Long.parseLong(request.getParameter("collection_id"));
        String nameChapter = request.getParameter("nameChapter").trim();
        Long chapter_id = Long.parseLong(request.getParameter("chapter_id"));

        boolean res = chapter.rewriteChapter(nameChapter, chapter_id);
        if (res) {
            Chapter chapt = chapter.findChaptersById(chapter_id);
            List<Chapter> chapters = chapter.findChaptersByIdColl(collection_id);
            request.setAttribute("chapter", chapt);
            request.setAttribute("Chapter", chapters);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
        } else {
            String answer = "fail";
            response.getWriter().write(answer);
        }

    }

    private void findSection(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long section_id = Long.parseLong(request.getParameter("section_id"));
            Section section = chapter.findSectionById(section_id);
            request.setAttribute("listSection", section);

            getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
        }
    }
    private void findChapter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long chapter_id = Long.parseLong(request.getParameter("chapter_id"));
            Chapter chapters = chapter.findChaptersById(chapter_id);

                List<Section> sectionList = chapter.findSectionByIdChapter(chapters.getChapter_id());
            request.setAttribute("chapter", chapters);
            request.setAttribute("Section", sectionList);
            getServletContext().getRequestDispatcher("/WEB-INF/administrator/rewriteStructureCollection.jsp").forward(request, response);
        }
    }
    private void getListSection(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if (ajax) {
            Long chapter_id = Long.parseLong(request.getParameter("chapter_id"));
            Chapter chapters = chapter.findChaptersById(chapter_id);
            List<Section> sections = chapter.findSectionByIdChapter(chapter_id);
            request.setAttribute("chapter", chapters);
            request.setAttribute("ListSection", sections);
            request.getServletContext().getRequestDispatcher("/WEB-INF/administrator/structureCollection.jsp").forward(request, response);
        }
    }
}
