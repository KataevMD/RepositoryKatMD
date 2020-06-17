<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 16.06.2020
  Time: 18:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Единая база нормативов технологических операций</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script src="http://localhost:8081/cstrmo/js/uploadFile.js"></script>
    <script src="http://localhost:8081/cstrmo/js/rewriteStructureCollection.js"></script>
</head>
<body class="d-flex flex-column h-100">
<%--Модальное окно создания новой главы--%>
<div class="modal fade" id="createChapter" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Создание новой главы справочника</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="post" id="formCreateChapter"
                      action="${pageContext.request.contextPath}/addNewChapter">
                    <label for="formNewChapter"></label><input id="formNewChapter"
                                                               name="collection_id"
                                                               value="${collection.collection_id}"
                                                               hidden>
                    <div class="container-fluid">
                        <label for="nameChapters">Введите название главы:</label>
                        <input id="nameChapters" name="nameChapter"
                               class="form-control" pattern="^[А-Яа-я0-9Ёё,\s]+$"
                               title="Разрешено использовать пробелы, русские буквы, запятые и цифры."
                               required>
                        <div class="mt-3">
                            <button class="btn btn-outline-primary mr-5 " id="createChapters" type="submit">
                                Создать новую главу
                            </button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%--Модальное окно создания нового раздела--%>
<div class="modal fade" id="createSection" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabelSection">Создание нового раздела</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="post" id="formCreateSection"
                      action="${pageContext.request.contextPath}/addNewSection">

                    <label for="formNewSection"></label><input id="formNewSection"
                                                               name="collection_id"
                                                               value="${collection.collection_id}" hidden>
                    <div class="container-fluid">
                        <br>
                        <div id="loadChapters">
                            <data id="dataChapters" value="1313">
                                Выбирите главу, в которую будет добавлен новый раздел
                                <select id="selectChapter" name="chapter_id" class="list-group form-control"
                                        style="cursor: pointer">
                                    <c:forEach var="chapter" items="${Chapter}">
                                        <option class="list-group-item list-group-item-action"
                                                value="<c:out value="${chapter.chapter_id}"/>">
                                            <c:out value="${chapter.nameChapter}"/>
                                        </option>
                                    </c:forEach>

                                </select>
                            </data>
                        </div>
                        <div class="mt-3">
                            <label for="nameSections">Введите название раздела:</label>
                            <input id="nameSections" name="nameSection"
                                   class="form-control" pattern="^[А-Яа-я/0-9Ёё,\s]+$"
                                   title="Разрешено использовать пробелы, русские буквы, запятые и цифры."
                                   required>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-outline-primary  mr-5" id="createSections" type="submit">
                                Создать раздел
                            </button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
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
                <a class="nav-link " href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="javascript:history.go(-1);">Карты</a>
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

