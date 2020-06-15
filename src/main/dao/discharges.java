package main.dao;

import main.hibernate.HibernateUtil;
import main.model.Discharge;
import main.model.MapTable;
import main.model.TypeMapTable;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class discharges {

    public static List<Discharge> findAllDischarge() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Discharge> criteria = builder.createQuery(Discharge.class);
        Root<Discharge> root = criteria.from(Discharge.class);
        criteria.select(root);
        session.beginTransaction();
        List<Discharge> dischargeList = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!dischargeList.isEmpty()) {
            return dischargeList;
        }
        return null;
    }

    public static Discharge findDischargeById(Long discharge_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<Discharge> dischargeList;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Discharge> criteria = builder.createQuery(Discharge.class);
        Root<Discharge> root = criteria.from(Discharge.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("discharge_id"), discharge_id));

        session.beginTransaction();
        dischargeList = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<Discharge> it = dischargeList.iterator();


        return it.next();
    }
}
