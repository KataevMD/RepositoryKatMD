package main.servlets;

import main.dao.*;
import main.hibernate.HibernateUtil;
import main.model.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "importMapTable", urlPatterns = {"/importMapTable"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 25,
        location = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\cstrmo\\file")
public class importMapTable extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<File> arrayFile = new ArrayList<>();
        Long section_id = null;
        Long typeTime_id = null;
        Long discharge_id = null;
        Long typeMapTable_id = null;
        File fileMapTable = null;
        String answer = null;
        for (Part part : request.getParts()) {
            if (part.getName().equals("section_id")) {
                InputStream inputStream = part.getInputStream();
                InputStreamReader isr = new InputStreamReader(inputStream);
                String sectionId = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
                section_id = Long.parseLong(sectionId);
                inputStream.close();
            }
            if (part.getName().equals("typeTime_id")) {
                InputStream inputStream = part.getInputStream();
                InputStreamReader isr = new InputStreamReader(inputStream);
                String typeTimeId = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
                typeTime_id = Long.parseLong(typeTimeId);
                inputStream.close();
            }
            if (part.getName().equals("discharge_id")) {
                InputStream inputStream = part.getInputStream();
                InputStreamReader isr = new InputStreamReader(inputStream);
                String dischargeId = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
                discharge_id = Long.parseLong(dischargeId);
                inputStream.close();
            }
            if (part.getName().equals("typeMapTable_id")) {
                InputStream inputStream = part.getInputStream();
                InputStreamReader isr = new InputStreamReader(inputStream);
                String typeMapTableId = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
                typeMapTable_id = Long.parseLong(typeMapTableId);
                inputStream.close();
            }
            if (part.getName().equals("file")) {
                part.write(part.getSubmittedFileName());
                fileMapTable = new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\cstrmo\\file\\" + part.getSubmittedFileName());
                arrayFile.add(fileMapTable);
            }
        }
        Section sections = chapter.findSectionById(section_id);
        TypeTime tTime = typeTime.findTypeTimeById(typeTime_id);
        TypeMapTable tTable = typeMapTable.findTypeMapTableById(typeMapTable_id);
        Discharge discharge = discharges.findDischargeById(discharge_id);
        if (!arrayFile.isEmpty()) {
            for (File file : arrayFile) {
                Path fileToDelete = Paths.get(file.getAbsolutePath());
                importMap.imp(file.getPath(), sections, tTable, tTime, discharge);
                Files.delete(fileToDelete);
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }



}
