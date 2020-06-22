package main.dao;

import main.hibernate.HibernateUtil;
import main.model.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

public class importMap {
    public static void imp(String path, Section sections, TypeMapTable tTable, TypeTime tTime, Discharge discharge) throws IOException {
        SessionFactory sesFactory = HibernateUtil.getSessionFactory();
        Session sessia = sesFactory.openSession();
        InputStream in = null;
        XSSFWorkbook wb = null;
        try {

            in = new FileInputStream(new File(path));
            wb = new XSSFWorkbook(in);

        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            Sheet coef = wb.getSheetAt(2);

            ArrayList<ValueCoefficient> coeffValueList = null;
            ArrayList<String> sign = new ArrayList<>();

            ArrayList<Parameter> pList = new ArrayList<>();
            ArrayList<Coefficient> lCoefficients = new ArrayList<>();


            ValueCoefficient coefficientValue = null;
            Coefficient coefficient = null;
            MapTable mapTable = new MapTable();

            StringBuilder formulaMapTable = new StringBuilder();

            //Чтение листа "Интерфейс"
            Sheet interf = wb.getSheetAt(0);
            Row row1 = interf.getRow(0);
            Row row2 = interf.getRow(2);

            Cell numberTable = row1.getCell(0);
            Cell nameTableCell = row2.getCell(0);

            mapTable.setName(nameTableCell.getStringCellValue());
            double numberTabl = numberTable.getNumericCellValue();
            int numT = (int) numberTabl;
            String NumT = String.valueOf(numT);
            mapTable.setNumberTable(NumT);


            //Чтение листа "Параметры"
            Sheet param = wb.getSheetAt(1);

            for (int i = 0; i < param.getLastRowNum(); i++) {

                Row row = param.getRow(i);
                Row row3 = param.getRow(i + 1);

                for (int j = 1; j < row.getLastCellNum(); j++) {

                    Cell name = row.getCell(j);
                    Cell step = row3.getCell(j);


                    Parameter parametrs = new Parameter();

                    parametrs.setNameParametr(name.getStringCellValue());
                    parametrs.setStep(step.getNumericCellValue());

                    pList.add(parametrs);
                    mapTable.setListParameter(pList);
                    mapTable.addParametr(parametrs);


                    sessia.save(parametrs);

                    if (j == 1) {
                        formulaMapTable.append(parametrs.getParameter_id()).append("Param").append("^").append(step.getNumericCellValue());
                    } else {
                        formulaMapTable.append("*").append(parametrs.getParameter_id()).append("Param").append("^").append(step.getNumericCellValue());
                    }
                }
            }

            //Чтение листа "Коэффициенты"
            int amountSign = 0;
            for (int i = 1; i <= coef.getLastRowNum(); i++) {
                Row row = coef.getRow(i);
                Row row11 = coef.getRow(i + 1);
                if (row11 == null)
                    continue;

                Cell nameCoeffValue = row.getCell(1);
                Cell nameCoeffCell = row.getCell(0);
                Cell valueCoeffValue = row.getCell(3);
                Cell signs = row.getCell(2);

                if (signs != null && !"".equals(signs.getStringCellValue())) {
                    sign.add(signs.getStringCellValue());
                    amountSign++;
                    formulaMapTable.append(signs.getStringCellValue());
                }

                if (nameCoeffCell != null && !"".equals(nameCoeffCell.getStringCellValue())) {
                    coefficient = new Coefficient();
                    coeffValueList = new ArrayList<>();

                    coefficient.setName(nameCoeffCell.getStringCellValue());
                    sessia.save(coefficient);

                    formulaMapTable.append(coefficient.getId()).append("Coeff");


                }

                if (nameCoeffValue != null && !"".equals(nameCoeffValue.getStringCellValue())) {
                    coefficientValue = new ValueCoefficient();
                    coefficientValue.setValName(nameCoeffValue.getStringCellValue());

                } else {
                    coefficient.setCoefficientValue(coeffValueList);

                    lCoefficients.add(coefficient);
                    mapTable.setListCoefficient(lCoefficients);
                    mapTable.addCoefficient(coefficient);

                    break;
                }

                if (valueCoeffValue != null && !"".equals(valueCoeffValue.getNumericCellValue())) {
                    coefficientValue.setValue(valueCoeffValue.getNumericCellValue());
                    coeffValueList.add(coefficientValue);
                    coefficient.setCoefficientValue(coeffValueList);
                    coefficient.addCoeffValue(coefficientValue);

                    lCoefficients.add(coefficient);
                    mapTable.setListCoefficient(lCoefficients);
                    mapTable.addCoefficient(coefficient);

                    try {
                        Cell cell = row11.getCell(0, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
                        if (cell != null && !"".equals(cell.getStringCellValue())) {
                            coefficient.setCoefficientValue(coeffValueList);
                            coefficient.addCoeffValue(coefficientValue);

                            lCoefficients.add(coefficient);
                            mapTable.setListCoefficient(lCoefficients);
                            mapTable.addCoefficient(coefficient);
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }

                }

            }
            mapTable.setFormula(formulaMapTable.toString());
            mapTable.setSection(sections);
            mapTable.setTypeMapTable(tTable);
            mapTable.setTypeTime(tTime);
            mapTable.setDischarge(discharge);
            sessia.getTransaction().begin();
            sessia.merge(mapTable);
            sessia.getTransaction().commit();
            sessia.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        in.close();
        wb.close();
    }
}
