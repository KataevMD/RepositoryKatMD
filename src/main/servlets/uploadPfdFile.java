package main.servlets;

import main.dao.mapTables;
import main.hibernate.HibernateUtil;
import main.model.FileMapTable;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.engine.jdbc.BlobProxy;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "uploadFile", urlPatterns = {"/uploadFileMapTable"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 25,
        location = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\cstrmo\\file")
public class uploadPfdFile extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long mapTable_id = null;
        File fileMapTable = null;
        String nameFileMap = null;
        for (Part part : request.getParts()) {
            InputStream inputStream = part.getInputStream();
            InputStreamReader isr = new InputStreamReader(inputStream);
            if (part.getName().equals("mapTable_id")) {
                String mapId = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
                log(mapId);
                mapTable_id = Long.parseLong(mapId);
            }else if(part.getName().equals("fileName")){
                nameFileMap = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
            } else{

                part.write(part.getSubmittedFileName());
                fileMapTable = new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\cstrmo\\file\\"+part.getSubmittedFileName());
            }
            inputStream.close();
            isr.close();
        }
        FileMapTable fileMap = mapTables.findFileMapTableByMapTable_id(mapTable_id);
        assert fileMapTable != null;
        if (fileMap == null) {
            saveFile(fileMapTable, mapTable_id, nameFileMap);
            Path fileToDelete = Paths.get(fileMapTable.getAbsolutePath());
            Files.delete(fileToDelete);
            String answer = "success";
            response.getWriter().write(answer);
        } else {
            Path fileToDelete = Paths.get(fileMapTable.getAbsolutePath());
            Files.delete(fileToDelete);

            String answer = "fail";
            response.getWriter().write(answer);
        }

    }

    public static void saveFile(File file, Long mapTable_id, String nameFileMap) throws IOException {
        SessionFactory sesFactory = HibernateUtil.getSessionFactory();
        Session sessia = sesFactory.openSession();

        FileMapTable fileMapTable = new FileMapTable();
        fileMapTable.setMapTable_id(mapTable_id);
        fileMapTable.setNameFileMapTable(nameFileMap);
        fileMapTable.setFile(BlobProxy.generateProxy(getFile(file)));

        sessia.getTransaction().begin();
        sessia.merge(fileMapTable);
        sessia.getTransaction().commit();
        sessia.close();

    }

    public static byte[] getFile(File file) throws IOException {
        if (file.exists()) {
            return Files.readAllBytes(Paths.get(file.getPath()));
        }
        return null;
    }
}
