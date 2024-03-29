package main.dao;

import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
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

    public static boolean rewriteMapTable(String nameMapTable, Long mapTable_id, String numberTable, String formulasList, Long type_id, Long discharge_id, Long typeTime_id) {
        MapTable mapTable = findMapTableById(mapTable_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (mapTable != null) {

            Discharge discharge = discharges.findDischargeById(discharge_id);
            TypeTime typeTimes = typeTime.findTypeTimeById(typeTime_id);
            TypeMapTable typeMapTable = main.dao.typeMapTable.findTypeMapTableById(type_id);

            mapTable.setName(nameMapTable);
            mapTable.setNumberTable(numberTable);
            mapTable.setTypeMapTable(typeMapTable);
            mapTable.setTypeTime(typeTimes);
            mapTable.setDischarge(discharge);


            mapTable.setFormula(formulasList);

            session.getTransaction().begin();
            session.update(mapTable);
            session.getTransaction().commit();
            session.close();

            return true;
        }
        session.close();
        return false;
    }

    public static boolean createMapTable(Long section_id, String nameMapTable, String numberTable, Long type_id, Long discharge_id, Long typeTime_id) {
        Section section = chapter.findSectionById(section_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (section != null) {

            Discharge discharge = discharges.findDischargeById(discharge_id);
            TypeTime typeTimes = typeTime.findTypeTimeById(typeTime_id);
            TypeMapTable typeMapTable = main.dao.typeMapTable.findTypeMapTableById(type_id);
            MapTable mapTable = new MapTable();

            mapTable.setName(nameMapTable);
            mapTable.setNumberTable(numberTable);
            mapTable.setTypeMapTable(typeMapTable);
            mapTable.setTypeTime(typeTimes);
            mapTable.setDischarge(discharge);
            mapTable.setSection(section);

            session.getTransaction().begin();
            session.merge(mapTable);
            session.getTransaction().commit();
            session.close();

            return true;
        }
        session.close();
        return false;
    }

    public static boolean deleteFileByIdMapTable(Long mapTable_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        FileMapTable fileMapTable = findFileMapTableByMapTable_id(mapTable_id);
        if (fileMapTable != null) {
            session.beginTransaction();
            session.delete(fileMapTable);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        return false;
    }

    public static void cloneableMapTable(Long mapTable_id, Long section_id) {

        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        MapTable mapTable = mapTables.findMapTableById(mapTable_id);

        Section section = chapter.findSectionById(section_id);
        List<Coefficient> newListCoefficient = new ArrayList<>();
        List<Coefficient> coefficients = parameterAndCoefficient.findCoefficientByIdMap(mapTable.getMapTable_id());

        List<Parameter> newListParameter = new ArrayList<>();
        List<Parameter> listParameter = parameterAndCoefficient.findParametersByIdMapTable(mapTable.getMapTable_id());

        mapTable.setMapTable_id(null);
        mapTable.setListCoefficient(null);

        if (listParameter != null) {
            for (Parameter param : listParameter) {
                Parameter newParam = new Parameter();
                newParam.setNameParametr(param.getNameParametr());
                newParam.setStep(param.getStep());

                newListParameter.add(newParam);
                mapTable.setListParameter(newListParameter);
                mapTable.addParametr(newParam);
            }
        }

        if (coefficients != null) {
            for (Coefficient newCoefff : coefficients) {

                Coefficient newCoeff = new Coefficient();
                newCoeff.setName(newCoefff.getName());

                List<ValueCoefficient> newListValueCoefficient = new ArrayList<>();
                List<ValueCoefficient> listValueCoefficient = parameterAndCoefficient.findValueCoefficientByIdCoefficient(newCoefff.getId());

                if (listValueCoefficient != null) {
                    for (ValueCoefficient valCoeff : listValueCoefficient) {
                        ValueCoefficient newValCoeff = new ValueCoefficient();
                        newValCoeff.setValName(valCoeff.getValName());
                        newValCoeff.setValue(valCoeff.getValue());

                        newListValueCoefficient.add(newValCoeff);
                        newCoeff.setCoefficientValue(newListValueCoefficient);
                        newCoeff.addCoeffValue(newValCoeff);
                    }
                }
                newListCoefficient.add(newCoeff);
                mapTable.setListCoefficient(newListCoefficient);
                mapTable.addCoefficient(newCoeff);

            }
        }
        mapTable.setSection(section);
        session.beginTransaction();
        session.merge(mapTable);
        session.getTransaction().commit();
        session.close();
    }


}