<main role="main" class="flex-shrink-0">
    <br>
    <label>
        <input id="collection_Id" value="${collection.collection_id}" hidden>
    </label>
    <div class="container text-center">
        <p class="h4 mt-auto">Главы и разделы справочника "${collection.nameCollectionMapTable}"</p>
    </div>
    <br>

    <div class="container-fluid">
        <div class="row pb-4">
            <div class="col">
                <a class="btn btn-outline-secondary"
                   href="http://localhost:8081/cstrmo/openStructureCollectionPage?collection_id=${collection.collection_id}">Вернуться
                    к просмотру карт</a>
            </div>
        </div>
        <div class="row" style="min-height: 400px; max-height: 700px;">
            <div class="col-2 pt-md-3 ">
                <div class="list-group" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-chapter-list" data-toggle="list"
                       href="#list-chapter" role="tab" aria-controls="chapter">Главы</a>
                    <a class="list-group-item list-group-item-action" id="new-mapTable-list" data-toggle="list"
                       href="#list-newMapTable" role="tab" aria-controls="newMapTable">Новая карта</a>
                </div>
            </div>
            <div class="col-9 border border-secondary" style="min-width: 1000px;">
                <div class="tab-content" id="nav-tabContent">

                    <div class="tab-pane fade show active  pb-3 mb-3" id="list-chapter" role="tabpanel"
                         aria-labelledby="list-chapter-list">
                        <div class="row mt-4">
                            <div class="col-4  border border-secondary border-top-0 border-bottom-0 border-left-0">
                                <label>Поиск главы по названию:
                                    <input class="form-control" onkeyup="filterChapter(this)" type="text"/>
                                </label>
                            </div>
                            <div id="loadChapter"
                                 class="col-7 border border-secondary border-bottom-0 border-left-0 border-right-0">
                                <data id="dataChapter" value="1212">
                                    <form method="post" id="formUpdateChapter"
                                          action="${pageContext.request.contextPath}/updateChapter">
                                        <div class="row mt-md-3">
                                            <label for="col_id"></label><input id="col_id" name="collection_id" hidden>
                                            <label for="chapter_id"></label><input id="chapter_id"
                                                                                   name="chapter_id"
                                                                                   value="${chapter.chapter_id}"
                                                                                   hidden>
                                            <div class="col">
                                                <label for="nameChapter"> Название главы:</label>
                                            </div>
                                            <div class="col-6">
                                                <input id="nameChapter" name="nameChapter"
                                                       value="${chapter.nameChapter}"
                                                       class="form-control" pattern="^[А-Яа-я0-9Ёё,\s]+$"
                                                       title="Разрешено использовать пробелы, русские буквы, запятые и цифры."
                                                       required>
                                            </div>
                                            <div class="col mr-4">
                                                <button class="btn btn-outline-primary" id="saveChapter" type="submit"
                                                        disabled>Сохранить
                                                    изменения
                                                </button>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-secondary" type="button"
                                                        onclick="deleteChapterById()"
                                                        id="deleteChapter" disabled>
                                                    Удалить главу
                                                </button>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                                        data-target="#createChapter" type="button">
                                                    Создать главу
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </data>
                            </div>
                            <div class="col border border-secondary border-bottom-0 border-left-0 border-right-0"></div>
                        </div>
                        <div class="row">
                            <div class="col col-4 border border-secondary border-top-0 border-bottom-0 border-left-0">
                                <p class="h5 mt-auto">Список глав</p>
                            </div>
                            <div class="col"><p class="h5 mt-auto">Список разделов</p></div>
                            <div class="col"></div>
                        </div>
                        <div class="row">
                            <div id="loadListChapter"
                                 class="col col-4  border border-secondary border-top-0 border-bottom-0 border-left-0">
                                <data id="dataListChapter" value="1212">
                                    <ul id="listChapter" class="list-group" style="cursor: pointer">
                                        <c:forEach var="chapter" items="${Chapter}">
                                            <li class="list-group-item list-group-item-action"
                                                onclick="findChapter(<c:out value="${chapter.chapter_id}"/>)">
                                                <c:out value="${chapter.nameChapter}"/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </data>
                            </div>
                            <div id="loadListSection"
                                 class="col pb-2 border border-secondary border-left-0 border-top-0 border-right-0">
                                <data id="dataListSection" value="1313">
                                    <ul id="listSection" class="list-group" style="cursor: pointer">
                                        <c:forEach var="section" items="${Section}">
                                            <li class="list-group-item list-group-item-action"
                                                onclick="findSection(<c:out
                                                        value="${section.section_id}"/>)">
                                                <c:out value="${section.nameSection}"/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </data>
                            </div>
                            <div id="loadSection"
                                 class="col border border-secondary border-left-0 border-top-0 border-right-0">
                                <data id="dataSection" value="1212">
                                    <form method="post" id="formUpdateSection"
                                          action="${pageContext.request.contextPath}/updateSection">
                                        <label for="chapters_id"></label><input id="chapters_id" name="chapter_id"
                                                                                value="${listSection.chapter.chapter_id}"
                                                                                hidden>
                                        <label for="section_id"></label><input id="section_id"
                                                                               name="section_id"
                                                                               value="${listSection.section_id}"
                                                                               hidden>
                                        <div class="row">
                                            <div class="col-4">
                                                <label for="nameSection"> Название раздела:</label>
                                            </div>
                                            <div class="col">
                                                <input id="nameSection" name="nameSection"
                                                       value="${listSection.nameSection}"
                                                       class="form-control" pattern="^[А-Яа-яЁё0-9/,\s]+$"
                                                       title="Разрешено использовать пробелы, русские буквы, запятые и цифры."
                                                       required>
                                            </div>
                                        </div>
                                        <div class="row mt-md-">
                                            <div class="col-4">
                                                Управление:
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-primary" id="saveSection"
                                                        type="submit" disabled>Сохранить
                                                    изменения
                                                </button>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-secondary"
                                                        onclick="deleteSectionById()" type="button"
                                                        id="deleteSection"
                                                        disabled>Удалить раздел
                                                </button>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col"></div>
                                            <div class="col ml-5">
                                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                                        data-target="#createSection" type="button">
                                                    Создать раздел
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </data>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade pb-3 mb-3" id="list-newMapTable" role="tabpanel"
                         aria-labelledby="list-newSection-list">
                        <form id="formCreateNewMapTable" method="post"
                              action="${pageContext.request.contextPath}/addNewMapTable">
                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="chapterCollection"> Глава:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <data id="lChapter" value="1313">

                                        <select id="chapterCollection" onchange="getSection(this)" class="form-control"
                                                required>
                                            <c:forEach var="lChapteCollection" items="${Chapter}">
                                                <option value="${lChapteCollection.chapter_id}">${lChapteCollection.nameChapter}</option>
                                            </c:forEach>
                                        </select>
                                    </data>
                                </div>
                            </div>
                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="sectionsChapter"> Раздел:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <div id="lSection">
                                        <data id="dataLSection" value="1313">

                                            <select id="sectionsChapter" name="sections" class="form-control" required>
                                                <c:forEach var="lSectionChapter" items="${listSectionChapter}">
                                                    <option value="${lSectionChapter.section_id}">${lSectionChapter.nameSection}</option>
                                                </c:forEach>
                                            </select>
                                        </data>
                                    </div>

                                </div>
                            </div>
                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="numMap"> Номер карты:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <input id="numMap" name="numberMapTable"
                                           class="form-control" pattern="^[0-9]+$"
                                           title="Разрешено использовать цифры" required>
                                </div>

                            </div>

                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="namMap"> Название карты:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <input id="namMap" name="nameMapTable" pattern="^[А-Яа-яЁё,\s]+$"
                                           title="Разрешено использовать только пробелы и русские буквы"
                                           class="form-control" required>
                                </div>

                            </div>
                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="tTimes"> Тип возвращаемого времени:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <select id="tTimes" name="typeTimes" class="form-control" required>
                                        <c:forEach var="typeTimeMap" items="${TypeTime}">
                                            <option value="${typeTimeMap.typeTime_id}">${typeTimeMap.nameTypeTime}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>

                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="discharg">Разряд:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <select id="discharg" name="discharge" class="form-control" required>
                                        <c:forEach var="discharge" items="${Discharge}">
                                            <option value="${discharge.discharge_id}">${discharge.valueDischarge}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>

                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label for="tMapTable">Тип карты нормирования:</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <select id="tMapTable" name="typeMapTable" class="form-control" required>
                                        <c:forEach var="typeMap" items="${TypeMapTable}">
                                            <option value="${typeMap.type_id}">${typeMap.nameType}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>
                            <div class="row mt-md-3">
                                <div class="col-4">
                                    <label>Управление</label>
                                </div>
                                <div class="col-4" style="min-width: 50%;">
                                    <button class="btn btn-outline-primary" id="createMap" type="submit">Создать карту
                                    </button>
                                    <button class="btn btn-outline-secondary" data-dismiss="modal" id="cancel">Отмена
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>

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
