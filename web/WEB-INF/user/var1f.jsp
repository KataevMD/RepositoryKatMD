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
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"/>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>

    <%--    <script type="text/javascript" src="/"></script>--%>
    <style>
        <%@include file="/WEB-INF/css/tree.css"%>
    </style>
    <script>
        <%@include file="/WEB-INF/js/ex.js"%>
    </script>

</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <form class="form-inline my-2 my-lg-0" action="${pageContext.request.contextPath}/index.jsp">
            <button class="btn btn-outline-light my-2 my-sm-0">Войти</button>
        </form>
        <button class="btn btn-outline-light my-2 my-sm-0"></button>

    </div>
</nav>

<main role="main">

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <p class="text-justify h3 text-center font-weight-bold">Добро пожаловать в систему управления техническим
            нормированием операций механической обработки деталей!</p>
    </div>
    <div class="container">

        <div class="row row-cols-2">
            <div class="col">
                <div onclick="tree_toggle(arguments[0])">
                    <ul class="Container">
                        <li class="Node IsRoot IsLast ExpandClosed">
                            <div class="Expand"></div>
                            <div class="Content"><p>${idCollMapTable}</p></div>
                            <c:forEach var="MapTable" items="${MapTables}">
                                <ul class="Container">
                                    <li class="Node ExpandClosed">
                                        <div id="<c:out value='${MapTable.mapTable_id}'/>" class="Content tableM"><c:out value="${MapTable.name}"/></div>
                                    </li>
                                </ul>
                            </c:forEach>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="mapTable" class="col hidden">
<%--                <data>--%>
<%--                    <table id="tableMapTable" class="table table-bordered container text-left">--%>
<%--                        <thead class="thead-light">--%>
<%--                        <tr>--%>
<%--                            <th class="w-7p5">Параметр</th>--%>
<%--                            <th class="w-75">Степень</th>--%>
<%--                        </tr>--%>
<%--                        </thead>--%>
<%--                        <tbody>--%>
<%--                        <c:forEach var="param" items="${Parametr}">--%>
<%--                            <tr>--%>
<%--                                <td><c:out value='${param.nameParametr}' default="name"/></td>--%>
<%--                                <td><c:out value='${param.step}' default="step"/></td>--%>
<%--                            </tr>--%>
<%--                        </c:forEach>--%>
<%--                        </tbody>--%>
<%--                    </table>--%>
<%--                </data>--%>
            </div>
        </div>
    </div>
    </div>


</main>

<footer class="container fixed-bottom">
    <p> Company 2020-.... </p>
</footer>

</body>

</html>
