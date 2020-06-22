package main.servlets;

import main.dao.mapTables;
import main.model.FileMapTable;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;

import org.apache.poi.util.IOUtils;

@WebServlet(name = "downloadFile", urlPatterns = {"/downloadFile"})
public class downloadPdfFile extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    //Процедура получения бумажного представления карты нормирования из базы данных, с его последующей отправкой пользователю
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Long mapTable_id = Long.parseLong(request.getParameter("mapTable_id"));
        FileMapTable fileMap = mapTables.findFileMapTableByMapTable_id(mapTable_id);

        if (fileMap != null) {
            Blob fileBlob = fileMap.getFile();
            File pdf = new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\cstrmo\\file\\" + fileMap.getNameFileMapTable() + ".pdf");
            FileOutputStream fileOutputStream = new FileOutputStream(pdf);
            try {
                IOUtils.copy(fileBlob.getBinaryStream(), fileOutputStream);

            } catch (SQLException e) {
                e.printStackTrace();
            }

            FileInputStream inStream = new FileInputStream(pdf);

            // obtains ServletContext
            ServletContext context = getServletContext();

            // gets MIME type of the file // Тип данных передаваемых по сети Интернет
            String mimeType = context.getMimeType(pdf.getAbsolutePath());
            if (mimeType == null) {
                // set to binary type if MIME mapping not found // Установка типа данных по умолчанию
                mimeType = "application/pdf";
            }


            // modifies response // Модификация ответа, путем установление типа отправляемых данных
            response.setContentType(mimeType);
            response.setContentLength((int) pdf.length());

            // forces download
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", pdf.getName());
            response.setHeader(headerKey, headerValue);

            // obtains response's output stream
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            fileOutputStream.close();
            inStream.close();
            outStream.close();

            Path fileToDelete = Paths.get(pdf.getAbsolutePath());
            Files.delete(fileToDelete);
            String answer = "success";
            response.getWriter().write(answer);
        }


    }
}
