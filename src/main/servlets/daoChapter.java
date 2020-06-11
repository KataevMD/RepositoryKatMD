package main.servlets;

import main.dao.chapter;
import main.dao.collMapTable;
import main.dao.mapTables;
import main.model.MapTable;
import main.model.Section;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDaoChapter", urlPatterns = {"/getSection"})
public class daoChapter extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        switch (action) {
            case "/getSection":
                getSection(request, response);
                break;
        }
    }

    private void getSection(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if(ajax) {
            Long id = Long.parseLong(request.getParameter("chapter_id[]"));
            List<Section> sections = chapter.findSectionByIdChapter(id);

            request.setAttribute("Section", sections);
            request.getServletContext().getRequestDispatcher("/WEB-INF/administrator/TestJSTree.jsp").forward(request, response);
        }
    }
}
