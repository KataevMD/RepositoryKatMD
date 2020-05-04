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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>
</nav>
<br>
<br>
<br>
<div class="container border border-secondary ">
    <div class="row">
        <div class="col">
            <form class="" method="post" action="${pageContext.request.contextPath}/authUsers">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputFirstName">Имя</label>
                        <input type="text" class="form-control" pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$" id="inputFirstName" required autofocus>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="inputLastName">Фамилия</label>
                        <input type="text" class="form-control" pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$" id="inputLastName" required>
                    </div>
                    <div class="form-group">
                        <label for="inputPatronymic">Отчество</label>
                        <input type="text" class="form-control" id="inputPatronymic">
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
<footer class="container fixed-bottom">
    <p>&copy; Company 2020-.... </p>
</footer>

</body>
</html>
