package dao;

import hibernate.HibernateUtil;
import model.CollectionMapTable;
import model.MapTable;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.*;
import java.util.List;

public class collMapTable {
    private static List<MapTable> MapTables;
    private static List<CollectionMapTable> collectionMapTables;

    public collMapTable(){}

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

    public static List<CollectionMapTable> FindColl(){
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<CollectionMapTable> criteria = builder.createQuery(CollectionMapTable.class);
        Root<CollectionMapTable> root = criteria.from( CollectionMapTable.class );
        criteria.select( root );
        session.beginTransaction();
        collectionMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if(!collectionMapTables.isEmpty()){
            return collectionMapTables;
        }
        return null;

    }
}
