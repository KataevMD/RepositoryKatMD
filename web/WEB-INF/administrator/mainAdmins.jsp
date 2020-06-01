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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- Custom styles for this template -->
    <style>
        <%@include file="/WEB-INF/css/offcanvas.css"%>
    </style>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous">
    </script>
</head>
<body class="d-flex flex-column h-100">
<%
    Cookie[] cookies = request.getCookies();
    String userName = "";
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("cookuser")) {
                userName = cookie.getValue();
            }
        }
    }
%>
<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false"
                >Уч.записи
                    администраторов</a>
                <div class="dropdown-menu" aria-labelledby="dropdown03">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openListAdminPage">Просмотр
                        уч.записей</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openRegisterAdmins">Добавить
                        уч.запись</a>
                </div>
            </li>
        </ul>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle"
               href="${pageContext.request.contextPath}/logout"><%=userName%>
                (Выйти)</a>
        </div>
    </div>
</nav>
<%--Контент--%>

<main role="main" class="flex-shrink-0">
    <!-- Main jumbotron for a primary marketing message or call to action -->

    <br>
    <br>
    <div class="container text-center">
        <p class="h4 mt-auto">Справочники операций</p>
    </div>
    <br>
    <div class="container">
        <button id="createNewColl" data-toggle="modal"
                data-target="#staticBackdrop" class="btn btn-outline-secondary">Добавить новый
            справочник
        </button>
    </div>
    <br>
    <div id="divColl" class="container ">
        <data value="454253">
            <table id="CollMapTable" class="table table-hover table-responsive text-left">
                <thead class="thead-light">
                <tr class='table-filters'>
                    <td class="border-0">
                    </td>
                    <td class="border-0">
                        Название справочника: <label>
                        <input class="form-control" type="text"/>
                    </label>
                    </td>
                </tr>
                <tr>
                    <th>№</th>
                    <th class="w-75">Название справочника</th>
                    <th class="text-center" colspan="3">Управление</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="collMapTable" items="${collectionMapTables}">
                    <tr id="tr_<c:out value="${collMapTable.collection_id}"/>" class='table-data'>
                        <td><c:out value="${collMapTable.collection_id}"/></td>
                        <td><c:out value="${collMapTable.nameCollectionMapTable}"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/openListMapTablePage?collection_id=<c:out value='${collMapTable.collection_id}'/>&nameCollectionMapTable=<c:out value='${collMapTable.nameCollectionMapTable}'/>"
                               class="btn btn-light">Просмотреть</a>
                        </td>
                        <td>
                            <button class="btn btn-light " id="viewUpdate"
                                    onclick="viewUpdate(<c:out value="${collMapTable.collection_id}"/>)">
                                Редактировать
                            </button>
                        </td>
                        <td>
                            <button type="button" id="delete"
                                    onclick="deleteCollMapTableById(<c:out value="${collMapTable.collection_id}"/>)"
                                    class="btn btn-light">Удалить
                            </button>
                        </td>
                    </tr>
                    <tr id="coll_<c:out value="${collMapTable.collection_id}"/>" class="table-active" hidden>
                        <td>
                        </td>
                        <td>
                            <label>
                                <input id="upColl<c:out value="${collMapTable.collection_id}"/>"
                                       onkeyup="checkNameColl(<c:out value="${collMapTable.collection_id}"/>)"
                                       value="<c:out value="${collMapTable.nameCollectionMapTable}"/>"
                                       title="Разрешено использовать только пробелы и русские буквы"
                                       type="text" class="form-control" required>
                            </label>
                        </td>
                        <td>
                            <button id="save<c:out value="${collMapTable.collection_id}"/>"
                                    class="btn btn-primary "
                                    onclick="updateColl(<c:out value="${collMapTable.collection_id}"/>)">Сохранить
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-secondary "
                                    onclick="closeUpdate(<c:out value="${collMapTable.collection_id}"/>)">Отмена
                            </button>
                        </td>
                        <td></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </data>
    </div>
</main>
<%--Модальное окно создания нового справочника--%>
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false"
     tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Создание справочника</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="createForm" autocomplete="off" method="post"
                      action="${pageContext.request.contextPath}/addNewCollMapTable">
                    <label for="inputNameCollMapTable" class="sr-only">Название справочника</label>
                    <input id="inputNameCollMapTable" autocomplete="off" class="form-control" pattern="^[А-Яа-яЁё\s]+$"
                           name="nameCollMapTable" placeholder="Название справочника"
                           required autofocus>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Создать</button>
                    <button type="button" class="btn-outline-secondary btn-block" data-dismiss="modal">Отмена</button>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<%--Подвал--%>
<footer class="footer bg-dark py-3 mt-auto text-muted">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>
</body>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script>
    <%@include file="/WEB-INF/js/collectMapTable.js"%>
    <%@include file="/WEB-INF/js/offcanvas.js" %>
    <%@include file="/WEB-INF/js/filters.js" %>
</script>
</html>
