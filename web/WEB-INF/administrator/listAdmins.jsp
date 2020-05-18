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
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <!-- Custom styles for this template -->
    <style>
        <%@include file="/WEB-INF/css/mainTable.css"%>
    </style>

</head>
<body class="d-flex flex-column h-100">
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>
    <div class="navbar-nav">
        <a class="nav-item nav-link active" href="${pageContext.request.contextPath}/OpenListManager">Уч.записи
            администраторов</a>
        <a class="btn btn-outline-light align-middle " href="${pageContext.request.contextPath}/logout">${name} (Выйти)</a>
    </div>
</nav>
<br>
<br>
<br>
<main role="main" class="flex-shrink-0">
    <div class="container">
            <div class="container">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/NewManager">Добавить
                    нового администратора</a>
            </div>
            <br>
            <table id="CollMapTable" class="table table-bordered container text-left">
                <thead class="thead-light">
                <tr>
                    <th class="w-3p5">№</th>
                    <th class="w-60">Имя</th>
                    <th class="w-36p5"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="admin" items="${UsersAdmin}">
                    <tr>
                        <td><c:out value="${admin.id}"/></td>
                        <td><c:out value="${admin.firstName}"/></td>
                        <td>
                            <div class="form-row">
                                <div class="col">
                                    <button id="view" class="btn btn-light">Просмотреть</button>
                                </div>
                                <div class="col">
                                    <button id="update" class="btn btn-light">Редактировать</button>
                                </div>
                                <div class="col">
                                    <button id="delete" class="btn btn-light">Удалить</button>
                                </div>
                            </div>
                        </td>
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

</html>
