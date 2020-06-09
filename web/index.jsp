<%@ page import="java.util.Base64" %><%--
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/signin.css" >

</head>

<body class="text-center">
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>
</nav>
<%
    Cookie[] cookies=request.getCookies();
    String userName = "", password = "",rememberVal="";
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("cooklogin")) {
                userName = new String(Base64.getDecoder().decode(cookie.getValue()));
                // userName = cookie.getValue();
            }
            if(cookie.getName().equals("cookpass")){
                password = new String(Base64.getDecoder().decode(cookie.getValue()));
                // password = cookie.getValue();
            }
            if(cookie.getName().equals("cookrem")){
                rememberVal = cookie.getValue();
            }
        }
    }
%>
<div>
    <form class="form-signin" autocomplete="off" method="post" action="${pageContext.request.contextPath}/login">
        <h1 class="h3 mb-3 font-weight-normal">Пожалуйста, войдите в систему</h1>
        <table >
            <tr>
                <td >
                    <label for="inputLogin" class="float-left h5 font-weight-normal text-left">Логин:</label>
                </td>
                <td class="w-100">
                    <input id="inputLogin" autocomplete="off" value="<%=userName%>" class="form-control" name="login"
                           placeholder="Login" required autofocus>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="inputPassword" class="float-left h5 font-weight-normal">Пароль:</label>
                </td>
                <td class="w-100">
                    <input type="password" autocomplete="new-password" id="inputPassword" value="<%=password%>" name="password"
                           class="form-control" placeholder="Password" required>
                </td>
            </tr>
        </table>

        <%=request.getAttribute("msg") != null ? request.getAttribute("msg") : ""%>
        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" name="remember"
                       value="1" <%= "1".equals(rememberVal.trim()) ? "checked=\"checked\"" : "" %> > Запомнить меня
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Вход</button>
        <button type="button" onclick="document.location='loadCollForUsers'"
                class="btn btn-outline-secondary btn-block">Продолжить без авторизации
        </button>
        <p class="mt-5 mb-3 text-muted">&copy; 2020-....</p>
    </form>
</div>


</body>
</html>
