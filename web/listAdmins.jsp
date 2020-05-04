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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="generator" content="Jekyll v3.8.6">
    <title>Единая база нормативов технологических операций</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <meta name="theme-color" content="#563d7c">

    <!-- Custom styles for this template -->
  <style>
    <%@include file="/WEB-INF/css/mainTable.css"%>
  </style>

</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <button class="btn btn-outline-light my-2 my-sm-0" onclick="document.location = 'listAdmins.jsp'">Уч.записи
            менеджеров
        </button>
        <form class="form-inline my-2 my-lg-0" action="index.jsp">
            <button class="btn btn-outline-light my-2 my-sm-0">${name} (Выйти)</button>
        </form>
    </div>
</nav>

<main role="main">

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <p class="text-justify h3 text-center font-weight-bold">Добро пожаловать в систему управления техническим
            нормированием операций механической обработки деталей!</p>
    </div>

    <div class="row">
      <div class="container ">
        <div class="container">
          <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/NewManager">Добавить нового администратора</a>
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
    </div>


</main>

<footer class="container fixed-bottom">
    <p>&copy; Company 2020-.... </p>
</footer>

</body>

</html>
