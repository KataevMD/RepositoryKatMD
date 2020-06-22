$(document).ready(function (e) {
    if($('#message').val() === 1) {
        $('#staticBackdrop').modal('show');
    }

});
$('#erer').on('hidden.bs.toast', function () {
    $('.toast-body').empty();
});

function viewNewPassw(){
    if ($('#inputPassw').attr('type') === 'password'){
        $('#showNewPassw').addClass('view').parent().prop('title','Скрыть пароль');
        $('#inputPassw').attr('type', 'text');
    } else {
        $('#showNewPassw').removeClass('view').parent().prop('title','Показать пароль');
        $('#inputPassw').attr('type', 'password');
    }return false;
}
function viewOldPassw(){
    if ($('#inputOldPassw').attr('type') === 'password'){
        $('#showOldPassw').addClass('view').parent().prop('title','Скрыть пароль');
        $('#inputOldPassw').attr('type', 'text');
    } else {
        $('#showOldPassw').removeClass('view').parent().prop('title','Показать пароль');
        $('#inputOldPassw').attr('type', 'password');
    }return false;
}

$(document).on("submit", "#updatePassword", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {

        if (response === "passNotEquals") {
            alert('Введенные пароли не совпадаю!')
        } else if(response === "success"){
            alert('Пароль успешно обновлен');
            $('#updatePassword')[0].reset();
        } else if(response === "notValid"){
            alert('Текущий пароль не верен!');
        }

    });
    event.preventDefault();
});

$(document).on("submit", "#updateForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if(response === "success"){
         alert('Ваши личные данные успешно обновлены');
        }

    });
    event.preventDefault();
});

$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            $('#error').toast('show');
            $('#bodyError').text('Учетная запись с таким логином уже существует! Используйте другой логин');
        } else {
            $('#addNewAcc').toast('show');
            $('#createForm')[0].reset();
        }

    });
    event.preventDefault();
});

//Функция проверки имени
function checkFname(){
    let $inp = $('#inputFirstName');
    let fname = $inp.val();
    let regName = '^([А-Я]{1}[а-яё]{2,30}|[A-Z]{1}[a-z]{1,30})$';
    if(!fname.match(regName)){
        $('#createNewAcc').prop('disabled', true);
        $inp.addClass('error');
    }else {
        $('#createNewAcc').prop('disabled', false);
        $inp.removeClass('error');
    }
}
//Функция проверки фамилии
function checkLname(){
    let $inp = $('#inputLastName');
    let lname = $inp.val();
    let regName = '^([А-Я]{1}[а-яё]{2,30}|[A-Z]{1}[a-z]{1,30})$';
    if(!lname.match(regName)){
        $('#createNewAcc').prop('disabled', true);
        $inp.addClass('error');
    }else {
        $('#createNewAcc').prop('disabled', false);
        $inp.removeClass('error');
    }
}
//Функция проверки отчества
function checkPatron(){
    let $inp = $('#inputPatronymic');
    let patr = $inp.val();
    let regName = '^([А-Я]{1}[а-яё]{2,30}|[A-Z]{1}[a-z]{1,30})$';
    if(!patr.match(regName)){
        $('#createNewAcc').prop('disabled', true);
        $inp.addClass('error');
    }else {
        $('#createNewAcc').prop('disabled', false);
        $inp.removeClass('error');
    }
}
//Функция проверки логина
function checkLogin(){
    let $inp = $('#inputLogin');
    let login = $inp.val();
    let regName = '^[a-zA-Z][a-zA-Z0-9]{6,20}$';
    if(!login.match(regName)){
        $('#createNewAcc').prop('disabled', true);
        $inp.addClass('error');
    }else {
        $('#createNewAcc').prop('disabled', false);
        $inp.removeClass('error');
    }
}
function breakPassword(admin_id) {
    let res = confirm("Вы точно хотите сбросить пароль?");
    if (res) {

        $.ajax({
            method: 'get',
            url: 'http://localhost:8081/cstrmo/breakPassword',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                admin_id: admin_id,
            },
            success: function (response) {
                if(response === "yoursAcc"){
                    alert('Вы не можете сбросить пароль своей учетной записи! Для изменения пароля перейдите в Личный кабинет!');
                }
                if (response === "success") {
                    alert('Пароль пользователя успешно сброшен!');
                }
            }
        });
    }
}
