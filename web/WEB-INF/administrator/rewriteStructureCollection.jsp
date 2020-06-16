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
    <script src="http://localhost:8081/cstrmo/js/coefficientAndParameters.js"></script>
    <script src="http://localhost:8081/cstrmo/js/uploadFile.js"></script>

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
        <div class="row" style="min-height: 400px; max-height: 700px;">
            <div class="col-2 pt-md-3 ">
                <div class="list-group" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-chapter-list" data-toggle="list"
                       href="#list-chapter" role="tab" aria-controls="chapter">Главы</a>

                    <a class="list-group-item list-group-item-action" id="new-parameter-list" data-toggle="list"
                       href="#list-newChapter" role="tab" aria-controls="newParameter">Новая глава</a>
                    <a class="list-group-item list-group-item-action" id="new-coefficient-list" data-toggle="list"
                       href="#list-newSection" role="tab" aria-controls="newCoefficient">Новый раздел</a>

                </div>
            </div>
            <div class="col-9 pt-md-3 border border-secondary" style="min-width: 1000px;">
                <div class="tab-content" id="nav-tabContent">

                    <div class="tab-pane fade show active" id="list-chapter" role="tabpanel"
                         aria-labelledby="list-chapter-list">
                        <div class="row">
                            <div class="col-4">
                                <label>Поиск главы по названию:
                                    <input class="form-control" onkeyup="filterChapter(this)" type="text"/>
                                </label>
                            </div>
                            <div id="loadChapter" class=" col-7">
                                <data id="dataChapter" value="1212">
                                    <form method="post" id="formUpdateChapter"
                                          action="${pageContext.request.contextPath}/updateChapter">
                                        <div class="row mt-md-3">
                                            <label for="col_id"></label><input id="col_id" name="collection_id" hidden>
                                            <label for="chapter_id"></label><input id="chapter_id"
                                                                                   name="chapter_id"
                                                                                   value="${chapter.chapter_id}"
                                                                                   hidden>
                                            <div class="col-4">
                                                <label for="nameChapter"> Название главы:</label>
                                            </div>
                                            <div class="col">
                                                <input id="nameChapter" name="nameChapter"
                                                       value="${chapter.nameChapter}"
                                                       class="form-control" pattern="^[А-Яа-я0-9Ёё,\s]+$"
                                                       title="Разрешено использовать пробелы, русские буквы, запятые и цифры."
                                                       required>
                                            </div>
                                        </div>
                                        <div class="row mt-md-3">
                                            <div class="col-4">
                                                Управление:
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-primary" id="saveChapter" type="submit"
                                                        disabled>Сохранить
                                                    изменения
                                                </button>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-secondary" type="button"
                                                        onclick="deleteChapter()"
                                                        id="deleteChapter" disabled>
                                                    Удалить главу
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </data>
                            </div><hr>
                        </div>
                        <div class="row">
                            <div id="loadListChapter" class="col col-4">
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
                            <div id="loadListSection" class="col">
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
                            <div id="loadSection" class="col">
                                <data id="dataSection" value="1212">
                                    <form method="post" id="formUpdateValueCoeff"
                                          action="${pageContext.request.contextPath}/updateSection">
                                        <label for="chapters_id"></label><input id="chapters_id" name="chapter_id"
                                                                             value="${listSection.chapter.chapter_id}"
                                                                             hidden>
                                        <label for="section_id"></label><input id="section_id"
                                                                                  name="section_id"
                                                                                  value="${listSection.section_id}"
                                                                                  hidden>
                                        <div class="row mt-md-3">
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
                                        <div class="row mt-md-3">
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
                                    </form>
                                </data>
                            </div>
                        </div>
                    </div>



                    <div class="tab-pane fade" id="list-newChapter" role="tabpanel"
                         aria-labelledby="list-newChapter-list">
                        <form method="post" id="formCreateChapter"
                              action="${pageContext.request.contextPath}/addNewChapter">

                            <label for="formNewPramMapTableId"></label><input id="formNewPramMapTableId"
                                                                              name="mapTable_id" value="${mapTable_Id}"
                                                                              hidden>
                            <div class="container-fluid">
                                <div class="container text-center">
                                    <p class="h5 mt-auto">Создание нового параметра</p>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col pb-md-3">
                                        <label for="nameParameter">Введите название параметра:</label>
                                    </div>
                                    <div class="col-4 pb-md-3">
                                        <input id="nameParameter" name="nameParameter"
                                               class="form-control" pattern="^[А-Яа-яA-ZЁё,\s]+$"
                                               title="Разрешено использовать пробелы, русские буквы, заглавные буквы латинского алфавита и запятые."
                                               required>
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col pb-md-3">
                                        <label for="stepParameter">Введите степень параметра:</label>
                                    </div>
                                    <div class="col-4 pb-md-3">
                                        <input id="stepParameter" name="stepParameter"
                                               class="form-control" pattern="\d+(\.\d{1,9})?"
                                               title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                                               required>
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col"></div>
                                    <div class="col-4 pb-md-3">
                                        <button class="btn btn-outline-primary" id="createParam" type="submit">
                                            Создать параметр
                                        </button>
                                    </div>
                                    <div class="col"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="list-newSection" role="tabpanel"
                         aria-labelledby="list-newSection-list">
                        <form method="post" id="formCreateSection"
                              action="${pageContext.request.contextPath}/addNewSection">

                            <label for="formNewCoeffMapTableId"></label><input id="formNewCoeffMapTableId"
                                                                               name="mapTable_id" value="${mapTable_Id}"
                                                                               hidden>
                            <div class="container-fluid">
                                <div class="container text-center">
                                    <p class="h5 mt-auto">Создание нового коэффициента</p>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col pb-md-3">
                                        <label for="nameParameter">Введите название коэффициента:</label>
                                    </div>
                                    <div class="col-4 pb-md-3">
                                        <input id="nameCoeff" name="nameCoefficient"
                                               class="form-control" pattern="^[А-Яа-яЁё/,\s]+$"
                                               title="Разрешено использовать пробелы, русские буквы, и /."
                                               required>
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col pb-md-3">
                                    </div>
                                    <div class="col-4 pb-md-3">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col"></div>
                                    <div class="col-4 pb-md-3">
                                        <button class="btn btn-outline-primary" id="createCoefficient" type="submit">
                                            Создать коэффициент
                                        </button>
                                    </div>
                                    <div class="col"></div>
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
<script src="http://localhost:8081/cstrmo/js/rewriteStructureCollection.js"></script>
<script src="http://localhost:8081/cstrmo/js/filters.js"></script>
</html>
