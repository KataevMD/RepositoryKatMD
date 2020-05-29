<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 24.04.2020
  Time: 23:41
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
        <%@include file="/WEB-INF/js/mapTable.js" %>
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
    <div class="container-fluid w-75">
        <div class="container text-center">
            <p class="h4 mt-auto">Список карт трудового нормирования справочника "${nameCollMapTable}"</p>
        </div>
        <br>
        <table id="tableMapTable" class="table table-hover table-responsive text-left">
            <thead class="thead-light">
            <tr class='table-filters'>
                <td class="border-0">
                </td>
                <td class="border-0">
                    Название карты: <label>
                    <input type="text"/>
                </label>
                </td>
            </tr>
            <tr>
                <th>№ таблицы</th>
                <th>Название карты</th>
                <th>Формула</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="MapTable" items="${MapTables}">
                <tr id="tr_<c:out value="${MapTable.mapTable_id}"/>" class='table-data'>
                    <td><c:out value="${MapTable.numberTable}"/></td>
                    <td><c:out value="${MapTable.name}"/></td>
                    <td><c:out value="${MapTable.formul}"/></td>
                    <td><a href="" class="btn btn-light">Просмотреть</a>
                    <td>
                        <button class="btn btn-light " id="viewUpdate"
                                onclick="viewUpdateMap(<c:out value="${MapTable.mapTable_id}"/>)">
                            Редактировать
                        </button>
                    </td>
                    <td>
                        <button type="button" id="delete"
                                onclick="deleteMapTableById(<c:out value="${MapTable.mapTable_id}"/>)"
                                class="btn btn-light">Удалить
                        </button>
                    </td>
                </tr>
                <tr id="map_<c:out value="${MapTable.mapTable_id}"/>" hidden class="table-active">
                    <td>
                        <label class="w-100">
                            <input id="numberMap_<c:out value="${MapTable.numberTable}"/>"
                                   value="<c:out value="${MapTable.numberTable}"/>"
                                   pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                        </label>
                    </td>
                    <td>
                        <label class="w-100">
                            <input id="nameMap_<c:out value="${MapTable.mapTable_id}"/>"
                                   value="<c:out value="${MapTable.name}"/>"
                                   pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                        </label>
                    </td>
                    <td>
                        <label class="w-100">
                            <input id="formulMap_<c:out value="${MapTable.mapTable_id}"/>"
                                   value="<c:out value="${MapTable.formul}"/>"
                                   pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control" required>
                        </label>
                    </td>
                    <td>
                        <button class="btn btn-primary"
                                onclick="updateMap(<c:out value="${MapTable.mapTable_id}"/>)">Сохранить
                        </button>
                    </td>
                    <td>
                        <button class="btn btn-secondary"
                                onclick="closeUpdateMap(<c:out value="${MapTable.mapTable_id}"/>)">Отмена
                        </button>
                    </td>
                    <td></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
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
