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
    <meta name="theme-color" content="#563d7c">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <style>
        <%@include file="/WEB-INF/css/offcanvas.css"%>
        <%@include file="/WEB-INF/css/modal_signin.css"%>
    </style>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script>
        <%@include file="/WEB-INF/js/offcanvas.js" %>
    </script>
</head>
<body class="d-flex flex-column h-100">
<!-- Навигационная панель -->
<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <button type="button" class="btn btn-outline-light my-2 my-sm-0" data-toggle="modal"
                        data-target="#staticBackdrop">Авторизоваться
                </button>
            </li>
        </ul>
    </div>
</nav>
<%--Модальное окно авторизации--%>
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Вход в систему</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-signin" autocomplete="off" method="post" action="${pageContext.request.contextPath}/login">
                    <label for="inputLogin" class="sr-only">Email address</label>
                    <input  id="inputLogin" autocomplete="off"  class="form-control" name="login" placeholder="Login" required autofocus>
                    <label for="inputPassword" class="sr-only">Password</label>
                    <input type="password" autocomplete="new-password" id="inputPassword"  name="password" class="form-control" placeholder="Password" required>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Войти</button>
                    <button type="button" class="btn-outline-secondary btn-block" data-dismiss="modal">Отмена</button>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<%--Контент--%>
<main role="main" class="flex-shrink-0">
    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <p class="text-justify h3 text-center font-weight-bold">Добро пожаловать в систему управления техническим
            нормированием операций механической обработки деталей!</p>
    </div>
    <div class="container ">
        <table id="CollMapTable" class="table table-bordered container text-left">
            <thead class="thead-light">
            <tr>
                <th class="w-7p5">№</th>
                <th class="w-75">Название справочника</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="collMapTable" items="${collectionMapTables}">
                <tr>
                    <td><c:out value="${collMapTable.collection_id}"/></td>
                    <td><c:out value="${collMapTable.nameCollectionMapTable}"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/daoCollOpen?collection_id=<c:out value='${collMapTable.collection_id}'/>&nameCollectionMapTable=<c:out value='${collMapTable.nameCollectionMapTable}'/>"
                           class="btn btn-light">Просмотреть</a></td>
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
