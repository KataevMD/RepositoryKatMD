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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body class="d-flex flex-column h-100">
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <form class="form-inline my-2 my-lg-0" action="${pageContext.request.contextPath}/index.jsp">
            <button class="btn btn-outline-light my-2 my-sm-0">Войти</button>
        </form>
        <button class="btn btn-outline-light my-2 my-sm-0"></button>

    </div>
</nav>

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
<footer class="footer py-3 mt-auto bg-dark ">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>

</body>

</html>
