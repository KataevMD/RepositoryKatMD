$('#erer').on('hidden.bs.toast', function () {
    $('.toast-body').empty();
});

function decode_utf8(s) {
    return decodeURIComponent(escape(s));
}

$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            $('#error').toast('show');
            $('#bodyError').text(decode_utf8('Учетная запись пользователя не создана. Проверьте введенные данные!'));
        } else {
            $('#addNewAcc').toast('show');
            $('#createForm')[0].reset();
        }

    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

function deleteUserById(idUser) {
    $.ajax({
        url: 'http://localhost:8081/cstrmo/deleteAccAdminById',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            id: idUser
        },
        success: function (response) {
            if(response === "yoursAcc"){
                $('#error').toast('show');
                $('#bodyError').text(decode_utf8('Вы не можете удалить свою учетную запись!'));
            }else{
                $('#delete').toast('show');
                //$("#adm_"+idUser).remove();

            }

        }
    });
}
//Функция проверки имени
function checkFname(){
    let $inp = $('#inputFirstName');
    let fname = $inp.val();
    let regName = decode_utf8('^([А-Я]{1}[а-яё]{2,30}|[A-Z]{1}[a-z]{1,30})$');
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
    let regName = decode_utf8('^([А-Я]{1}[а-яё]{2,30}|[A-Z]{1}[a-z]{1,30})$');
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
    let regName = decode_utf8('^([А-Я]{1}[а-яё]{2,30}|[A-Z]{1}[a-z]{1,30})$');
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
    let regName = decode_utf8('^[a-zA-Z][a-zA-Z0-9]{6,20}$');
    if(!login.match(regName)){
        $('#createNewAcc').prop('disabled', true);
        $inp.addClass('error');
    }else {
        $('#createNewAcc').prop('disabled', false);
        $inp.removeClass('error');
    }
}

