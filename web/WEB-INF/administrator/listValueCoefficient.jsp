<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 31.05.2020
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<?xml version="1.0" encoding="UTF-8"?>
<%@page contentType="application/xml" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<data value="125151515">
    <table id="tableCoefficientValue" class="table table-hover table-responsive text-left">
        <thead class="thead-light">
            <tr>
                <th>№ таблицы</th>
                <th>Название значения коэффициента</th>
                <th>Значение</th>
                <th class="text-center" colspan="2">Управление</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="valueCoefficient" items="${ValueCoefficient}">
                <tr id="tr_<c:out value="${valueCoefficient.coeffValue_id}"/>">
                    <td><c:out value="${valueCoefficient.valName}"/></td>
                    <td><c:out value="${valueCoefficient.value}"/></td>
                    <td>
                        <button class="btn btn-light " id="viewUpdateValueCoeff"
                                onclick="viewUpdateValueCoeff(<c:out value="${valueCoefficient.coeffValue_id}"/>)"
                        >Редактировать
                        </button>
                    </td>
                    <td>
                        <button type="button" id="deleteValueCoeff"
                                onclick="deleteValueCoefficientById(<c:out value="${valueCoefficient.coeffValue_id}"/>)"
                                class="btn btn-light">Удалить
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</data>
