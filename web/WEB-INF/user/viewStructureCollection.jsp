<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 11.06.2020
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Единая база нормативов технологических операций</title>
    <link rel="shortcut icon" href="http://localhost:8081/cstrmo/img/favicon.png" type="image/png">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css">
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/modal_signin.css" >
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/btn_file_upload.css">
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/dist/themes/default/style.min.css">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous">
    </script>
    <script src="http://localhost:8081/cstrmo/js/userViewMap.js"></script>
    <script src="http://localhost:8081/cstrmo/dist/jstree.min.js"></script>
</head>
<body class="d-flex flex-column h-100">
<%--Модальное окно авторизации--%>
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Вход в систему</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-signin" autocomplete="off" method="post"
                      action="${pageContext.request.contextPath}/login">
                    <label for="inputLogin" class="sr-only">Email address</label>
                    <input id="inputLogin" autocomplete="off" class="form-control" name="login" placeholder="Login"
                           required autofocus>
                    <label for="inputPassword" class="sr-only">Password</label>
                    <input type="password" autocomplete="new-password" id="inputPassword" name="password"
                           class="form-control" placeholder="Password" required>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Войти</button>
                    <button type="button" class="btn-outline-secondary btn-block" data-dismiss="modal">Отмена</button>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<%--Модальное окно просмотра параметров карты--%>
<div class="modal fade" id="viewParam" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div id="param" class="container-fluid">
                    <p class="h5 text-center">Параметры карты</p><br>
                    <data id="dataParam" value="121">
                        <table class="table text-center">
                            <thead>
                            <tr>
                                <th >Название параметра</th>
                                <th >Степень</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="parameter" items="${Parameter}">
                                <tr>
                                    <td><c:out value="${parameter.nameParametr}"/></td>
                                    <td><c:out value="${parameter.step}"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </data>
                </div>
            </div>
        </div>
    </div>
</div>
<%--Модальное окно просмотра параметров карты--%>
<div class="modal fade" id="viewCoeff" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div id="coeff" class="container-fluid">
                    <p class="h5 text-center">Коэффициенты карты</p><br>
                    <data id="dataCoeff" value="121">
                        <table class="table container text-center">
                            <thead>
                            <tr>
                                <th class="w-7p5">Название коэффициента</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="coeff" items="${Coefficient}">
                                <tr>
                                    <td><c:out value="${coeff.name}"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </data>
                </div>
            </div>
        </div>
    </div>
</div>
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
<!-- Навигационная панель -->
<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Единая база нормативов технологических операций</a>

    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link " href="javascript:history.go(-1);">Справочники</a>
            </li>
            <li class="nav-item">
                <button type="button" class="btn btn-outline-light my-2 my-sm-0" data-toggle="modal"
                        data-target="#staticBackdrop">Авторизоваться
                </button>
            </li>
        </ul>
    </div>
