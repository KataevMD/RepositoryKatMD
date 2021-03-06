<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 31.05.2020
  Time: 15:37
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

    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script src="http://localhost:8081/cstrmo/js/coefficientAndParameters.js"></script>
    <script src="http://localhost:8081/cstrmo/js/uploadFile.js"></script>
    <script src="http://localhost:8081/cstrmo/js/jquery.maskedinput.js"></script>

</head>
<body class="d-flex flex-column h-100">
<%--Модальное окно создания нового коэффициента--%>
<div class="modal fade" id="createCoefficient" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Создание нового коэффициента</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="post" id="formCreateCoefficient"
                      action="${pageContext.request.contextPath}/addNewCoefficient">

                    <label for="formNewCoeffMapTableId"></label><input id="formNewCoeffMapTableId"
                                                                       name="mapTable_id"
                                                                       value="${mapTable.mapTable_id}"
                                                                       hidden>
                    <div class="container-fluid">
                        <div class="mt-3">
                            <label for="nameCoeff">Введите название коэффициента:</label>
                            <input id="nameCoeff" name="nameCoefficient"
                                   class="form-control" pattern="^[А-Яа-яЁё/,\s]+$"
                                   title="Разрешено использовать пробелы, русские буквы, и /."
                                   required>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-outline-primary mr-5" id="createCoefficients" type="submit">
                                Создать коэффициент
                            </button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%--Модальное окно создания нового параметра--%>
<div class="modal fade" id="createParam" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdrop">Создание нового параметра</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="post" id="formCreateParameter"
                      action="${pageContext.request.contextPath}/addNewParameter">

                    <label for="formNewPramMapTableId"></label><input id="formNewPramMapTableId"
                                                                      name="mapTable_id"
                                                                      value="${mapTable.mapTable_id}"
                                                                      hidden>
                    <div class="container-fluid">
                        <div class="mt-3">
                            <label for="nameParameter">Введите название параметра:</label>
                            <input id="nameParameter" name="nameParameter"
                                   class="form-control" pattern="^[А-Яа-яA-ZЁё,\s]+$"
                                   title="Разрешено использовать пробелы, русские буквы, заглавные буквы латинского алфавита и запятые."
                                   required>
                        </div>

                        <div class="mt-3">
                            <label for="stepParameter">Введите степень параметра:</label>
                            <input id="stepParameter" type="number" step="any"  name="stepParameter"
                                   class="stepParam form-control"
                                   pattern="\d+(\.\d{1,9})?"
                                   title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                                   required>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-outline-primary mr-5" id="createParams" type="submit">
                                Создать параметр
                            </button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%--Модальное окно создания нового значения коэффициента--%>
