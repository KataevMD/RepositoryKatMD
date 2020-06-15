package main.dao;

import main.hibernate.HibernateUtil;
import main.model.CollectionMapTable;
import main.model.MapTable;
import main.model.TypeTime;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class typeTime {

    public static List<TypeTime> findAllTypeTime() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<TypeTime> criteria = builder.createQuery(TypeTime.class);
        Root<TypeTime> root = criteria.from(TypeTime.class);
        criteria.select(root);
        session.beginTransaction();
        List<TypeTime> listType = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!listType.isEmpty()) {
            return listType;
        }
        return null;
    }

    public static TypeTime findTypeTimeById(Long typeTime_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<TypeTime> typeTimes;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<TypeTime> criteria = builder.createQuery(TypeTime.class);
        Root<TypeTime> root = criteria.from(TypeTime.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("typeTime_id"), typeTime_id));

        session.beginTransaction();
        typeTimes = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<TypeTime> it = typeTimes.iterator();


        return it.next();
    }
}
