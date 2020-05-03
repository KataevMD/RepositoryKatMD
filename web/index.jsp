<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 21.03.2020
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Вход в систему управления</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        <%@include file="/WEB-INF/css/signin.css"%>
    </style>
    <!-- Custom styles for this template -->
<%--    <link href="http://localhost:8081/cstrmo/css/signin.css" rel="stylesheet">--%>

</head>

<body class="text-center">
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>
</nav>

<form class="form-signin" method="post" action="${pageContext.request.contextPath}/authUsers">
    <h1 class="h3 mb-3 font-weight-normal">Пожалуйста, войдите в систему</h1>
    <label for="inputEmail" class="sr-only">Email address</label>
    <input  id="inputEmail" class="form-control" name="login" placeholder="Login" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required>
    <p>${enter}</p>
    <div class="checkbox mb-3">
        <label>
            <input type="checkbox" value="remember-me"> Запомнить меня
        </label>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Вход</button>
    <button type="button" onclick="document.location='loadCollforUsers'" class="btn btn-outline-secondary btn-block">Продолжить без авторизации</button>
    <p class="mt-5 mb-3 text-muted">&copy; 2020-....</p>
</form>

</body>
</html>
