package main.dao;

import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class parameterAndCoefficient {

    public static List<ValueCoefficient> findValueCoefficientByIdCoefficient(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        List<ValueCoefficient> valueCoefficients = session.createQuery("from ValueCoefficient v where v.coefficient.coefficient_id = " + id).getResultList();
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
    public static void createParameter(Long mapTable_id, String nameParameter, Double step) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        MapTable mapTable = mapTables.findMapTableById(mapTable_id);

        Parameter parameter = new Parameter();
        parameter.setNameParametr(nameParameter);
        parameter.setStep(step);

        parameter.setMapTable(mapTable);
        session.beginTransaction();
        session.merge(parameter);
        session.getTransaction().commit();
        session.close();

    }

    public static void createCoefficient(Long mapTable_id, String nameCoefficient) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        MapTable mapTable = mapTables.findMapTableById(mapTable_id);;

        Coefficient coefficient = new Coefficient();
        coefficient.setName(nameCoefficient);
        coefficient.setMapTable(mapTable);

        session.beginTransaction();
        session.merge(coefficient);
        session.getTransaction().commit();
        session.close();

    }

    public static void createValueCoefficient(Long coefficient_id, String valName, Double value) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        ValueCoefficient valueCoefficient = new ValueCoefficient();
        valueCoefficient.setValName(valName);
        valueCoefficient.setValue(value);

        Coefficient coefficient = parameterAndCoefficient.findCoefficientById(coefficient_id);

        valueCoefficient.setCoefficient(coefficient);
        session.beginTransaction();
        session.merge(valueCoefficient);
        session.getTransaction().commit();
        session.close();
    }

    public static Coefficient findCoefficientById(Long coefficient_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<Coefficient> coefficientList;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Coefficient> criteria = builder.createQuery(Coefficient.class);
        Root<Coefficient> root = criteria.from(Coefficient.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("coefficient_id"), coefficient_id));

        session.beginTransaction();
        coefficientList = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<Coefficient> it = coefficientList.iterator();
        return it.next();
    }

    public static Parameter findParameterById(Long parameter_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<Parameter> parameters;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Parameter> criteria = builder.createQuery(Parameter.class);
        Root<Parameter> root = criteria.from(Parameter.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("parameter_id"), parameter_id));

        session.beginTransaction();
        parameters = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<Parameter> it = parameters.iterator();
        return it.next();
    }

    public static ValueCoefficient findValueCoefficientById(Long coeffValue_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<ValueCoefficient> valueCoefficients;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<ValueCoefficient> criteria = builder.createQuery(ValueCoefficient.class);
        Root<ValueCoefficient> root = criteria.from(ValueCoefficient.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("coeffValue_id"), coeffValue_id));

        session.beginTransaction();
        valueCoefficients = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<ValueCoefficient> it = valueCoefficients.iterator();
        return it.next();
    }

    public static boolean deleteParameterById(Long parameter_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Parameter parameter = findParameterById(parameter_id);
        if (parameter != null) {
            session.getTransaction().begin();
            session.delete(parameter);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean deleteCoefficientById(Long coefficient_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Coefficient coefficient = findCoefficientById(coefficient_id);
        if (coefficient != null) {
            session.getTransaction().begin();
            session.delete(coefficient);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean deleteValueCoefficientById(Long coeffValue_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        ValueCoefficient valueCoefficient = findValueCoefficientById(coeffValue_id);
        if (valueCoefficient != null) {
            session.getTransaction().begin();
            session.delete(valueCoefficient);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean rewriteParameter(String nameParameter, Long parameter_id, Double step) {
        Parameter parameter = findParameterById(parameter_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (parameter != null) {
            parameter.setStep(step);
            parameter.setNameParametr(nameParameter);
            session.getTransaction().begin();
            session.update(parameter);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean rewriteCoefficient(String nameCoefficient, Long coefficient_id) {
        Coefficient coefficient = findCoefficientById(coefficient_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (coefficient != null) {
            coefficient.setName(nameCoefficient);
            session.getTransaction().begin();
            session.update(coefficient);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean rewriteValueCoefficient(String valName, Double value, Long coeffValue_id) {
        ValueCoefficient valueCoefficient = findValueCoefficientById(coeffValue_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (valueCoefficient!= null) {
            valueCoefficient.setValue(value);
            valueCoefficient.setValName(valName);
            session.getTransaction().begin();
            session.update(valueCoefficient);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }



    public static Parameter findParametersById(Long parameter_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<Parameter> parameters;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Parameter> criteria = builder.createQuery(Parameter.class);
        Root<Parameter> root = criteria.from(Parameter.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("parameter_id"), parameter_id));

        session.beginTransaction();
        parameters = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<Parameter> it = parameters.iterator();
        return it.next();
    }
}
