//Функция удаления Справочника по его ID
function deleteCollMapTableById(collection_id) {
    $.ajax({
        url: 'http://localhost:8081/cstrmo/deleteCollMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            collection_id: collection_id
        },
        success: function (response) {
                // $('#erer').toast('show');
                // $('.toast-body').text(decode_utf8('Справочник удален!'));
                alert(decode_utf8('Справочник удален!'));
                $("#divColl").html($(response).find("data").html());

        }
    });
}
//Обновление данных справончика по его ID
function updateColl(collection_id) {
    let name = $('#upColl'+collection_id).val();
    let str = decode_utf8('^[А-Яа-яЁё\\s]+$');
    if(name.length > 0 && name.match(str) ){
        $.ajax({
            method:'post',
            url: 'http://localhost:8081/cstrmo/updateCollMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                idColl: collection_id,
                nameCollMapTable: name
            },
            success: function (response) {
                $("#divColl").html($(response).find("data").html());
                    // $('#erer').toast('show');
                    // $('.toast-body').text(decode_utf8('Справочник удален!'));
                    alert(decode_utf8('Данные успешно обновлены!'));

            }
        });
    }else {alert(decode_utf8('Все хуйня регекс говно'))}
}
//Функция отображение блока редактирования Справочника
function viewUpdate(collection_id) {
    $("#coll_"+collection_id).attr('hidden',false)
}
//Функция скрытия блока редактирования Справочника
function closeUpdate(collection_id) {
    $("#coll_"+collection_id).attr('hidden',true)
}
//Функция перекодирования строки в формат UTF-8
function decode_utf8(s) {
    return decodeURIComponent(escape(s));
}
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой записи Справочника
$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {

            alert(decode_utf8('Справочник успешно создан!'));
            $("#divColl").html($(response).find("data").html());
            $('.close').click();
            // $('#erer').toast('show');
            // $('.toast-body').text(decode_utf8('Учетная запись пользователя не создана. Проверьте введенные данные!'));


    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция проверки введенных данных при редактировании записей Справочника
function checkNameColl(collection_id){
    let name = $('#upColl'+collection_id).val();
    let regName = decode_utf8('^[А-Яа-яЁё,\\s]+$');
    if(!name.match(regName)){
        $('#save'+collection_id).prop('disabled', true);
        $('#upColl'+collection_id).blur().addClass('error');
    }else {
        $('#save'+collection_id).prop('disabled', false);
        $('#upColl'+collection_id).removeClass('error');
    }
}
