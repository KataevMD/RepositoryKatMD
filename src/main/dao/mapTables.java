package main.dao;

import main.hibernate.HibernateUtil;
import main.model.Coefficient;
import main.model.MapTable;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class mapTables {

    public static List<Coefficient> findCoefficientByIdMap(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<Coefficient> coefficients = session.createQuery("from Coefficient c where c.mapTable.mapTable_id=" + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!coefficients.isEmpty()) {
            return coefficients;
        }
        return null;

    }

    public static MapTable findMapTableById(Long mapTable_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<MapTable> MapTables;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<MapTable> criteria = builder.createQuery(MapTable.class);
        Root<MapTable> root = criteria.from(MapTable.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("mapTable_id"), mapTable_id));

        session.beginTransaction();
        MapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();


        Iterator<MapTable> it = MapTables.iterator();
        session.close();
        if (it.hasNext()) {
            return it.next();
        }
        return null;
    }

    public static boolean deleteMapTableById(Long mapTable_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        MapTable map = findMapTableById(mapTable_id);
        if(map!=null){
            session.getTransaction().begin();
            session.delete(map);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean rewriteMapTable(String nameMapTable, Long mapTable_id, String numberTable, String formul) {
        MapTable mapTable = findMapTableById(mapTable_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if(mapTable!=null){
            mapTable.setFormul(formul);
            mapTable.setName(nameMapTable);
            mapTable.setNumberTable(numberTable);
            session.getTransaction().begin();
            session.update(mapTable);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }
}
