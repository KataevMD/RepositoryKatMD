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
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css" >
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
    <div class="container text-center">
        <p class="h4 mt-auto">Карта "${nameMapTable}"</p>
    </div>
    <label for="mapTableId"></label><input id="mapTableId" name="mapTable_id" value="${mapTable_Id}"
                                           hidden>
    <br>
    <div class="d-flex justify-content-start">
        <form id="upload-container" accept-charset='utf-8' enctype="multipart/form-data" method="post"
              action="${pageContext.request.contextPath}/uploadFileMapTable">
            <div><label for="map_id"></label>
                <input id="map_id" name="mapTable_id" value="${mapTable_Id}" hidden>
                <label for="fileName"></label>
                <input id="fileName" name="fileName" value="" hidden>
                <label for="file-input"></label>
                <input id="file-input" type="file" name="file" ${selectFile}>
            </div>
        </form>
        <a id="downloadFile" style="margin-right: 10px" href="${downloadFileMap}"
           class="btn btn-light">Скачать файл</a>
        <button class="btn btn-light" onclick="deleteFile()">Удалить файл</button>
    </div>
   <br>
    <div class="row ">
        <%--        Блок таблицы Параметров--%>
        <div class="col">
            <div class="container">
                <%--Кнопка открытия модального окна создания нового параметра--%>
                <button id="createNewParameter" data-toggle="modal"
                        data-target="#staticBackdropParameter" class="btn btn-outline-secondary">Добавить новый параметр
                </button>
            </div>
            <br>
            <div id="divTableParameter" class="container-fluid w-100">
                <data id="dataParam" value="1211">
                    <table id="tableParameter" class="table table-hover table-responsive text-left">
                        <thead class="thead-light">
                        <tr>
                            <th>№</th>
                            <th>Название параметра</th>
                            <th class="w-25">Значение степени</th>
                            <th class="text-center" colspan="2">Управление</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="parameter" items="${Parameter}">
                            <tr id="param_<c:out value="${parameter.parameter_id}"/>">
                                <td><c:out value="${parameter.parameter_id}"/></td>
                                <td><c:out value="${parameter.nameParametr}"/></td>
                                <td><c:out value="${parameter.step}"/></td>
                                <td>
                                    <button class="btn btn-light "
                                            onclick="viewUpdateParameter(<c:out value="${parameter.parameter_id}"/>)">
                                        Редактировать
                                    </button>
                                </td>
                                <td>
                                    <button type="button"
                                            onclick="deleteParameterById(<c:out value="${parameter.parameter_id}"/>)"
                                            class="btn btn-light">Удалить
                                    </button>
                                </td>
                            </tr>
                            <tr id="updateParam_<c:out value="${parameter.parameter_id}"/>" hidden class="table-active">
                                <td></td>
                                <td>
                                    <label class="w-100">
                                        <input id="nameParam_<c:out value="${parameter.parameter_id}"/>"
                                               value="<c:out value="${parameter.nameParametr}"/>"
                                               pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <label class="w-100">
                                        <input id="stepParam_<c:out value="${parameter.parameter_id}"/>"
                                               value="<c:out value="${parameter.step}"/>"
                                               type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <button class="btn btn-primary"
                                            onclick="updateParameter(<c:out value="${parameter.parameter_id}"/>)">
                                        Сохранить
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-secondary"
                                            onclick="closeUpdateParameter(<c:out value="${parameter.parameter_id}"/>)">
                                        Отмена
                                    </button>
                                </td>
                                <td></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </data>
            </div>
            <br>
            <div id="divTableFormula" class="container-fluid w-100">
                <data id="dataFormula" value="1211">
                    <table id="tableFormula" class="table table-hover table-responsive text-left">
                        <thead class="thead-light">
                        <tr>
                            <th>№ коэффициента</th>
                            <th>Формула</th>
                            <th class="text-center" colspan="2">Управление</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="formula" items="${Formula}">
                            <tr id="formula_<c:out value="${formula.formula_id}"/>">
                                <td><c:out value="${formula.coefficient_id}"/></td>
                                <td><c:out value="${formula.formula}"/></td>
                                <td>
                                    <button class="btn btn-light "
                                            onclick="viewUpdateFormula(<c:out value="${formula.formula_id}"/>)">
                                        Редактировать
                                    </button>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr id="updateFormula_<c:out value="${formula.formula_id}"/>" hidden class="table-active">
                                <td></td>
                                <td>
                                    <label class="w-100">
                                        <input id="nFormula_<c:out value="${formula.formula_id}"/>"
                                               value="<c:out value="${formula.formula}"/>"
                                               type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <button class="btn btn-primary"
                                            onclick="updateFormula(<c:out value="${formula.formula_id}"/>)">
                                        Сохранить
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-secondary"
                                            onclick="closeUpdateFormula(<c:out value="${formula.formula_id}"/>)">
                                        Отмена
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
        <%--        Блок таблицы Коэффициенты--%>
        <div class="col">
            <div class="container">
                <%--Кнопка открытия модального окна создания нового коэффициента--%>
                <button id="createNewCoefficient" data-toggle="modal"
                        data-target="#staticBackdropCoefficient" class="btn btn-outline-secondary">Добавить новый
                    коэффициент
                </button>
            </div>
            <br>
            <div id="divTableCoefficient" class="container-fluid w-100">
                <data id="dataCoeff" value="12133">
                    <table id="tableCoefficient" class="table table-hover table-responsive text-left">
                        <thead class="thead-light">
                        <tr>
                            <th>№</th>
                            <th class="w-50">Название коэффициента</th>
                            <th class="text-center w-25" colspan="2">Управление</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="coefficient" items="${Coefficient}">
                            <tr id="coeff_<c:out value="${coefficient.coefficient_id}"/>">
                                <td><c:out value="${coefficient.coefficient_id}"/></td>
                                <td class="w-50"><c:out value="${coefficient.name}"/></td>
                                <td>
                                    <button class="btn btn-light " id="viewValueCoeff"
                                            onclick="getValueCoeff(<c:out value="${coefficient.coefficient_id}"/>)">
                                        Просмотреть значения
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-light " id="viewUpdate"
                                            onclick="viewUpdateCoeff(<c:out value="${coefficient.coefficient_id}"/>)">
                                        Редактировать
                                    </button>
                                </td>
                                <td>
                                    <button type="button" id="delete"
                                            onclick="deleteCoefficientById(<c:out
                                                    value="${coefficient.coefficient_id}"/>)"
                                            class="btn btn-light">Удалить
                                    </button>
                                </td>
                            </tr>
                            <tr id="updateCoeff_<c:out value="${coefficient.coefficient_id}"/>" hidden
                                class="table-active">
                                <td></td>
                                <td>
                                    <label class="w-100">
                                        <input id="nameCoeff_<c:out value="${coefficient.coefficient_id}"/>"
                                               value="<c:out value="${coefficient.name}"/>"
                                               pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <button class="btn btn-primary"
                                            onclick="updateCoefficient(<c:out value="${coefficient.coefficient_id}"/>)">
                                        Сохранить
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-secondary"
                                            onclick="closeUpdateCoefficient(<c:out
                                                    value="${coefficient.coefficient_id}"/>)">Отмена
                                    </button>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </data>
            </div>
            <br>
            <%--Кнопка открытия модального окна создания нового зачения коэффициента--%>
            <div class="container">
                <button id="showFormNewValueCoefficient" data-toggle="modal"
                        data-target="#staticBackdropValueCoefficient" class="btn btn-outline-secondary" disabled>
                    Добавить значение
                </button>
            </div>
            <br>
            <label>
                <input id="coeffId" name="coefficient_id" value="" hidden>
            </label>
            <div id="tableValCoeff" class="container-fluid w-100">
                <data id="dataVal" value="125">
                    <table id="tableCoefficientValue" class="table table-hover table-responsive text-left">
                        <thead class="thead-light">
                        <tr>
                            <th>Название значения коэффициента</th>
                            <th>Значение</th>
                            <th class="text-center" colspan="2">Управление</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="valueCoefficient" items="${ValueCoefficient}">
                            <tr id="valCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>">
                                <td><c:out value="${valueCoefficient.valName}"/></td>
                                <td><c:out value="${valueCoefficient.value}"/></td>
                                <td>
                                    <button class="btn btn-light " id="viewUpdateValueCoeff"
                                            onclick="viewUpdateValueCoeff(<c:out
                                                    value="${valueCoefficient.coeffValue_id}"/>)"
                                    >Редактировать
                                    </button>
                                </td>
                                <td>
                                    <button type="button" id="deleteValueCoeff"
                                            onclick="deleteValueCoefficientById(<c:out
                                                    value="${valueCoefficient.coeffValue_id}"/>)"
                                            class="btn btn-light">Удалить
                                    </button>
                                </td>
                            </tr>
                            <tr id="updateValueCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>" hidden
                                class="table-active">
                                <td>
                                    <label class="w-100">
                                        <input id="nameValueCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>"
                                               value="<c:out value="${valueCoefficient.valName}"/>"
                                               pattern="^[А-Яа-яЁё\s]+$" type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <label class="w-100">
                                        <input id="valValueCoeff_<c:out value="${valueCoefficient.coeffValue_id}"/>"
                                               value="<c:out value="${valueCoefficient.value}"/>"
                                               type="text" class="form-control " required>
                                    </label>
                                </td>
                                <td>
                                    <button class="btn btn-primary"
                                            onclick="updateValueCoefficient(<c:out
                                                    value="${valueCoefficient.coeffValue_id}"/>)">Сохранить
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-secondary"
                                            onclick="closeUpdateValueCoeff(<c:out
                                                    value="${valueCoefficient.coeffValue_id}"/>)">Отмена
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
    </div>
