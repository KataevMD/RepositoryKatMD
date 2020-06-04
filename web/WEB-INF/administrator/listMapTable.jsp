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
    <title>Единая база нормативов технологических операций</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <style>
        <%@include file="/WEB-INF/css/offcanvas.css" %>
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
                <a class="nav-link " href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
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
<%--Всплывающие уведомления--%>
<div aria-live="polite" aria-atomic="true" style="position: relative; min-height: 55px;">
    <div class="toast" id="error" data-delay="10000" style="position: absolute; top: 0; right: 0;">
        <div class="toast-header">
            <strong class="mr-auto">Внимание!</strong>
            <button type="button" id="closeToast1" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div id="bodyError" class="toast-body">
        </div>
    </div>
</div>
<main role="main" class="flex-shrink-0">
    <label>
        <input id="collection_Id" value="${collection_Id}" hidden>
    </label>
    <div class="container text-center">
        <p class="h4 mt-auto">Список карт нормативов техопераций справочника "${nameCollMapTable}"</p>
    </div>
    <br>
    <div class="container">
        <%--Кнопка открытия модального окна создания новой карты--%>
        <button id="createNewMap" data-toggle="modal"
                data-target="#staticBackdrop" class="btn btn-outline-secondary">Добавить новую
            карту
        </button>
    </div>
    <div class="d-flex justify-content-center">
        <div id="tableMap">
            <data value="23242342">
                <table id="tableMapTable" class="table table-hover table-responsive text-left">
                    <thead class="thead-light">
                    <tr class='table-filters'>
                        <td class="border-0">
                        </td>
                        <td class="border-0">
                            Название карты: <label>
                            <input class="form-control" type="text"/>
                        </label>
                        </td>
                    </tr>
                    <tr>
                        <th>№ таблицы</th>
                        <th>Название карты</th>
                        <th>Формула</th>
                        <th class="text-center" colspan="3">Управление</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="MapTable" items="${MapTables}">
                        <tr id="tr_<c:out value="${MapTable.mapTable_id}"/>" class='table-data'>
                            <td><c:out value="${MapTable.numberTable}"/></td>
                            <td><c:out value="${MapTable.name}"/></td>
                            <td><c:out value="${MapTable.formul}"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/openListParameterAndCoefficientPage?mapTable_id=<c:out value='${MapTable.mapTable_id}'/>&nameMapTable=<c:out value='${MapTable.name}'/>"
                                   class="btn btn-light">Просмотреть</a>
                            </td>
                            <td>
                                <button class="btn btn-light " id="viewUpdate"
                                        onclick="viewUpdateMap(<c:out value="${MapTable.mapTable_id}"/>)">
                                    Редактировать
                                </button>
                            </td>
                            <td>
                                <button type="button" id="delete"
                                        onclick="deleteMapTableById(<c:out value="${MapTable.mapTable_id}"/>)"
                                        class="btn btn-light">Удалить
                                </button>
                            </td>
                        </tr>
                        <tr id="map_<c:out value="${MapTable.mapTable_id}"/>" hidden class="table-active">
                            <td>
                                <label class="w-100">
                                    <input id="numberMap_<c:out value="${MapTable.mapTable_id}"/>"
                                           value="<c:out value="${MapTable.numberTable}"/>"
                                           onkeyup="checkNumberMap(<c:out value="${MapTable.mapTable_id}"/>)"
                                           title="Разрешено использовать только цифры"
                                           type="text" class="form-control " required>
                                </label>
                            </td>
                            <td>
                                <label class="w-100">
                                    <input id="nameMap_<c:out value="${MapTable.mapTable_id}"/>"
                                           value="<c:out value="${MapTable.name}"/>"
                                           onkeyup="checkNameMap(<c:out value="${MapTable.mapTable_id}"/>)"
                                           title="Разрешено использовать только пробелы и русские буквы"
                                           type="text" class="form-control " required>
                                </label>
                            </td>
                            <td>
                                <label class="w-100">
                                    <input id="formulMap_<c:out value="${MapTable.mapTable_id}"/>"
                                           value="<c:out value="${MapTable.formul}"/>"
                                           type="text" class="form-control" required>
                                </label>
                            </td>
                            <td>
                                <button id="save<c:out value="${MapTable.mapTable_id}"/>" class="btn btn-primary"
                                        onclick="updateMap(<c:out value="${MapTable.mapTable_id}"/>)">Сохранить
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-secondary"
                                        onclick="closeUpdateMap(<c:out value="${MapTable.mapTable_id}"/>)">Отмена
                                </button>
                            </td>
                            <td></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </data>
        </div>
    </div>

</main>
<%--Модальное окно создания новой карты--%>
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false"
     tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Создание карты</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formCreateMapTable" autocomplete="off" method="post"
                      action="${pageContext.request.contextPath}/addNewMapTable">
                    <label for="inputNumberMapTable" class="sr-only">Номер карты</label>
                    <input id="inputNumberMapTable" onkeyup="checkInputNumberMap()" autocomplete="off"
                           class="form-control" pattern="^[0-9]+$"
                           name="numberMapTable"
                           title="Разрешено использовать цифры"
                           placeholder="Номер карты"
                           required autofocus><br>
                    <label for="inputNameMapTable" class="sr-only">Название карты</label>
                    <input id="inputNameMapTable" onkeyup="checkInputNameMap()" autocomplete="off" class="form-control"
                           pattern="^[А-Яа-яЁё,\s]+$"
                           name="nameMapTable"
                           title="Разрешено использовать только пробелы и русские буквы"
                           placeholder="Название карты"
                           required autofocus><br>
                    <label for="inputFormulMapTable" class="sr-only">Формула</label>
                    <input id="inputFormulMapTable" autocomplete="off" class="form-control"
                           name="formulMapTable"
                           placeholder="Формула карты"
                           autofocus><br>
                    <label>
                        <input name="collection_Id" value="${collection_Id}" hidden>
                    </label>
                    <button id="createMap" class="btn btn-lg btn-primary btn-block" type="submit">Создать</button>
                    <br>
                    <button type="button" class="btn-outline-secondary btn-block" data-dismiss="modal">Отмена</button>
                    <br>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<footer class="footer py-3 mt-auto bg-dark ">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>

</body>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script>
    <%@include file="/WEB-INF/js/offcanvas.js" %>
    <%@include file="/WEB-INF/js/filters.js" %>
    <%@include file="/WEB-INF/js/mapTable.js" %>
</script>

</html>