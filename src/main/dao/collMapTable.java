package main.dao;

import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.MapTable;
import main.model.Parameter;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.*;
import java.util.List;

public class collMapTable {

    public collMapTable(){}

    public static List<MapTable> findMapByIdColl(Long id){
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        List<MapTable> MapTables = session.createQuery("from MapTable m where m.collectionMapTable.collection_id=" + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if(!MapTables.isEmpty()){
            return MapTables;
        }
            return null;

    }

    public static List<CollectionMapTable> findAllCollectionMapTable(){
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<CollectionMapTable> criteria = builder.createQuery(CollectionMapTable.class);
        Root<CollectionMapTable> root = criteria.from( CollectionMapTable.class );
        criteria.select( root );
        session.beginTransaction();
        List<CollectionMapTable> collectionMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if(!collectionMapTables.isEmpty()){
            return collectionMapTables;
        }
        return null;
    }

    public static List<Parameter> findParamByIdMap(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<Parameter> parameters = session.createQuery("from Parameter p where p.mapTable.mapTable_id = " + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if(!parameters.isEmpty()){
            return parameters;
        }
        return null;
    }
}
