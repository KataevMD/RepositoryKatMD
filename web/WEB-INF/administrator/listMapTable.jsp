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
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css" >
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous">
    </script>
    <script src="http://localhost:8081/cstrmo/js/mapTable.js"></script>
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
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/openImportPage">Импорт карт</a>
            </li>
        </ul>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle" style="margin-right: 10px;"
               href="${pageContext.request.contextPath}/myAccount">Личный кабинет</a>
        </div>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle"
               href="${pageContext.request.contextPath}/logout"><%=userName%>
                (Выйти)</a>
        </div>
    </div>

</nav>
<%--Всплывающие уведомления--%>
<div aria-live="polite" aria-atomic="true" class="fixed-top" style="z-index: -20; min-height: 55px;">
    <div class="toast" id="error" data-delay="10000" style="position: absolute; top: 55px; right: 0;">
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
                            <td>
                                <a href="${pageContext.request.contextPath}/openListParameterAndCoefficientPage?mapTable_id=<c:out value='${MapTable.mapTable_id}'/>&nameMapTable=<c:out value='${MapTable.name}'/>"
                                   class="btn btn-light">Редактировать</a>
                            </td>
                            <td>
                                <button type="button" id="delete"
                                        onclick="deleteMapTableById(<c:out value="${MapTable.mapTable_id}"/>)"
                                        class="btn btn-light">Удалить
                                </button>
                            </td>
                            <td>
                                <button id="cloneMap" data-toggle="modal"
                                        onclick="getMapId(<c:out value="${MapTable.mapTable_id}"/>)"
                                        data-target="#staticBackdropCloneMap" class="btn btn-outline-secondary">
                                    Дублировать
                                </button>
                            </td>
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
                    <label for="inputNumberMapTable" >Введите номер карты</label>
                    <input id="inputNumberMapTable" onkeyup="checkInputNumberMap()" autocomplete="off"
                           class="form-control" pattern="^[0-9]+$"
                           name="numberMapTable"
                           title="Разрешено использовать цифры"
                           placeholder="Номер карты"
                           required autofocus><br>
                    <label for="inputNameMapTable" >Введите название карты</label>
                    <input id="inputNameMapTable" onkeyup="checkInputNameMap()" autocomplete="off" class="form-control"
                           pattern="^[А-Яа-яЁё,\s]+$"
                           name="nameMapTable"
                           title="Разрешено использовать только пробелы и русские буквы"
                           placeholder="Название карты"
                           required autofocus><br>
                    <label>
                        <input name="collection_Id" value="${collection_Id}" hidden>
                    </label>
                    <div class="d-flex justify-content-center">
                        <button id="createMap" style="margin-right: 15px" class="btn btn-lg btn-primary btn-block" type="submit">Создать</button>
                        <br>
                        <button type="button" class="btn btn-lg btn-light  btn-block" data-dismiss="modal">Отмена</button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<%--Модальное окно клонирования карты--%>
<div class="modal fade" id="staticBackdropCloneMap" data-backdrop="static" data-keyboard="false"
     tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h6>Выберите справочник, в который будет клонирована карта</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Название справочника: <label>
                <input class="form-control" onkeyup="filter(this)" type="text"/>
            </label>
                <label>
                    <input id="mapTable_id" class="form-control" value="" type="text" hidden/>
                </label>
                <ul  id="listColl" class="list-group" style="cursor: pointer">
                    <c:forEach var="CollectionMapTable" items="${CollectionMapTables}">
                        <li class="list-group-item list-group-item-action"
                            onclick="cloneMapTable(<c:out value="${CollectionMapTable.collection_id}"/>)">
                            <c:out value="${CollectionMapTable.nameCollectionMapTable}"/></li>
                    </c:forEach>
                </ul>
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
<script src="http://localhost:8081/cstrmo/js/offcanvas.js"></script>
<script src="http://localhost:8081/cstrmo/js/filters.js"></script>

</html>
