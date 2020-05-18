package main.servlets;

import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.dao.collMapTable;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(urlPatterns = "/loadCollforUsers", name = "loadCollforUsers")
public class openMainUser extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<CollectionMapTable> collectionMapTables = collMapTable.findAllCollectionMapTable();

        request.setAttribute("collectionMapTables", collectionMapTables);
        getServletContext().getRequestDispatcher("/WEB-INF/user/mainUsers.jsp").forward(request, response);
    }
}
