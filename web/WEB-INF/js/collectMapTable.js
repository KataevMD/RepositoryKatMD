function deleteCollMapTableById(collection_id) {
    $.ajax({
        url: 'http://localhost:8081/cstrmo/deleteCollMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            collection_id: collection_id
        },
        success: function (response) {
            if(response === "success"){
                // $('#erer').toast('show');
                // $('.toast-body').text(decode_utf8('Справочник удален!'));
                alert(decode_utf8('Справочник удален!'));
                $("#tr_"+collection_id).remove();
            }
        }
    });
}

function updateColl(collection_id) {
    let name = $('#upColl_'+collection_id).val();
    if(name.length > 0 && name.match("^[А-Яа-яЁё\s]+$")){
        $.ajax({
            method:'post',
            url: 'http://localhost:8081/cstrmo/updateCollMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                idColl: collection_id,
                nameCollMapTable: name
            },
            success: function (response) {
                if(response === "success"){
                    // $('#erer').toast('show');
                    // $('.toast-body').text(decode_utf8('Справочник удален!'));
                    alert(decode_utf8('Данные успешно обновлены!'));
                    location.reload();
                }
            }
        });
    }
}

function viewUpdate(collection_id) {
    $("#coll_"+collection_id).attr('hidden',false)
}

function closeUpdate(collection_id) {
    $("#coll_"+collection_id).attr('hidden',true)
}

function decode_utf8(s) {
    return decodeURIComponent(escape(s));
}

$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "success") {
            // $('#erer').toast('show');
            // $('.toast-body').text(decode_utf8('Учетная запись пользователя создана!'));
            alert(decode_utf8('Справочник успешно создан!'));
            location.reload();
            $('.close').click();
        } else {
            // $('#erer').toast('show');
            // $('.toast-body').text(decode_utf8('Учетная запись пользователя не создана. Проверьте введенные данные!'));
        }

    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
