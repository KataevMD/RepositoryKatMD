//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой записи Справочника
$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        $("#divColl").html($(response).find("data").html());
        $('.close').click();
        $('#addNewColl').toast('show');
        $('#createForm')[0].reset();
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

//Функция удаления Справочника по его ID
function deleteCollMapTableById(collection_id) {
    let res = confirm("Вы точно хотите удалить справочник?");
    if (res) {
        $.ajax({
            url: 'http://localhost:8081/cstrmo/deleteCollMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                collection_id: collection_id
            },
            success: function (response) {
                $('#deleteColl').toast('show');
                $("#divColl").html($(response).find("data").html());

            }
        });
    }

}

//Обновление данных справончика по его ID
function updateColl(collection_id) {
    let name = $('#upColl' + collection_id).val();
    let str = '^[А-Яа-яЁё\\s]+$';
    if (name.length > 0 && name.match(str)) {
        $.ajax({
            method: 'post',
            url: 'http://localhost:8081/cstrmo/updateCollMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                idColl: collection_id,
                nameCollMapTable: name
            },
            success: function (response) {
                $("#divColl").html($(response).find("data").html());
                $('#error').toast('show');
                $('#bodyError').text('Данные справочника обновлены!');
            }
        });
    } else {
        $('#error').toast('show');
        $('#bodyError').text('Проверьте введенные данные!');
    }
}

//Функция отображение блока редактирования Справочника
function viewUpdate(collection_id) {
    $("#coll_" + collection_id).attr('hidden', false)
}

//Функция скрытия блока редактирования Справочника
function closeUpdate(collection_id) {
    $("#coll_" + collection_id).attr('hidden', true)
}

//Функция проверки введенных данных при редактировании записей Справочника
function checkNameColl(collection_id) {
    let name = $('#upColl' + collection_id).val();
    let regName = '^[А-Яа-яЁё,\\s]+$';
    if (!name.match(regName)) {
        $('#save' + collection_id).prop('disabled', true);
        $('#upColl' + collection_id).blur().addClass('error');
    } else {
        $('#save' + collection_id).prop('disabled', false);
        $('#upColl' + collection_id).removeClass('error');
    }
}

//Функция проверки введенных данных при создании Справочника
function checkInputNameColl() {
    let name = $('#inputNameCollMapTable').val();
    let regName = '^[А-Яа-яЁё,\\s]+$';
    if (!name.match(regName)) {
        $('#createColl').prop('disabled', true);
        $('#inputNameCollMapTable').blur().addClass('error');
    } else {
        $('#createColl').prop('disabled', false);
        $('#inputNameCollMapTable').removeClass('error');
    }
}
