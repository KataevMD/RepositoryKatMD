package main.dao;

import main.hibernate.HibernateUtil;
import main.model.MapTable;
import main.model.TypeMapTable;
import main.model.TypeTime;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class typeMapTable {

    public static List<TypeMapTable> findAllTypeMapTable() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<TypeMapTable> criteria = builder.createQuery(TypeMapTable.class);
        Root<TypeMapTable> root = criteria.from(TypeMapTable.class);
        criteria.select(root);
        session.beginTransaction();
        List<TypeMapTable> listTypeMap = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!listTypeMap.isEmpty()) {
            return listTypeMap;
        }
        return null;
    }

    public static TypeMapTable findTypeMapTableById(Long type_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<TypeMapTable> typeMapTables;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<TypeMapTable> criteria = builder.createQuery(TypeMapTable.class);
        Root<TypeMapTable> root = criteria.from(TypeMapTable.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("type_id"), type_id));

        session.beginTransaction();
        typeMapTables = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<TypeMapTable> it = typeMapTables.iterator();


        return it.next();
    }
}
