<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 29.03.2020
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Единая база нормативов технологических операций</title>
    <link rel="shortcut icon" href="http://localhost:8081/cstrmo/img/favicon.png" type="image/png">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- Custom styles for this template -->

    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css" >
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/mainTable.css" >
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script src="http://localhost:8081/cstrmo/js/offcanvas.js">
    </script>
    <script src="http://localhost:8081/cstrmo/js/accAdmin.js">
    </script>
</head>
<body class="d-flex flex-column h-100">
<%
    Cookie[] cookies = request.getCookies();
    String userName = "", password = "", rememberVal = "";
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("cookuser")) {
                //userName = new String(Base64.getDecoder().decode(cookie.getValue()));
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
                <a class="nav-link" href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false"
                >Уч.записи администраторов</a>
                <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item active" href="${pageContext.request.contextPath}/openListAdminPage">Просмотр
                        учетных записей</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openRegisterAdmins">Добавить
                        учетных запись</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/openImportPage">Импорт карт</a>
            </li>
        </ul>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle" style="margin-right: 10px;"
               href="${pageContext.request.contextPath}/myAccount">Личный кабинет</a>
        </div>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle"
               href="${pageContext.request.contextPath}/logout"><%=userName%>
                (Выйти)</a>
        </div>
    </div>
</nav>
<div aria-live="polite" aria-atomic="true" style="position: relative; min-height: 65px;">
    <div class="toast" id="deleteAcc" data-delay="10000" style="position: absolute; top: 0; right: 0;">
        <div class="toast-header">
            <strong class="mr-auto">Удаление учетной записи</strong>
            <button type="button" id="closeToast3" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="toast-body">
            Учетная запись удалена!
        </div>
    </div>
    <div class="toast" id="error" data-delay="10000" style="position: absolute; top: 0; right: 0;">
        <div class="toast-header">
            <strong class="mr-auto">ВНИМАНИЕ!</strong>
            <button type="button" id="closeToast4" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div id="bodyError" class="toast-body">
        </div>
    </div>
</div>
<main role="main" class="flex-shrink-0">
    <div class="container">
        <div class="container">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/openRegisterAdmins">Добавить
                новую уч.запись администратора</a>
        </div>
        <br>
        <table id="listAdmin" class="table table-hover table-responsive text-left">
            <thead class="thead-light">
            <tr>
                <th class="w-3p5">№</th>
                <th class="w-60">Имя</th>
                <th class="w-36p5">Фамилия</th>
                <th>Отчество</th>
                <th>Логин</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="admin" items="${UsersAdmin}">
                <tr id="adm_<c:out value="${admin.id}"/>">
                    <td id="idAdmin"><c:out value="${admin.id}"/></td>
                    <td><c:out value="${admin.firstName}"/></td>
                    <td><c:out value="${admin.lastName}"/></td>
                    <td><c:out value="${admin.patronymic}"/></td>
                    <td><c:out value="${admin.login}"/></td>
                    <td><button onclick="breakPassword(<c:out value="${admin.id}"/>)" class="btn btn-secondary" >Сбросить пароль</button></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</main>
<footer class="footer bg-dark py-3 mt-auto text-muted">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>
</body>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
</html>