</main>
<%--Модальное окно создания нового параметра--%>
<div class="modal fade" id="staticBackdropParameter" data-backdrop="static" data-keyboard="false"
     tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Создание параметра</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formCreateParameter" autocomplete="off" method="post"
                      action="${pageContext.request.contextPath}/addNewParameter">
                    <label for="mapTable_id"></label><input id="mapTable_id" name="mapTable_id" value="${mapTable_Id}"
                                                            hidden>
                    <label for="inputNameParameter" >Введиет название параметра</label>
                    <input id="inputNameParameter" onkeyup="checkInputNameParameter()" autocomplete="off"
                           class="form-control" pattern="^[А-Яа-яЁёA-Z,\s]+$"
                           name="nameParameter"
                           title="Разрешено использовать заглавные буквы латинского алфавита, все буквы русского и пробел."
                           placeholder="Название параметра"
                           required autofocus><br>
                    <label for="inputStepParameter">Введите степень</label>
                    <input id="inputStepParameter" onkeyup="checkInputStepParameter()" autocomplete="off"
                           class="form-control"
                           pattern="\d+(\.\d{1,9})?"
                           name="stepParameter"
                           title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                           placeholder="Степень параметра"
                           required><br>
                    <button id="createParameter" class="btn btn-lg btn-primary btn-block" type="submit">Создать</button>
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
<%--Модальное окно создания нового коэффициента--%>
<div class="modal fade" id="staticBackdropCoefficient" data-backdrop="static" data-keyboard="false"
     tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabelCoefficient">Создание коэффициента</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formCreateCoefficient" autocomplete="off" method="post"
                      action="${pageContext.request.contextPath}/addNewCoefficient">
                    <label for="mapId"></label><input id="mapId" name="mapTable_id" value="${mapTable_Id}" hidden>
                    <label for="inputNameCoefficient">Введите название коэффициента</label>
                    <input id="inputNameCoefficient" onkeyup="checkInputNameCoefficient()" autocomplete="off"
                           class="form-control" pattern="^[А-Яа-яЁёA-Z/\s]+$"
                           name="nameCoefficient"
                           title="Разрешено использовать все буквы русского алфавита, пробел и / (слэш)."
                           placeholder="Название коэффициента"
                           required autofocus><br>
                    <button id="createCoefficient" class="btn btn-lg btn-primary btn-block" type="submit">Создать
                    </button>
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
<%--Модальное окно создания нового значения коэффициента--%>
<div class="modal fade" id="staticBackdropValueCoefficient" data-backdrop="static" data-keyboard="false"
     tabindex="-1"
     role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabelValueCoefficient">Создание коэффициента</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formCreateValueCoefficient" autocomplete="off" method="post"
                      action="${pageContext.request.contextPath}/addNewValueCoefficient">
                    <label>
                        <input id="coeff_id" name="coefficient_id" value="" hidden>
                    </label>
                    <label for="inputNameCoefficient">Введите название коэффициента</label>
                    <input id="inputNameValueCoefficient" onkeyup="checkInputNameValueCoefficient()" autocomplete="off"
                           class="form-control" pattern="^[/А-Яа-яЁёA-Z\s]+$"
                           name="valName"
                           title="Разрешено использовать все буквы русского алфавита, пробел и / (слэш)."
                           placeholder="Название значения"
                           required autofocus><br>
                    <label for="inputValue">Введите значение</label>
                    <input id="inputValue" onkeyup="checkInputValue()" autocomplete="off"
                           class="form-control"
                           pattern="\d+(\.\d{1,9})?"
                           name="value"
                           title="Разрешено записывать числа только в виде десятичной дроби, через точку."
                           placeholder="Значение"
                           required autofocus><br>
                    <button id="createValueCoefficient" class="btn btn-lg btn-primary btn-block" type="submit">Создать
                    </button>
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
<script src="http://localhost:8081/cstrmo/js/offcanvas.js"></script>
<script src="http://localhost:8081/cstrmo/js/filters.js"></script>
</html>
