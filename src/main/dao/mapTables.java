package main.dao;

import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.FileMapTable;
import main.model.MapTable;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class mapTables {

    public static FileMapTable findFileMapTableByMapTable_id(Long mapTable_id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<FileMapTable> criteria = builder.createQuery(FileMapTable.class);
        Root<FileMapTable> root = criteria.from(FileMapTable.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("mapTable_id"), mapTable_id));

        session.beginTransaction();
        List<FileMapTable> fileMapTablesList = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        Iterator<FileMapTable> it = fileMapTablesList.iterator();

        if (it.hasNext()) {
            return it.next();
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
        session.close();

        Iterator<MapTable> it = MapTables.iterator();


            return it.next();

    }

    public static boolean deleteMapTableById(Long mapTable_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        MapTable map = findMapTableById(mapTable_id);
        if (map != null) {
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
        if (mapTable != null) {
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

    public static void createMapTable(String nameMapTable, String formul, String numberTable, Long collection_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        MapTable mapTable = new MapTable();
        mapTable.setFormul(formul);
        mapTable.setName(nameMapTable);
        mapTable.setNumberTable(numberTable);

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<CollectionMapTable> criteria = builder.createQuery(CollectionMapTable.class);
        Root<CollectionMapTable> root = criteria.from(CollectionMapTable.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("collection_id"), collection_id));

        session.beginTransaction();
        List<CollectionMapTable> collectionMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();


        Iterator<CollectionMapTable> it = collectionMapTables.iterator();

        if (it.hasNext()) {

            CollectionMapTable collectionMapTable = it.next();
            collectionMapTable.addMapTable(mapTable);
            session.beginTransaction();
            session.merge(collectionMapTable);
            session.getTransaction().commit();
            session.close();
        }
    }

    public static boolean deleteFileByIdMapTable(Long mapTable_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        FileMapTable fileMapTable = findFileMapTableByMapTable_id(mapTable_id);
        if(fileMapTable!=null){
            session.beginTransaction();
            session.delete(fileMapTable);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        return false;
    }
}