</nav>
<%--Контент--%>
<main role="main" class="flex-shrink-0"><br>
    <div class="container text-center">
        <p class="h4 mt-auto">Справочник "${collection.nameCollectionMapTable}"</p>
    </div>
    <br>
    <div class="container-fluid">
        <div class="row" style="min-height: 650px; max-height: 700px;">
            <div id="structureTree" class="col mr-md-5 px-md-5 overflow-auto "
                 style="min-height: 650px; max-height: 700px;">
                <%--Структура справочника--%>
                <p class="pt-2"><label for="search">Поиск: </label><input style="margin-bottom: 10px;"
                                                                          autocomplete="off"
                                                                          class="form-control" id="search"></p>
                <data id="dataStructureTree" value="1212">
                    <div id="jstree">
                        <ul>
                            <c:forEach var="chapter" items="${Chapter}">
                                <li id="<c:out value="${chapter.chapter_id}"/>">
                                    <c:out value="${chapter.nameChapter}"/>
                                    <ul>
                                        <c:forEach var="section" items="${Section}">
                                            <c:if test="${chapter.chapter_id == section.chapter.chapter_id}">
                                                <li>
                                                    <c:out value="${section.nameSection}"/>
                                                    <ul>
                                                        <c:forEach var="mapTable" items="${MapTable}">
                                                            <c:if test="${section.section_id == mapTable.section.section_id}">
                                                                <li id="map_<c:out value="${mapTable.mapTable_id}"/>"
                                                                    onclick="viewMapTable(<c:out
                                                                            value="${mapTable.mapTable_id}"/>)">
                                                                    <c:out value="${mapTable.name}"/>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ul>

                    </div>
                    <%--Конец структуры справочника--%>
                </data>
            </div>
            <label for="Col"></label><input id="Col" value="${collection.collection_id}"
                                            hidden>
            <div class="col col-8 mr-md-5 pb-md-3 pt-md-5 border border-secondary " style="min-width: 950px;">
                <div id="blockWithUpdateMapTable">
                    <data id="loadData" value="11212">
                        <div class="container text-center">
                            <p class="h4">Карта "${map.name}"</p>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-2">
                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                        data-target="#viewParam" ${disabled} >Просмотр параметров
                                </button>
                            </div>
                            <div class="col-2">
                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                        data-target="#viewCoeff" ${disabled} >Просмотр коэффициентов
                                </button>
                            </div>
                            <div class="col-9"></div>
                        </div>

                        <label for="id"></label><input id="id" name="mapTable_id" value="${map.mapTable_id}"
                                                       hidden>
                        <br><label for="Collid"></label><input id="Collid" value="${collection_id}"
                                                               name="collection_Id"
                                                               hidden>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="numberMap"> Номер карты:</label>
                            </div>
                            <div class="col-5">
                                <input id="numberMap" name="numberMapTable" value="${map.numberTable}"
                                       class="form-control" pattern="^[0-9]+$" readonly
                                       title="Разрешено использовать цифры" required>
                            </div>
                            <div class="col-5"></div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="nameMap"> Название карты:</label>
                            </div>
                            <div class="col-5">
                                <input id="nameMap" name="nameMapTable" pattern="^[А-Яа-яЁё0-9.,\s]+$" readonly
                                       title="Разрешено использовать буквы русского алфавита, цифры, точки и запятые. "
                                       value="${map.name}" class="form-control" required>
                            </div>
                            <div class="col-5"></div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="typeTimes"> Тип возвращаемого времени:</label>
                            </div>
                            <div class="col-5">
                                <c:forEach var="typeTimeMap" items="${TypeTime}">
                                    <c:if test="${typeTimeMap.typeTime_id == map.typeTime.typeTime_id}">
                                        <input id="typeTimes" class="form-control" readonly
                                               value="${typeTimeMap.nameTypeTime}" name="typeTimeMap">
                                    </c:if>
                                </c:forEach>
                            </div>
                            <div class="col-5"></div>

                        </div>

                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="discharge">Разряд:</label>
                            </div>
                            <div class="col-5">

                                <c:forEach var="discharge" items="${Discharge}">
                                    <c:if test="${discharge.discharge_id == map.discharge.discharge_id}">
                                        <input id="discharge" class="form-control" readonly
                                               value="${discharge.valueDischarge}" name="discharge">
                                    </c:if>
                                </c:forEach>

                            </div>
                            <div class="col-5"></div>
                        </div>

                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="typeMap">Тип карты нормирования:</label>
                            </div>
                            <div class="col-5">

                                <c:forEach var="typeMap" items="${TypeMapTable}">
                                    <c:if test="${typeMap.type_id == map.typeMapTable.type_id}">
                                        <input id="typeMap" class="form-control" readonly
                                               value="${typeMap.nameType}" name="typeMap">
                                    </c:if>
                                </c:forEach>


                            </div>
                            <div class="col-5"></div>
                        </div>

                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="formula">Формула:</label>
                            </div>
                            <div class="col-5">
                                <input id="formula" class="form-control" readonly
                                       value="${map.formula}" name="formulaMap">
                            </div>
                            <div class="col-5"></div>
                        </div>


                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label>PDF представление:</label>
                            </div>
                            <div class="col-4">

                                <a id="downloadFile" style="margin-right: 10px;" href="${downloadFileMap}"
                                   class="btn btn-outline-secondary ${disabledDownloadFile} ">Просмотр</a>
                            </div>
                            <div class="col-6"></div>
                        </div>
                    </data>
                </div>
            </div>
        </div>
    </div>
</main>
<br>
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
<script src="http://localhost:8081/cstrmo/js/offcanvas.js"></script>
<script src="http://localhost:8081/cstrmo/js/filters.js"></script>
</html>
