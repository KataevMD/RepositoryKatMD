package main.dao;

import main.hibernate.HibernateUtil;
import main.model.Parameter;
import main.model.ValueCoefficient;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.List;

public class parameterAndCoefficient {

    public static List<ValueCoefficient> findValueCoefficientByIdCoefficient(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<ValueCoefficient> valueCoefficients= session.createQuery("from ValueCoefficient v where v.coefficient.coefficient_id = " + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!valueCoefficients.isEmpty()) {
            return valueCoefficients;
        }
        return null;
    }
    public static List<Parameter> findParametersByIdMapTable(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<Parameter> parameters = session.createQuery("from Parameter p where p.mapTable.mapTable_id = " + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!parameters.isEmpty()) {
            return parameters;
        }
        return null;
    }
}
