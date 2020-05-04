package servlets;

import hibernate.HibernateUtil;
import model.CollectionMapTable;
import dao.collMapTable;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(urlPatterns = "/loadCollforUsers", name = "loadCollforUsers")
public class indexServlet extends HttpServlet {
    private SessionFactory sessionFactory;
    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        sessionFactory = HibernateUtil.getSessionFactory();

        List<CollectionMapTable> collectionMapTables = collMapTable.FindColl();

        request.setAttribute("collectionMapTables", collectionMapTables);
        getServletContext().getRequestDispatcher("/mainUsers.jsp").forward(request, response);
    }
}
