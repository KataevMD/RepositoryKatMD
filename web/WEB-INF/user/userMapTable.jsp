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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <style><%@include file="/WEB-INF/css/offcanvas.css"%></style>
</head>
<body class="d-flex flex-column h-100">
<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <form class="form-inline my-2 my-lg-0" action="../../index.jsp">
                    <button class="btn btn-outline-light my-2 my-sm-0" >Войти</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<main role="main" class="flex-shrink-0">
    <br>
    <div class="container text-center">
        <p class="h4 mt-auto">Список карт трудового нормирования справочника "${idCollMapTable}"</p>
    </div><br>
    <div class="container ">
        <table id="tableMapTable" class="table table-bordered container text-left">
            <thead class="thead-light">
            <tr>
                <th class="w-7p5">№ таблицы</th>
                <th class="w-75">Название карты трудового нормирования техпроцесса</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="MapTable" items="${MapTables}">
                <tr>
                    <td><c:out value="${MapTable.numberTable}"/></td>
                    <td><c:out value="${MapTable.name}"/></td>
                    <td><a href="" class="btn btn-light">Проссмотреть</a>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    </div>

</main>
<footer class="footer py-3 mt-auto bg-dark ">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>

</body>
<script><%@include file="/WEB-INF/js/offcanvas.js"%></script>
</html>
