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
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/btn_file_upload.css">
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/dist/themes/default/style.min.css">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous">
    </script>
    <script src="http://localhost:8081/cstrmo/js/collectMapTable.js"></script>
    <script src="http://localhost:8081/cstrmo/dist/jstree.min.js"></script>
</head>
<body class="d-flex flex-column h-100">
<%--Модальное окно клонирования карты трудового нормирования--%>
<div class="modal fade" id="cloneMapTable" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Клонирование карты трудового нормирования</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form method="post" id="formCloneableMapTable"
                      action="${pageContext.request.contextPath}/cloneableMapTable">
                    <label for="mapTable_id"></label><input id="mapTable_id"
                                                            name="mapTable_id"
                                                            value="${map.mapTable_id}"
                                                            hidden>
                    <div class="container-fluid">
                        <p class="h6 mt-auto ml-3">1. Выберите справочник в графе "Справочник".</p>
                        <div class="row pb-3 ml-5">
                            <div class="col col-3 ">
                                <label for="findCollection">Поиск справочника по названию:</label>
                            </div>
                            <div class="col  ">
                                <input onkeyup="filterColl(this)" class="form-control" id="findCollection">
                            </div>

                        </div>
                        <div class="row pb-3 ml-5">
                            <div class="col col-3">
                                <label for="collection">Справочник:</label>
                            </div>
                            <div id="listColl" class="col ">
                                <data id="dataListColl" value="1212">
                                    <select id="collection" onchange="getListChapter(this)" name="collection"
                                            class="form-control">
                                        <option id="blockColl">Выберите справочник</option>
                                        <c:forEach var="collection" items="${lCollection}">
                                            <option value="${collection.collection_id}">${collection.nameCollectionMapTable}</option>
                                        </c:forEach>
                                    </select>
                                </data>
                            </div>
                        </div>
                        <br>
                        <p class="h6 mt-auto ml-3">2. Выберите главу справочника в графе "Глава".</p>
                        <div class="row pb-3 ml-5">
                            <div class="col col-3">
                                <label for="chapter">Глава: </label>
                            </div>
                            <div id="listChapter" class="col ">
                                <data id="dataListChapter" value="1212">
                                    <select class="form-control" onchange="getListSection(this)" id="chapter" disabled>
                                        <option id="blockChapter" >Выберите главу</option>
                                        <c:forEach var="chapter" items="${lChapter}">
                                            <option value="${chapter.chapter_id}">${chapter.nameChapter}</option>
                                        </c:forEach>
                                    </select>
                                </data>
                            </div>
                        </div>

                        <br>

                        <p class="h6 mt-auto ml-3">3. Выберите раздел главы в графе "Раздел".</p>
                        <div class="row pb-3 ml-5">
                            <div class="col col-3">
                                <label for="section">Раздел: </label>
                            </div>
                            <div id="listSection" class="col">
                                <data id="dataListSection" value="1212">
                                    <select class="form-control" id="section" name="section_id" onchange="selectSections()" disabled>
                                        <option id="blockSection">Выберите раздел</option>
                                        <c:forEach var="section" items="${lSection}">
                                            <option value="${section.section_id}">${section.nameSection}</option>
                                        </c:forEach>
                                    </select>
                                </data>
                            </div>
                        </div>
                        <div class="row pb-3 ml-5">
                            <div class="col" style="min-width: 50%;">
                                <button class="btn btn-outline-primary" id="cloneableMap" type="submit" disabled>Клонировать
                                </button>
                            </div>
                            <div class="col" style="min-width: 50%;">
                                <button class="btn btn-outline-secondary" data-dismiss="modal" type="reset">Отмена
                                </button>
                            </div>
                        </div>

                    </div>
                </form>
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
<%--Контент--%>
<main role="main" class="flex-shrink-0"><br>

    <div class="row pl-md-3 pb-md-3" style="min-width: 1050px; ">
        <div id="loadCollection" class="col" style="min-width: 800px;">
            <data id="dataLoadCollection" value="1212">
                <div class="container text-center">
                    <p class="h4 mt-auto">Справочник "${collection.nameCollectionMapTable}"</p>
                </div>
                <form method="post" id="formUpdateCollection"
                      action="${pageContext.request.contextPath}/updateCollMapTable">
                    <label for="collection_id"></label><input id="collection_id" name="collection_id"
                                                              value="${collection.collection_id}" hidden>
                    <div class="row">
                        <div class="col-1 ml-3">
                            <label for="nameCollection">Название справочника:</label>
                        </div>

                        <div class="col-3 mr-2">
                            <input id="nameCollection" name="nameCollMapTable"
                                   value="${collection.nameCollectionMapTable}"
                                   class="form-control">
                        </div>

                        <div class="col-1 mr-2">
                            <button class="btn btn-outline-primary" type="submit" id="updateCollection">
                                Сохранить изменения
                            </button>
                        </div>
                        <div class="col-1 mr-2">
                        </div>
                    </div>
                </form>
            </data>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row" style="min-height: 650px; max-height: 700px;">
            <div id="structureTree" class="col mr-md-5 px-md-5 overflow-auto "
                 style="min-height: 650px; max-height: 700px;">
                <%--Структура справочника--%>
                <a class="btn btn-outline-secondary pb-2"
                   title="Открывает модуль редактирования глав и разделов справочника." type="button"
                   id="structure" href="${showPageRewriteStructureCollection}">Структура справочника
                </a>
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
                                                                    onclick="findMapTable(<c:out
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
                            <div class="col-3">
                                <a id="openParamAndCoeff" class="btn btn-outline-secondary btn-sm ${viewParam}"
                                   href="${showPage}">Просмотр параметров и коэффициентов</a>
                            </div>
                            <div class="col-5">
                            </div>
                            <div class="col-5"></div>
                        </div>
                        <form id="formUpdateMap" method="post"
                              action="${pageContext.request.contextPath}/updateMapTable">
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
                                           class="form-control" pattern="^[0-9]+$"
                                           title="Разрешено использовать цифры" required>
                                </div>
                                <div class="col-5"></div>
                            </div>
                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="nameMap"> Название карты:</label>
                                </div>
                                <div class="col-5">
                                    <input id="nameMap" name="nameMapTable"
                                           title="Разрешено использовать буквы русского и латинского алфавитов, цифры, точки и запятые. "
                                           value="${map.name}" class="form-control" required>
                                </div>
                                <div class="col-5"></div>
                            </div>
                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="typeTimes"> Тип возвращаемого времени:</label>
                                </div>
                                <div class="col-5">
                                    <select id="typeTimes" name="typeTimes" class="form-control">
                                        <c:forEach var="typeTimeMap" items="${TypeTime}">
                                            <c:if test="${typeTimeMap.typeTime_id == map.typeTime.typeTime_id}">
                                                <option value="${typeTimeMap.typeTime_id}"
                                                        selected>${typeTimeMap.nameTypeTime}</option>
                                            </c:if>
                                            <c:if test="${typeTimeMap.typeTime_id != map.typeTime.typeTime_id}">
                                                <option value="${typeTimeMap.typeTime_id}">${typeTimeMap.nameTypeTime}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-5"></div>

                            </div>

                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="discharge">Разряд:</label>
                                </div>
                                <div class="col-5">
                                    <select id="discharge" name="discharge" class="form-control">
                                        <c:forEach var="discharge" items="${Discharge}">
                                            <c:if test="${discharge.discharge_id == map.discharge.discharge_id}">
                                                <option value="${discharge.discharge_id}"
                                                        selected>${discharge.valueDischarge}</option>
                                            </c:if>
                                            <c:if test="${discharge.discharge_id != map.discharge.discharge_id}">
                                                <option value="${discharge.discharge_id}">${discharge.valueDischarge}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-5"></div>
                            </div>

                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="typeMapTable">Тип карты нормирования:</label>
                                </div>
                                <div class="col-5">
                                    <select id="typeMapTable" name="typeMapTable" class="form-control">
                                        <c:forEach var="typeMap" items="${TypeMapTable}">
                                            <c:if test="${typeMap.type_id == map.typeMapTable.type_id}">
                                                <option value="${typeMap.type_id}" selected>${typeMap.nameType}</option>
                                            </c:if>
                                            <c:if test="${typeMap.type_id != map.typeMapTable.type_id}">
                                                <option value="${typeMap.type_id}">${typeMap.nameType}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-5"></div>
                            </div>

                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="formula">Формула:</label>
                                </div>
                                <div class="col-5">
                                    <input id="formula" class="form-control"
                                           value="${map.formula}" name="formulaMap">
                                </div>
                                <div class="col-5"></div>
                            </div>

                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label>Управление</label>
                                </div>
                                <div class="col-5">
                                    <button class="btn btn-outline-primary mb-2" id="save" type="submit" ${save}>
                                        Сохранить
                                        изменения
                                    </button>

                                    <button class="btn btn-outline-primary mb-2" data-toggle="modal"
                                            data-target="#cloneMapTable" id="clone" onclick="findAllCollection()"
                                            type="button" ${save}>
                                        Клонировать
                                    </button>
                                    <button class="btn btn-outline-secondary mb-2"
                                            onclick="deleteMapTableById(${map.mapTable_id})"
                                            type="button" id="deleteMapTable" ${delete}>Удалить
                                        карту
                                    </button>
                                </div>
                                <div class="col-5"></div>
                            </div>
                        </form>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label>PDF представление:</label>
                            </div>
                            <div class="col-4">

                                <form id="upload-container" accept-charset='utf-8' enctype="multipart/form-data"
                                      method="post"
                                      action="${pageContext.request.contextPath}/uploadFileMapTable">
                                    <label for="map_id"></label>
                                    <input id="map_id" name="mapTable_id" value="${map.mapTable_id}" hidden>
                                    <label for="fileName"></label>
                                    <input id="fileName" name="fileName" value="" hidden>
                                    <label for="file-input"></label>
                                    <span id="spanBtn" class="btn btn-outline-secondary btn-file"> Изменить
                                         <input id="file-input" onchange="selectFile(this.value)"
                                         ${selectFile}
                                                style="margin-bottom: 10px;" type="file" name="file">
                                    </span>
                                    <a id="downloadFile" style="margin-right: 10px;" href="${downloadFileMap}"
                                       class="btn btn-outline-secondary ${disabledDownloadFile} ">Просмотр</a>
                                </form>
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
<script src="http://localhost:8081/cstrmo/js/uploadFile.js"></script>
<script src="http://localhost:8081/cstrmo/js/structureCollection.js"></script>
</html>
