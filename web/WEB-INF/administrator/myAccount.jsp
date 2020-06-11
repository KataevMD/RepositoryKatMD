<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: katai
  Date: 10.06.2020
  Time: 0:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Единая база нормативов технологических операций</title>
    <meta charset="utf-8">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/offcanvas.css">
    <link rel="stylesheet" href="http://localhost:8081/cstrmo/css/myAccount.css">
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script src="http://localhost:8081/cstrmo/js/offcanvas.js"></script>
    <script src="http://localhost:8081/cstrmo/js/accAdmin.js"></script>
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
        <ul class="navbar-nav mr-auto" ${hiddenNav}>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/openMainAdminsPage">Справочники</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false">Учетные записи
                    администраторов</a>
                <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/openListAdminPage">Просмотр
                        учетных записей</a>
                    <a class="dropdown-item active" href="${pageContext.request.contextPath}/openRegisterAdmins">Добавить
                        учетных запись</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/openImportPage">Импорт карт</a>
            </li>
        </ul>
        <div class="justify-content-end">
            <a class="btn btn-outline-light align-middle"
               href="${pageContext.request.contextPath}/logout"><%=userName%>
                (Выйти)</a>
        </div>
    </div>
</nav>
<div aria-live="polite" aria-atomic="true" style="position: relative; min-height: 45px;">
    <div class="toast" id="updatePass" data-delay="10000" style="position: absolute; top: 0; right: 0;">
        <div class="toast-header">
            <strong class="mr-auto">Изменение данных</strong>
            <button type="button" id="closeToast1" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div id="updateSuccess" class="toast-body">

        </div>
    </div>
    <div class="toast" id="error" data-delay="10000" style="position: absolute; top: 0; right: 0;">
        <div class="toast-header">
            <strong class="mr-auto">ВНИМАНИЕ!</strong>
            <button type="button" id="closeToast4" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div id="bodyError" class="toast-body">
        </div>
    </div>
</div>

<main role="main" class="flex-shrink-0">
    <div class="container border border-secondary" style="width: 100%; max-width: 500px">
        <div class="row">
            <div class="col" >
                <form id="updateForm" autocomplete="off"
                      action="${pageContext.request.contextPath}/updateAccAdmin" method="post">
                    <p class="text-center h3">Личные данные</p>
                    <br>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputFirstName">Имя</label>
                            <input type="text" name="firstName" autocomplete="off" class="form-control"
                                   value="<c:out value="${firstName}"/>"
                                   pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{2,30})$" onkeyup="checkFname()"
                                   title="Разрешено использовать русские и латинские буквы. Имя начинается с заглавной."
                                   id="inputFirstName" required
                                   autofocus>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputLastName">Фамилия</label>
                            <input type="text" name="lastName" autocomplete="off" onkeyup="checkLname()"
                                   class="form-control" value="<c:out value="${lastName}"/>"
                                   title="Разрешено использовать русские и латинские буквы. Фамииля начинается с заглавной."
                                   pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{2,30})$" id="inputLastName" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6 ">
                            <label for="inputPatronymic">Отчество</label>
                            <input type="text" name="patronymic" autocomplete="off" onkeyup="checkPatron()"
                                   class="form-control" value="<c:out value="${patronymic}"/>"
                                   title="Разрешено использовать русские и латинские буквы. Отчество начинается с заглавной."
                                   pattern="^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{2,30})$" id="inputPatronymic">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputLogin">Логин</label>
                            <input type="text" name="login" autocomplete="off" onkeyup="checkLogin()"
                                   class="form-control" value="<c:out value="${login}"/>"
                                   title="Разрешено использовать только латинские буквы, цифры. Длина пароля не менее 6, и не более 20 символов."
                                   pattern="^[a-zA-Z][a-zA-Z0-9]{6,20}$"
                                   id="inputLogin" required>
                        </div>
                    </div>
                    <button class="btn btn-lg btn-primary" id="createNewAcc" type="submit">Сохранить
                    </button>
                    <a class="btn btn-lg btn-secondary" href="javascript:history.go(-1);" id="cancel" ${disableCancel}> Отменить</a>
                </form>
                <hr>
                <form id="updatePassword" action="${pageContext.request.contextPath}/updatePassword">
                    <p class="text-center h3">Изменение пароля</p>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputOldPassw">Текущий пароль</label>
                            <input type="password" name="odlPassword" autocomplete="off" class="form-control password" required
                                   title="Разрешено использовать латинские буквы, цифры. Обязательно должен содержать по крайней мере одну заглавную букву, одну цифру. Длина не менее 6 символов."
                                   pattern="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,}"
                                   id="inputOldPassw" value="">     <p title="Показать пароль" ><a id="showOldPassw" onclick="viewOldPassw()" href="#" class="password-control"></a></p>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6 password">
                            <label for="inputPassw">Новый пароль</label>
                            <input type="password" name="newPassword" autocomplete="off" class="form-control" required
                                   title="Разрешено использовать латинские буквы, цифры. Обязательно должен содержать по крайней мере одну заглавную букву, одну цифру. Длина не менее 6 символов."
                                   pattern="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,}"
                                   id="inputPassw" value="">      <p title="Показать пароль" ><a id="showNewPassw"  href="#" onclick="viewNewPassw()"class="password-control"></a></p>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6 password">
                            <label for="inputRepeatPassw">Новый пароль еще раз</label>
                            <input type="password" name="retNewPassword" autocomplete="off" class="form-control" required
                                   title="Разрешено использовать латинские буквы, цифры. Обязательно должен содержать по крайней мере одну заглавную букву, одну цифру. Длина не менее 6 символов."
                                   pattern="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,}"
                                   id="inputRepeatPassw" value="">
                        </div>
                    </div>
                    <button class="btn btn-lg btn-primary" id="updatePassw" type="submit">Сохранить
                    </button>
                </form>
            </div>
        </div>
    </div><br>
</main>
<!-- Modal -->
<div class="modal fade"  id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Обратите внимание!</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <label>
                    <input id="message" type="checkbox" value="${mess}" hidden>
                </label>
                <p class="text-center h6">${message}</p>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-primary">Понятно!</button>
            </div>
        </div>
    </div>
</div>
<footer class="footer bg-dark py-3 mt-auto text-muted">
    <div class="container">
        <p class="text-white">&copy; Company 2020-.... </p>
    </div>
</footer>
</body>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>

</html>
