package test;

import main.dao.mapTables;
import main.dao.parameterAndCoefficient;
import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.jboss.logging.Param;

import java.util.ArrayList;
import java.util.List;

public class cloneEx {
    public static void main(String[] args) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        MapTable mapTable = mapTables.findMapTableById(Long.parseLong("1"));

        List<Coefficient> newListCoefficient = new ArrayList<>();
        List<Coefficient> coefficients = parameterAndCoefficient.findCoefficientByIdMap(mapTable.getMapTable_id());

        List<Parameter> newListParameter = new ArrayList<>();
        List<Parameter> listParameter = parameterAndCoefficient.findParametersByIdMapTable(mapTable.getMapTable_id());

        mapTable.setMapTable_id(null);
        mapTable.setListCoefficient(null);

        assert listParameter != null;
        for (Parameter param: listParameter) {
            Parameter newParam = new Parameter();
            newParam.setNameParametr(param.getNameParametr());
            newParam.setStep(param.getStep());

            newListParameter.add(newParam);
            mapTable.setListParameter(newListParameter);
            mapTable.addParametr(newParam);
        }

        assert coefficients != null;

        for (Coefficient newCoefff : coefficients) {

            Coefficient newCoeff = new Coefficient();
            newCoeff.setName(newCoefff.getName());

            List<ValueCoefficient> newListValueCoefficient = new ArrayList<>();
            List<ValueCoefficient> listValueCoefficient = parameterAndCoefficient.findValueCoefficientByIdCoefficient(newCoefff.getId());

            assert listValueCoefficient != null;
            for (ValueCoefficient valCoeff: listValueCoefficient){
                ValueCoefficient newValCoeff = new ValueCoefficient();
                newValCoeff.setValName(valCoeff.getValName());
                newValCoeff.setValue(valCoeff.getValue());

                newListValueCoefficient.add(newValCoeff);
                newCoeff.setCoefficientValue(newListValueCoefficient);
                newCoeff.addCoeffValue(newValCoeff);
            }

            newListCoefficient.add(newCoeff);
            mapTable.setListCoefficient(newListCoefficient);
            mapTable.addCoefficient(newCoeff);

        }


        session.beginTransaction();
        session.merge(mapTable);
        session.getTransaction().commit();
        session.close();
    }
}
