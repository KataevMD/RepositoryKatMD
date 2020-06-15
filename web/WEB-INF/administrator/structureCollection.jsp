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
    <script src="http://localhost:8081/cstrmo/js/structureCollection.js"></script>
</head>
<body class="d-flex flex-column h-100">
<!-- Modal -->
<div class="modal fade" id="waitAnswer" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="container text-center">
            <div class="spinner-border text-info" style="width: 6rem; height: 6rem;" role="status">
                <span class="sr-only">Loading...</span>
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

    <div class="row pl-md-3 pb-md-3">
        <div id="loadCollection" class="col">
            <data id="dataLoadCollection" value="1212">
                <div class="container text-center">
                    <p class="h4 mt-auto">Справочник "${collection.nameCollectionMapTable}"</p>
                </div>
                <form method="post" id="formUpdateCollection"
                      action="${pageContext.request.contextPath}/updateCollMapTable">
                    <label for="collection_id"></label><input id="collection_id" name="idColl"
                                                              value="${collection.collection_id}" hidden>
                    <div class="row">
                        <div class="col-1 ml-3">
                            <label for="nameCollection">Название справочника:</label>
                        </div>

                        <div class="col-2">
                            <input id="nameCollection" name="nameCollMapTable"
                                   value="${collection.nameCollectionMapTable}"
                                   class="form-control">
                        </div>

                        <div class="col-1">
                            <button class="btn btn-outline-primary" type="submit" id="updateCollection">
                                Сохранить изменения
                            </button>
                        </div>
                        <div class="col-1">
                            <button class="btn btn-outline-secondary" type="button" id="deleteCollection">Удалить
                                справочник
                            </button>
                        </div>
                        <div class="col-6">
                            <button class="btn btn-outline-secondary" type="button" id="structure">Структура справочника
                            </button>
                        </div>
                    </div>
                </form>
            </data>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row" style="min-height: 650px; max-height: 700px;">
            <div class="col mr-md-5 px-md-5 overflow-auto ">
                <%--Структура справочника--%>
                <label for="search">Поиск: </label><input style="margin-bottom: 10px;" autocomplete="off"
                                                          class="form-control" id="search">
                <div id="jstree">
                    <!-- in this example the tree is populated from inline HTML -->
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
                                                            <li
                                                                    onclick="findMapTable(${mapTable.mapTable_id})">
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
            </div>
            <label for="Col"></label><input id="Col" value="${collection_Id}"
                                            hidden>
            <div class="col col-8 mr-md-5 pb-md-3 pt-md-5 border border-secondary" style="min-width: 1000px;">
                <div id="blockWithUpdateMapTable" hidden>
                    <data id="loadData" value="11212">
                        <div class="container text-center">
                            <p class="h4">Карта "${map.name}"</p>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <a id="openParamAndCoeff" class="btn btn-outline-secondary btn-sm ${viewParam}"
                                   href="${showPage}">Просмотр параметров и коэффициентов</a>
                            </div>
                            <div class="col-4">
                            </div>
                            <div class="col-6"></div>
                        </div>
                        <form id="formUpdateMap" method="post"
                              action="${pageContext.request.contextPath}/updateMapTable">
                            <label for="id"></label><input id="id" name="mapTable_id" value="${map.mapTable_id}"
                                                           hidden>
                            <br><label for="Collid"></label><input id="Collid" name="collection_Id"
                                                                   hidden>
                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="numberMap"> Номер карты:</label>
                                </div>
                                <div class="col-4">
                                    <input id="numberMap" name="numberMapTable" value="${map.numberTable}"
                                           class="form-control" pattern="^[0-9]+$"
                                           title="Разрешено использовать цифры" required>
                                </div>
                                <div class="col-6"></div>
                            </div>
                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="nameMap"> Название карты:</label>
                                </div>
                                <div class="col-4">
                                    <input id="nameMap" name="nameMapTable" pattern="^[А-Яа-яЁё,\s]+$"
                                           title="Разрешено использовать только пробелы и русские буквы"
                                           value="${map.name}" class="form-control" required>
                                </div>
                                <div class="col-6"></div>
                            </div>
                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="typeTimes"> Тип возвращаемого времени:</label>
                                </div>
                                <div class="col-4">
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
                                <div class="col-6"></div>

                            </div>

                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="discharge">Разряд:</label>
                                </div>
                                <div class="col-4">
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
                                <div class="col-6"></div>
                            </div>

                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label for="typeMapTable">Тип карты нормирования:</label>
                                </div>
                                <div class="col-4">
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
                                <div class="col-6"></div>
                            </div>
                            <c:forEach var="formula" items="${Formula}">
                                <div class="row mt-md-3">
                                    <div class="col-3">
                                        <label for="formula${formula.formula_id}">Формула:</label>
                                    </div>
                                    <div class="col-4">
                                        <input id="formula${formula.formula_id}" class="form-control"
                                               value="${formula.formula}" name="formulaMap${formula.formula_id}">
                                    </div>
                                    <div class="col-6"></div>
                                </div>
                            </c:forEach>
                            <div class="row mt-md-3">
                                <div class="col-3">
                                    <label>Управление</label>
                                </div>
                                <div class="col-4">
                                    <button class="btn btn-outline-primary" id="save" type="submit" ${save}>Сохранить
                                        изменения
                                    </button>
                                    <button class="btn btn-outline-secondary" id="deleteMapTable" ${delete}>Удалить
                                        карту
                                    </button>
                                </div>
                                <div class="col-6"></div>
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
                <div id="blockWithUpdateStructure">

                    <div class="row">
                        <div class="col-4">
                            <label>Поиск коэффициента по названию:
                                <input class="form-control" onkeyup="filterCoeff(this)" type="text"/>
                            </label>
                        </div>
                        <div id="loadCoefficient" class="col pt-2">
                            <data id="dataLoadCoefficient" value="1212">
                                <form id="formUpdateCoefficient" method="post"
                                      action="${pageContext.request.contextPath}/updateCoefficient">
                                    <div class="row">
                                        <label for="map_d"></label><input id="map_d" name="mapTable_id" hidden>
                                        <label for="coefficient_id"></label><input id="coefficient_id"
                                                                                   name="coefficient_id"
                                                                                   value="${coefficient.coefficient_id}"
                                                                                   hidden>
                                        <div class="col">
                                            <label for="nameCoefficient"> Название параметра:</label>
                                        </div>
                                        <div class="col-4">
                                            <input id="nameCoefficient" name="nameCoefficient"
                                                   value="${coefficient.name}"
                                                   class="form-control" pattern="^[А-Яа-яЁё/,\s]+$"
                                                   title="Разрешено использовать пробелы, русские буквы и запятые."
                                                   required>
                                        </div>
                                        <div class="col">
                                            <button class="btn btn-outline-primary" id="saveCoeff" type="submit"
                                                    disabled>Сохранить
                                                изменений
                                            </button>
                                        </div>
                                        <div class="col">
                                            <button class="btn btn-outline-secondary" type="button" id="deleteCoeff"
                                                    onclick="deleteCoefficientById()" disabled>
                                                Удалить коэффициент
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                <hr>
                            </data>

                        </div>
                    </div>
                    <div class="row">
                        <div id="loadListCoeff" class="col col-4">
                            <data id="dataListCoeff" value="1313">
                                <ul id="listCoeff" class="list-group" style="cursor: pointer">
                                    <c:forEach var="coefficient" items="${Coefficient}">
                                        <li class="list-group-item list-group-item-action"
                                            onclick="getListValueCoeff(<c:out
                                                    value="${coefficient.coefficient_id}"/>)">
                                            <c:out value="${coefficient.name}"/>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </data>
                        </div>
                        <div id="loadListValueCoeff" class="col">
                            <data id="dataListValueCoeff" value="1313">
                                <ul id="listValueCoeff" class="list-group" style="cursor: pointer">
                                    <c:forEach var="valueCoefficient" items="${ValueCoefficient}">
                                        <li class="list-group-item list-group-item-action"
                                            onclick="findValueCoeff(<c:out
                                                    value="${valueCoefficient.coeffValue_id}"/>)">
                                            <c:out value="${valueCoefficient.valName}"/>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </data>
                        </div>
                        <div id="loadValueCoeff" class="col">
                            <data id="dataValueCoeff" value="1212">
                                <form method="post" id="formUpdateValueCoeff"
                                      action="${pageContext.request.contextPath}/updateValueCoefficient">
                                    <label for="coeff_id"></label><input id="coeff_id" name="coefficient_id"
                                                                         value="${valueCoefficient.coefficient.coefficient_id}"
                                                                         hidden>
                                    <label for="valueCoeff_id"></label><input id="valueCoeff_id"
                                                                              name="coeffValue_id"
                                                                              value="${valueCoefficient.coeffValue_id}"
                                                                              hidden>
                                    <div class="row mt-md-3">
                                        <div class="col-4">
                                            <label for="valName"> Название значения:</label>
                                        </div>
                                        <div class="col">
                                            <input id="valName" name="valName"
                                                   value="${valueCoefficient.valName}"
                                                   class="form-control" pattern="^[А-Яа-яЁё/,\s]+$"
                                                   title="Разрешено использовать пробелы, русские буквы, заглавные буквы латинского алфавита и запятые."
                                                   required>
                                        </div>
                                    </div>
                                    <div class="row mt-md-3">
                                        <div class="col-4">
                                            <label for="value"> Значение:</label>
                                        </div>
                                        <div class="col">
                                            <input id="value" name="value" value="${valueCoefficient.value}"
                                                   class="form-control" pattern="\d+(\.\d{1,9})?"
                                                   title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                                                   required>
                                        </div>
                                    </div>
                                    <div class="row mt-md-3">
                                        <div class="col-4">
                                            Управление:
                                        </div>
                                        <div class="col">
                                            <button class="btn btn-outline-primary" id="saveValueCoeff"
                                                    type="submit" disabled>Сохранить
                                                изменения
                                            </button>
                                        </div>
                                        <div class="col">
                                            <button class="btn btn-outline-secondary"
                                                    onclick="deleteValueCoefficientById()" type="button"
                                                    id="deleteValueCoeff"
                                                    disabled>Удалить значение
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </data>
                        </div>
                    </div>
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
<script src="http://localhost:8081/cstrmo/js/mapTable.js"></script>
</html>
