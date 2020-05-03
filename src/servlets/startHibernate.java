package servlets;

import hibernate.HibernateUtil;
import org.hibernate.SessionFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class startHibernate implements ServletContextListener {
    private SessionFactory sessionFactory;
    @Override
    public void contextDestroyed(ServletContextEvent arg0) {
        if(sessionFactory != null){
            sessionFactory.close();
        }

    }

    //Run this before web application is started
    @Override
    public void contextInitialized(ServletContextEvent arg0) {
        ServletContext ctx = arg0.getServletContext();
        sessionFactory = HibernateUtil.getSessionFactory();

    }
}
