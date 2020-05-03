package dao;

import hibernate.HibernateUtil;
import model.CollectionMapTable;
import model.MapTable;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.*;
import java.util.List;

public class collMapTableDAO {
    private static List<MapTable> MapTables;

    public collMapTableDAO(){}

    public static List<MapTable> FindMap(Long id){
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        MapTables = session.createQuery("from MapTable m where m.collectionMapTable.collection_id=" + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if(!MapTables.isEmpty()){
            return MapTables;
        }
            return null;

    }
}
