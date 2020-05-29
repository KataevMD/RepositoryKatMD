$('#erer').on('hidden.bs.toast', function () {
    $('.toast-body').empty();
});

function decode_utf8(s) {
    return decodeURIComponent(escape(s));
}

$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "success") {
            $('#erer').toast('show');
            $('.toast-body').text(decode_utf8('Учетная запись пользователя создана!'));
            $('#createForm')[0].reset();
        } else {
            $('#erer').toast('show');
            $('.toast-body').text(decode_utf8('Учетная запись пользователя не создана. Проверьте введенные данные!'));
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
            if(response === "success"){
                $('#erer').toast('show');
                $('.toast-body').text(decode_utf8('Учетная запись пользователя удалена!'));
                $("#adm_"+idUser).remove();
            }else if(response === "yoursAcc"){
                $('#erer').toast('show');
                $('.toast-body').text(decode_utf8('Вы не можете удалить свою учетную запись!'));
            }

        }
    });
}



