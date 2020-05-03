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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>
</nav>
<form class="form-signin" method="post" action="${pageContext.request.contextPath}/authUsers">
    <h1 class="h3 mb-3 font-weight-normal">Пожалуйста, войдите в систему</h1>
    <label for="inputEmail" class="sr-only">Email address</label>
    <input  id="inputEmail" class="form-control" name="login" placeholder="Login" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required>

    <button class="btn btn-lg btn-primary btn-block" type="submit">Вход</button>
    <button type="button" onclick="document.location='findUsers'" class="btn btn-outline-secondary btn-block">Продолжить без авторизации</button>
    <p class="mt-5 mb-3 text-muted">&copy; 2020-....</p>
</form>
</body>
</html>
