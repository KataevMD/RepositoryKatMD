<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 14.04.2020
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Регистрация</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- Custom styles for this template -->
    <style>
        <%@include file="/WEB-INF/css/offcanvas.css"%>
    </style>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script>
        <%@include file="/WEB-INF/js/offcanvas.js"%>
        <%@include file="/WEB-INF/js/create.js"%>
    </script>
</head>
<body class="d-flex flex-column h-100">
<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false"
                >Уч.записи
                    администраторов</a>
                <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/OpenListManager">Просмотр
                        уч.записей</a>
                    <a class="dropdown-item active" href="${pageContext.request.contextPath}/NewManager">Добавить
                        уч.запись</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-light align-middle" href="${pageContext.request.contextPath}/logout">${name}
                    (Выйти)</a>
            </li>
        </ul>
    </div>
</nav>
<br>
<br>
<br>
<main role="main" class="flex-shrink-0">
    <div class="container border border-secondary ">
        <div class="row">
            <div class="col">
                <form class="" id="createForm" autocomplete="off" action="${pageContext.request.contextPath}/createAccAdmin" method="post">
                    <p class="text-center h3">Добавление учетной записи нового администратора</p>
                    <br>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputFirstName">Имя</label>
                            <input type="text" name="firstName" autocomplete="off" class="form-control"
                                   pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{2,30})$" id="inputFirstName" required
                                   autofocus>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="inputLastName">Фамилия</label>
                            <input type="text" name="lastName" autocomplete="off" class="form-control"
                                   pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{2,30})$" id="inputLastName" required>
                        </div>

                    </div>
                    <div class="form-row justify-content-center">
                        <div class="form-group col-md-6 ">
                            <label for="inputPatronymic">Отчество</label>
                            <input type="text" name="patronymic" autocomplete="off" class="form-control"
                                   pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{2,30})$" id="inputPatronymic">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputLogin">Логин</label>
                            <input type="text" name="login" autocomplete="off" class="form-control"
                                   pattern="^[a-zA-Z][a-zA-Z0-9]{6,20}$"
                                   id="inputLogin" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="inputPassw">Пароль</label>
                            <input type="password" name="password" autocomplete="off" class="form-control"
                                   pattern="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,}"
                                   id="inputPassw" value="Passw0rd" readonly>
                        </div>
                    </div>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Создать учетную запись</button>
                </form>
            </div>
        </div>

    </div>
</main>

<footer class="footer bg-dark py-3 mt-auto text-muted">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
</body>
</html>
