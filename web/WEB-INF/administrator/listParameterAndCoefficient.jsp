<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 31.05.2020
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Единая база нормативов технологических операций</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <style>
        <%@include file="/WEB-INF/css/offcanvas.css" %>
    </style>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script>
        <%@include file="/WEB-INF/js/coefficientAndParameters.js" %>
    </script>
</head>
<body class="d-flex flex-column h-100">
<%
    Cookie[] cookies = request.getCookies();
    String userName = "";
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("cookuser")) {
                userName = cookie.getValue();
            }
        }
    }
%>
<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link " href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false"
                >Уч.записи
                    администраторов</a>
                <div class="dropdown-menu" aria-labelledby="dropdown03">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openListAdminPage">Просмотр
                        уч.записей</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openRegisterAdmins">Добавить
                        уч.запись</a>
                </div>
            </li>
        </ul>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle"
               href="${pageContext.request.contextPath}/logout"><%=userName%>
                (Выйти)</a>
        </div>
    </div>
</nav>

<main role="main" class="flex-shrink-0">
    <br>
    <div class="container text-center">
        <p class="h4 mt-auto">Карта "${nameMapTable}"</p>
    </div>
    <br><label for="mapTable_id"></label><input id="mapTable_id" value="${mapTable_Id}" hidden>
    <div class="container text-center">
    <div class="row">
        <div class="col">
            <div class="container-fluid w-100">
                <table id="tableParameter" class="table table-hover table-responsive text-left">
                    <thead class="thead-light">
                    <tr>
                        <th>Название параметра</th>
                        <th>Значение степени</th>
                        <th class="text-center" colspan="2">Управление</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="parameter" items="${Parameter}">
                        <tr id="param_<c:out value="${parameter.parameter_id}"/>">
                            <td><c:out value="${parameter.nameParametr}"/></td>
                            <td><c:out value="${parameter.step}"/></td>
                            <td>
                                <button class="btn btn-light "
                                        onclick="viewUpdateParameter(<c:out value="${parameter.parameter_id}"/>)">
                                    Редактировать
                                </button>
                            </td>
                            <td>
                                <button type="button"
                                        onclick="deleteParameterById(<c:out value="${parameter.parameter_id}"/>)"
                                        class="btn btn-light">Удалить
                                </button>
                            </td>
                        </tr>
                        <tr id="updateParam_<c:out value="${parameter.parameter_id}"/>" hidden class="table-active">
                            <td>
                                <label class="w-100">
                                    <input id="nameParam_<c:out value="${parameter.parameter_id}"/>"
                                           value="<c:out value="${parameter.nameParametr}"/>"
                                           pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                                </label>
                            </td>
                            <td>
                                <label class="w-100">
                                    <input id="stepParam_<c:out value="${parameter.parameter_id}"/>"
                                           value="<c:out value="${parameter.step}"/>"
                                           type="text" class="form-control " required>
                                </label>
                            </td>
                            <td>
                                <button class="btn btn-primary"
                                        onclick="updateParameter(<c:out value="${parameter.parameter_id}"/>)">Сохранить
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-secondary"
                                        onclick="closeUpdateParameter(<c:out value="${parameter.parameter_id}"/>)">Отмена
                                </button>
                            </td>
                            <td></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col">
            <div class="container-fluid w-100">
                <table id="tableCoefficient" class="table table-hover table-responsive text-left">
                    <thead class="thead-light">
                    <tr>
                        <th>№</th>
                        <th class="w-50" >Название коэффициента</th>
                        <th class="text-center" colspan="2">Управление</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="coefficient" items="${Coefficient}">
                        <tr id="coeff_<c:out value="${coefficient.coefficient_id}"/>">
                            <td><c:out value="${coefficient.coefficient_id}"/></td>
                            <td class="w-50" ><c:out value="${coefficient.name}"/></td>
                            <td>
                                <button class="btn btn-light " id="viewValueCoeff"
                                        onclick="getValueCoeff(<c:out value="${coefficient.coefficient_id}"/>)">
                                    Просмотреть значения
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-light " id="viewUpdate"
                                        onclick="viewUpdateCoeff(<c:out value="${coefficient.coefficient_id}"/>)">
                                    Редактировать
                                </button>
                            </td>
                            <td>
                                <button type="button" id="delete"
                                        onclick="deleteCoefficientById(<c:out value="${coefficient.coefficient_id}"/>)"
                                        class="btn btn-light">Удалить
                                </button>
                            </td>
                        </tr>
                        <tr id="updateCoeff_<c:out value="${coefficient.coefficient_id}"/>" hidden class="table-active">
                            <td></td>
                            <td>
                                <label class="w-100">
                                    <input id="nameCoeff_<c:out value="${coefficient.coefficient_id}"/>"
                                           value="<c:out value="${coefficient.name}"/>"
                                           pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                                </label>
                            </td>
                            <td>
                                <button class="btn btn-primary"
                                        onclick="updateCoefficient(<c:out value="${coefficient.coefficient_id}"/>)">Сохранить
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-secondary"
                                        onclick="closeUpdateCoefficient(<c:out value="${coefficient.coefficient_id}"/>)">Отмена
                                </button>
                            </td>
                            <td></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="tableValCoeff" class="container-fluid w-100">
                <br>
                <%--        <jsp:include page="listValueCoefficient.jsp"/>--%>
                <data value="125151515">
                    <table id="tableCoefficientValue" class="table table-hover table-responsive text-left">
                        <thead class="thead-light">
                        <tr>
                            <th>Название значения коэффициента</th>
                            <th>Значение</th>
                            <th class="text-center" colspan="2">Управление</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="valueCoefficient" items="${ValueCoefficient}">
                            <tr id="valCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>">
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
                            <tr id="updateValueCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>" hidden class="table-active">
                                <td>
                                    <label class="w-100">
                                        <input id="nameValueCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>"
                                               value="<c:out value="${valueCoefficient.valName}"/>"
                                               pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <label class="w-100">
                                        <input id="valValueCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>"
                                               value="<c:out value="${valueCoefficient.value}"/>"
                                               type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <button class="btn btn-primary"
                                            onclick="updateValueCoeff(<c:out value="${valueCoefficient.coeffValue_id}"/>)">Сохранить
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-secondary"
                                            onclick="closeUpdateValueCoeff(<c:out value="${valueCoefficient.coeffValue_id}"/>)">Отмена
                                    </button>
                                </td>
                                <td></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </data>
            </div>
        </div>
    </div>


</main>
<footer class="footer py-3 mt-auto bg-dark ">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>

</body>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script>
    <%@include file="/WEB-INF/js/offcanvas.js" %>
    <%@include file="/WEB-INF/js/filters.js" %>
</script>
</html>
