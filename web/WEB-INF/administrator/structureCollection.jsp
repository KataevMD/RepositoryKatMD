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
<div class="modal fade" id="waitAnswer" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
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
<main role="main" class="flex-shrink-0">
    <div class="container text-center">
        <p class="h4 mt-auto">Справочник "${nameCollMapTable}"</p>
    </div>
    <br>

    <div class="container-fluid">
        <div class="row" style="min-height: 650px; max-height: 700px;">
            <div class="col mr-md-5 px-md-5 overflow-auto ">
                <%--Структура справочника--%>
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

            <div class="col col-8 mr-md-5 pt-md-5 border border-secondary">


                <div id="loadMapTable">
                    <data id="loadData" value="11212">
                                                <form>

                        <div class="container text-center">
                            <p class="h4">Карта "${map.name}"</p>
                        </div>
                        <br>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="numberMap"> Номер карты:</label>
                            </div>
                            <div class="col-4">
                                <input id="numberMap" name="numberMapTable" value="${map.numberTable}"
                                       class="form-control">
                            </div>
                            <div class="col-6"></div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-3">
                                <label for="nameMap"> Название карты:</label>
                            </div>
                            <div class="col-4">
                                <input id="nameMap" name="numberMapTable" value="${map.name}" class="form-control">
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

                                            <option selected>${typeTimeMap.nameTypeTime}</option>

                                        </c:if>

                                        <c:if test="${typeTimeMap.typeTime_id != map.typeTime.typeTime_id}">

                                            <option>${typeTimeMap.nameTypeTime}</option>

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
                                    <c:if test="${map.discharge == 1}">
                                        <option selected>1</option>
                                    </c:if>
                                    <c:if test="${map.discharge == 2}">
                                        <option selected>2</option>
                                    </c:if>
                                    <c:if test="${map.discharge == 3}">
                                        <option selected>3</option>
                                    </c:if>
                                    <c:if test="${map.discharge == 4}">
                                        <option selected>4</option>
                                    </c:if>
                                    <c:if test="${map.discharge == 5}">
                                        <option selected>5</option>
                                    </c:if>
                                    <c:if test="${map.discharge == 6}">
                                        <option selected>6</option>
                                    </c:if>

                                    <c:if test="${map.discharge != 1}">
                                        <option>1</option>
                                    </c:if>
                                    <c:if test="${map.discharge != 2}">
                                        <option>2</option>
                                    </c:if>
                                    <c:if test="${map.discharge != 3}">
                                        <option>3</option>
                                    </c:if>
                                    <c:if test="${map.discharge != 4}">
                                        <option>4</option>
                                    </c:if>
                                    <c:if test="${map.discharge != 5}">
                                        <option>5</option>
                                    </c:if>
                                    <c:if test="${map.discharge != 6}">
                                        <option>6</option>
                                    </c:if>
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

                                        <c:if test="${typeMap.type_id == map.typeTime.typeTime_id}">

                                            <option selected>${typeMap.nameType}</option>

                                        </c:if>

                                        <c:if test="${typeMap.type_id != map.typeTime.typeTime_id}">

                                            <option>${typeMap.nameType}</option>

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
                                    <input id="file-input" onchange="selectFile(this.value)"
                                           style="margin-bottom: 10px;" type="file" name="file" ${selectFile}>
                                </form>
                                <a id="downloadFile" style="margin-right: 10px;" href="${downloadFileMap}"
                                   class="btn btn-light ${disabledDownloadFile} ">Скачать файл</a>
                                <button id="deleteFile" class="btn btn-light"
                                        onclick="deleteFile()" ${disabledDeleteFile}>Удалить файл
                                </button>
                            </div>
                            <div class="col-6"></div>
                        </div>
                    </data>
                </div>

            </div>
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
<script src="http://localhost:8081/cstrmo/js/uploadFile.js"></script>
</html>