package main.dao;

import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.MapTable;
import main.model.Parameter;
import main.model.UsersAdmin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.*;
import java.util.Iterator;
import java.util.List;

public class collMapTable {

    public collMapTable() {
    }

    public static List<MapTable> findMapByIdColl(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<MapTable> MapTables = session.createQuery("from MapTable m where m.collectionMapTable.collection_id=" + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!MapTables.isEmpty()) {
            return MapTables;
        }
        return null;

    }

    public static List<CollectionMapTable> findAllCollectionMapTable() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<CollectionMapTable> criteria = builder.createQuery(CollectionMapTable.class);
        Root<CollectionMapTable> root = criteria.from(CollectionMapTable.class);
        criteria.select(root);
        session.beginTransaction();
        List<CollectionMapTable> collectionMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!collectionMapTables.isEmpty()) {
            return collectionMapTables;
        }
        return null;
    }

    public static void createCollMapTable(String nameCollMapTable) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        CollectionMapTable collectionMapTable = new CollectionMapTable();
        collectionMapTable.setNameCollectionMapTable(nameCollMapTable);
        session.getTransaction().begin();// Начало транзакции
        session.merge(collectionMapTable);// Загрузка объекта collectionMapTable класса CollectionMapTable в базу данных
        session.getTransaction().commit();// Конец транзакции
        session.close();
    }

    public static void deleteCollMapTableById(Long collection_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<CollectionMapTable> collectionMapTables;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<CollectionMapTable> criteria = builder.createQuery(CollectionMapTable.class);
        Root<CollectionMapTable> root = criteria.from(CollectionMapTable.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("collection_id"), collection_id));

        session.beginTransaction();
        collectionMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();


        Iterator<CollectionMapTable> it = collectionMapTables.iterator();

        if (it.hasNext()) {
            CollectionMapTable collectionMapTable = it.next();
            session.getTransaction().begin();
            session.delete(collectionMapTable);
            session.getTransaction().commit();
            session.close();
        }
    }

    public static void rewriteCollMapTable(String nameCollMapTable, Long collection_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        CollectionMapTable collectionMapTable = new CollectionMapTable();
        collectionMapTable.setCollection_id(collection_id);
        collectionMapTable.setNameCollectionMapTable(nameCollMapTable);
        session.getTransaction().begin();
        session.update(collectionMapTable);
        session.getTransaction().commit();
        session.close();
    }

    public static CollectionMapTable findCollectionMapTableById(Long collection_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<CollectionMapTable> collectionMapTables;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<CollectionMapTable> criteria = builder.createQuery(CollectionMapTable.class);
        Root<CollectionMapTable> root = criteria.from(CollectionMapTable.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("collection_id"), collection_id));

        session.beginTransaction();
        collectionMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();


        Iterator<CollectionMapTable> it = collectionMapTables.iterator();
        CollectionMapTable collectionMapTable = null;
        if (it.hasNext()) {
            collectionMapTable = it.next();

        }return collectionMapTable;
    }
}
