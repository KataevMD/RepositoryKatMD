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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="generator" content="Jekyll v3.8.6">
    <title>Единая база нормативов технологических операций</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <form class="form-inline my-2 my-lg-0" action="index.jsp">
            <button class="btn btn-outline-light my-2 my-sm-0" >Войти</button>
        </form>
        <button class="btn btn-outline-light my-2 my-sm-0"></button>

    </div>
</nav>

<main role="main">

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <p class="text-justify h3 text-center font-weight-bold">Добро пожаловать в систему управления техническим нормированием операций механической обработки деталей!</p>
    </div>
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

<footer class="footer bg-dark py-3 ">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>

</footer>

</body>

</html>
