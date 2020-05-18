<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 18.05.2020
  Time: 18:23
  To change this template use File | Settings | File Templates.
--%>

<?xml version="1.0" encoding="UTF-8"?>
<%@page contentType="application/xml" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="mapTable" class="col hidden">
    <data>
        <table id="tableMapTable" class="table table-bordered container text-left">
            <thead class="thead-light">
                <tr>
                    <th class="w-7p5">Параметр</th>
                    <th class="w-75">Степень</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="param" items="${Parametr}">
                    <tr>
                        <td><c:out value='${param.nameParametr}' default="fgddfed"/></td>
                        <td>${param.step}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </data>
</div>
