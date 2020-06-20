<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 11.06.2020
  Time: 1:58
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
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/uploadFile.css">
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/importMapTable.css">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous">
    </script>
    <script src="http://localhost:8081/cstrmo/js/importMapTable.js"></script>
</head>
<body class="d-flex flex-column h-100">
<!-- Vertically centered modal -->
<div class="modal fade" id="waitingUpload" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="container">
            <div class="cssload-thecube">
                <div class="cssload-cube cssload-c1"></div>
                <div class="cssload-cube cssload-c2"></div>
                <div class="cssload-cube cssload-c4"></div>
                <div class="cssload-cube cssload-c3"></div>
            </div>
        </div>
    </div>
</div>
<button data-toggle="modal" id="close"
        data-target="#waitingUpload" hidden></button>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false"
                >Учетные записи
                    администраторов</a>
                <div class="dropdown-menu" aria-labelledby="dropdown03">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openListAdminPage">Просмотр
                        учетных записей</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openRegisterAdmins">Добавить
                        учетных запись</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="#">Импорт карт</a>
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

<%--Контент--%>
<main role="main" class="flex-shrink-0"><br>
    <div class="container text-center">
        <p class="h4 mt-auto">Импорт карт нормативов технологических операций </p>
    </div>
    <br>
    <div class="container container-fluid">

        <p class="h5 mt-auto ml-3">1. Выберите справочник в графе "Справочник".</p>
        <div class="row pb-3 ml-5">
            <div class="col  col-4">
                <label for="findCollection">Поиск справочника по названию:</label><input onkeyup="filterColl(this)" class="form-control"
                                                                                         id="findCollection">
            </div>
            <div class="col col-6">
                <label for="collection">Справочник:</label>
                <select id="collection" onchange="getChapter(this)" name="collection" class="form-control">
                    <option id="blockColl">Выберите справочник</option>
                    <c:forEach var="collection" items="${lCollection}">
                        <option value="${collection.collection_id}">${collection.nameCollectionMapTable}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <br>
        <p class="h5 mt-auto ml-3">2. Выберите главу справочника в графе "Глава".</p>
        <div class="row pb-3 ml-5">

            <div id="listChapter" class="col col-6">
                <data id="dataListChapter" value="1212">
                    <label for="chapter">Глава: </label>

                    <select class="form-control" onchange="getSection(this)" id="chapter">
                        <option id="blockChapter">Выберите главу</option>
                        <c:forEach var="chapter" items="${lChapter}">
                            <option value="${chapter.chapter_id}">${chapter.nameChapter}</option>
                        </c:forEach>
                    </select>
                </data>
            </div>
        </div>
        <br>

        <p class="h5 mt-auto ml-3">3. Выберите раздел главы в графе "Раздел".</p>
        <div class="row pb-3 ml-5">

            <div id="listSection" class="col col-6">
                <data id="dataListSection" onchange="selectSection(this)" value="1212">
                    <label for="section">Раздел: </label>

                    <select class="form-control" onchange="selectSection(this)" id="section">
                        <option id="blockSection">Выберите раздел</option>
                        <c:forEach var="section" items="${lSections}">
                            <option value="${section.section_id}">${section.nameSection}</option>
                        </c:forEach>
                    </select>
                </data>
            </div>
        </div>
        <br>

        <p class="h5 mt-auto ml-3">4. Выберите тип импортируемой(ых) карт(ы) в графе "Типы карт."</p>
        <div class="row pb-3 ml-5">

            <div class="col col-6">
                <label for="typeMap">Типы карт: </label>
                <select class="form-control" onchange="selectTypeMap(this)" id="typeMap">
                    <option id="blockTypeMap">Выберите тип карт</option>
                    <c:forEach var="typeMap" items="${lTypeMapTables}">
                        <option value="${typeMap.type_id}">${typeMap.nameType}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <br>

        <p class="h5 mt-auto ml-3">5. Выберите тип времени для импортируемой(ых) карт(ы) в графе "Типы времени."</p>
        <div class="row pb-3 ml-5">

            <div class="col col-6">
                <label for="typeTime">Типы времени: </label>
                <select class="form-control" onchange="selectTypeTime(this)" id="typeTime">
                    <option id="blockTypeTime">Выберите тип времени</option>
                    <c:forEach var="typeTime" items="${lTypeTimes}">
                        <option value="${typeTime.typeTime_id}">${typeTime.nameTypeTime}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <br>

        <p class="h5 mt-auto ml-3">6. Выберите разряд для импортируемой(ых) карт(ы) в графе "Разряд."</p>
        <div class="row pb-3 ml-5">

            <div class="col col-6">
                <label for="discharge">Разряд: </label>
                <select class="form-control" onchange="selectDischarge(this)" id="discharge">
                    <option id="blockDisch">Выберите разряд</option>
                    <c:forEach var="discharge" items="${lDischarge}">
                        <option value="${discharge.discharge_id}">${discharge.valueDischarge}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <br>

        <p class="h5 mt-auto ml-3">7. Выберите карту(ы) нормирования."</p>
        <div class="row pb-3 ml-5 pl-5  ">
            <form id="upload-container" enctype="multipart/form-data" method="post" hidden
                  action="${pageContext.request.contextPath}/importMapTable">

                <label for="typeTime_id"></label><input id="typeTime_id" name="typeTime_id" required hidden>
                <label for="typeMapTable_id"></label><input id="typeMapTable_id" name="typeMapTable_id"
                                                            required hidden>
                <label for="discharge_id"></label><input id="discharge_id" name="discharge_id"
                                                         required hidden>
                <label for="section_id"></label><input id="section_id" name="section_id" required hidden>
                <img id="upload-image" src="http://localhost:8081/cstrmo/img/uploadFileImg.png" alt="f">
                <div>
                    <input id="file-input" accept=".xlsm" type="file" name="file" multiple>
                    <label for="file-input">Выберите файл(ы)</label>
                    <span>или перетащите его(их) сюда</span>
                </div>

            </form>
        </div>
    </div>

</main>
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