<div class="modal fade" id="createValueCoeff" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabelSection">Создание нового значения коэффициента</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form method="post" id="formCreateValueCoefficient"
                      action="${pageContext.request.contextPath}/addNewValueCoefficient">

                    <label for="formNewValueCoeffMapTableId"></label><input id="formNewValueCoeffMapTableId"
                                                                            name="mapTable_id"
                                                                            value="${mapTable.mapTable_id}"
                                                                            hidden>
                    <div class="container-fluid">
                        <br>
                        <div id="loadCoeff">
                            <data id="dataCoeff" value="1313">
                                Выберите коэффициент, в который будет добавлено новое значение коэффициента:
                                <select id="listCoef" name="coefficient_id" class="list-group form-control"
                                        style="cursor: pointer">
                                    <c:forEach var="coefficient" items="${Coefficient}">
                                        <option
                                                value="<c:out value="${coefficient.coefficient_id}"/>">
                                            <c:out value="${coefficient.name}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </data>
                        </div>
                        <div class="mt-3">
                            <label for="nameValueCoeff">Введите название значения:</label>
                            <input id="nameValueCoeff" name="valName"
                                   class="form-control" pattern="^[А-Яа-я/Ёё,\s]+$"
                                   title="Разрешено использовать пробелы, русские буквы, и запятые."
                                   required>
                        </div>
                        <div class="mt-3">
                            <label for="valueCoeff">Введите значение:</label>
                            <input id="valueCoeff" name="value" type="number" step="any"
                                   class="form-control" pattern="\d+(\.\d{1,9})?"
                                   title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                                   required>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-outline-primary" id="createValueCoeffs" type="submit">
                                Создать значение коэффициента
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
    <div class="container text-center">
        <p class="h4 mt-auto">Карта "${mapTable.name}"</p>
    </div>
    <label for="mapTableId"></label><input id="mapTableId" name="mapTable_id" value="${mapTable.mapTable_id}"
                                           hidden>
    <br>
    <div class="container-fluid">
        <div class="row pb-4">
            <div class="col">
                <a class="btn btn-outline-secondary"
                   href="http://localhost:8081/cstrmo/openStructureCollectionPageWithMap?mapTable_id=${mapTable.mapTable_id}&collection_id=${collection_id}">Вернуться
                    к просмотру карт</a>
            </div>
        </div>
        <div class="row" style="min-height: 400px; max-height: 700px;">
            <div class="col-2 pt-md-3 ">
                <div class="list-group" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-parameter-list" data-toggle="list"
                       href="#list-parameter" role="tab" aria-controls="parameter">Параметры</a>

                    <a class="list-group-item list-group-item-action" id="list-coefficient-list" data-toggle="list"
                       href="#list-coefficient" role="tab" aria-controls="coefficient">Коэффициенты</a>

                </div>
            </div>
            <div class="col-9 pt-md-3 border border-secondary" style="min-width: 1000px;">
                <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="list-parameter" role="tabpanel"
                         aria-labelledby="list-parameter-list">
                        <div class="row">
                            <div class="col-4">
                                <label>Поиск параметра по названию:
                                    <input class="form-control" onkeyup="filter(this)" type="text"/>
                                </label>
                            </div>

                            <div class="col-7 border border-secondary border-bottom-0 border-right-0"></div>
                            <div class="col-1 border border-secondary border-left-0 border-bottom-0 border-right-0"></div>
                        </div>
                        <div class="row">
                            <div class="col col-4 ">
                                <p class="h5 mt-2">Список параметров</p>
                                <div id="loadListParam">
                                    <data id="dataListParam" value="1212">
                                        <ul id="listColl" class="list-group" style="cursor: pointer">
                                            <c:forEach var="parameter" items="${Parameter}">
                                                <li class="list-group-item list-group-item-action"
                                                    onclick="findParameter(<c:out value="${parameter.parameter_id}"/>)">
                                                    <c:out value="${parameter.nameParametr}"/>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </data>
                                </div>
                            </div>
                            <div id="loadParameter" class=" col-7 border border-secondary border-top-0  border-right-0">
                                <data id="dataParameter" value="1212">
                                    <form method="post" id="formUpdateParameter"
                                          action="${pageContext.request.contextPath}/updateParameter">
                                        <div class="row mt-md-3">
                                            <div class="col-4">
                                                Управление:
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-primary" id="saveParam" type="submit"
                                                        disabled>Сохранить
                                                    изменения
                                                </button>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-secondary" type="button"
                                                        onclick="deleteParameter()"
                                                        id="deleteParam" disabled>
                                                    Удалить параметр
                                                </button>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                                        data-target="#createParam" type="button">
                                                    Создать параметр
                                                </button>
                                            </div>
                                        </div>
                                        <div class="row mt-md-3">
                                            <label for="map_id"></label><input id="map_id" name="mapTable_id" hidden>
                                            <label for="parameter_id"></label><input id="parameter_id"
                                                                                     name="parameter_id"
                                                                                     value="${params.parameter_id}"
                                                                                     hidden>
                                            <div class="col-4">
                                                <label for="nameParametr"> Название параметра:</label>
                                            </div>
                                            <div class="col">
                                                <input id="nameParametr" name="nameParameter"
                                                       value="${params.nameParametr}"
                                                       class="form-control" pattern="^[А-Яа-яA-ZЁё,\s]+$"
                                                       title="Разрешено использовать пробелы, русские буквы, заглавные буквы латинского алфавита и запятые."
                                                       required>
                                            </div>
                                        </div>
                                        <div class="row mt-md-3">
                                            <div class="col-4">
                                                <label for="stepParam"> Степень параметра:</label>
                                            </div>
                                            <div class="col">
                                                <input id="stepParam" name="step" type="number" step="any" value="${params.step}"
                                                       class="form-control" pattern="-\d+(\.\d{1,9})?"
                                                       title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                                                       required>
                                            </div>
                                        </div>

                                    </form>
                                </data>
                            </div>
                            <div class="col-1 border border-secondary border-left-0 border-right-0 border-top-0"></div>
                        </div>

                    </div>
                    <div class="tab-pane fade" id="list-coefficient" role="tabpanel"
                         aria-labelledby="list-coefficient-list">
                        <div class="row">
                            <div class="col-4 border border-secondary border-top-0 border-bottom-0 border-left-0">
                                <label>Поиск коэффициента по названию:
                                    <input class="form-control" onkeyup="filterCoeff(this)" type="text"/>
                                </label>
                            </div>
                            <div id="loadCoefficient"
                                 class="col-7 border border-secondary border-bottom-0 border-left-0 border-right-0">
                                <data id="dataLoadCoefficient" value="1212">
                                    <form id="formUpdateCoefficient" method="post"
                                          action="${pageContext.request.contextPath}/updateCoefficient">
                                        <div class="row mt-md-3">
                                            <label for="map_d"></label><input id="map_d" name="mapTable_id" hidden>
                                            <label for="coefficient_id"></label><input id="coefficient_id"
                                                                                       name="coefficient_id"
                                                                                       value="${coefficient.coefficient_id}"
                                                                                       hidden>
                                            <div class="col-2">
                                                <label for="nameCoefficient"> Название коэффициента:</label>
                                            </div>
                                            <div class="col-5">
                                                <input id="nameCoefficient" name="nameCoefficient"
                                                       value="${coefficient.name}"
                                                       class="form-control" pattern="^[А-Яа-яЁё/,\s]+$"
                                                       title="Разрешено использовать пробелы, русские буквы и запятые."
                                                       required>
                                            </div>
                                            <div class="col-1 mr-5 ml-1">
                                                <button class="btn btn-outline-primary" id="saveCoeff" type="submit"
                                                        disabled>Сохранить
                                                    изменения
                                                </button>
                                            </div>
                                            <div class="col-1 mr-5 ml-1">
                                                <button class="btn btn-outline-secondary" type="button" id="deleteCoeff"
                                                        onclick="deleteCoefficientById()" disabled>
                                                    Удалить коэффициент
                                                </button>
                                            </div>
                                            <div class="col ml-4">
                                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                                        data-target="#createCoefficient" type="button">
                                                    Создать коэффициент
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
                                <p class="h5 mt-auto">Список коэффициентов</p>
                            </div>
                            <div class="col"><p class="h5 mt-auto">Список значений коэффициентов</p></div>
                            <div class="col"></div>
                        </div>
                        <div class="row">
                            <div id="loadListCoeff"
                                 class="col col-4  border border-secondary border-top-0 border-bottom-0 border-left-0">
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
                            <div id="loadListValueCoeff"
                                 class="col pb-2 border border-secondary border-left-0 border-top-0 border-right-0">
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
                            <div id="loadValueCoeff"
                                 class="col border border-secondary border-left-0 border-top-0 border-right-0">
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
                                                <input id="value" name="value" type="number" step="any"  value="${valueCoefficient.value}"
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
                                        <div class="row mt-3">
                                            <div class="col"></div>
                                            <div class="col ml-5">
                                                <button class="btn btn-outline-secondary" data-toggle="modal"
                                                        data-target="#createValueCoeff" type="button">
                                                    Создать значение коэффициента
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
