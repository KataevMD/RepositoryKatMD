function viewUpdateMap(mapTable_id) {
    $("#map_" + mapTable_id).attr('hidden', false)
}

function closeUpdateMap(mapTable_id) {
    $("#map_" + mapTable_id).attr('hidden', true)
}

//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Карты
$(document).on("submit", "#formCreateMapTable", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            $('#error').toast('show');
            $('#bodyError').text(decode_utf8('Карта не создана, проверьте введенные данные!'));
        }
        $("#tableMap").html($(response).find("data").html());
        $('.close').click();
        $('#error').toast('show');
        $('#bodyError').text(decode_utf8('Карта успешно создана!'));
        $('#formCreateMapTable')[0].reset();

    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

//Функция удаления карты по ее ID
function deleteMapTableById(mapTable_id) {
    let coll_id = $('#collection_Id').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/deleteMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
            collection_id: coll_id
        },
        success: function (response) {

            if (response === "fail") {
                $('#error').toast('show');
                $('#bodyError').text(decode_utf8('Карта не удалена!'));
            } else {
                $('#error').toast('show');
                $('#bodyError').text(decode_utf8('Карта удалена!'));
                $("#tableMap").html($(response).find("data").html());
            }
        }
    });
}

//Функция обновления данных карты по ее ID
function updateMap(mapTable_id) {
    let name = $('#nameMap_' + mapTable_id).val();
    let numberMap = $('#numberMap_' + mapTable_id).val();
    let formulMap = $('#formulMap_' + mapTable_id).val();
    let coll_id = $('#collection_Id').val();

        $.ajax({
            method: 'post',
            url: 'http://localhost:8081/cstrmo/updateMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                mapTable_id: mapTable_id,
                nameMapTable: name,
                numberTable: numberMap,
                formul: formulMap,
                collection_id: coll_id
            },
            success: function (response) {
                if (response === "fail") {
                    $('#error').toast('show');
                    $('#bodyError').text(decode_utf8('Проверьте введенные данные!'));
                } else {
                    $('#error').toast('show');
                    $('#bodyError').text(decode_utf8('Данные карты обновлены!'));
                    $("#tableMap").html($(response).find("data").html());
                }
            }
        });

}

//Функции проверки введенных данных при редактировании записей Карт
function checkNumberMap(mapTable_id) {
    let $inp = $('#numberMap_' + mapTable_id);
    let numberMap = $inp.val();
    let regName = decode_utf8('^[ 0-9]+$');
    if (!numberMap.match(regName)) {
        $('#save' + mapTable_id).prop('disabled', true);
        $inp.blur().addClass('error');
    } else {
        $('#save' + mapTable_id).prop('disabled', false);
        $inp.removeClass('error');
    }
}

function checkNameMap(mapTable_id) {
    let name = $('#nameMap_'+mapTable_id).val();
    let regName = decode_utf8('^[А-Яа-яЁё,\\s]+$');
    if (!name.match(regName)) {
        $('#save' + mapTable_id).prop('disabled', true);
        $('#nameMap_' + mapTable_id).blur().addClass('error');
    } else {
        $('#save' + mapTable_id).prop('disabled', false);
        $('#nameMap_' + mapTable_id).removeClass('error');
    }
}

function checkInputNameMap() {
    let name = $('#inputNameMapTable').val();
    let regName = decode_utf8('^[А-Яа-яЁё,\\s]+$');
    if (!name.match(regName)) {
        $('#createMap').prop('disabled', true);
        $('#inputNameMapTable').addClass('error');
    } else {
        $('#createMap').prop('disabled', false);
        $('#inputNameMapTable').removeClass('error');
    }
}
function checkInputNumberMap() {
    let $inp = $('#inputNumberMapTable');
    let numberMap = $inp.val();
    let regName = decode_utf8('^[0-9]+$');
    if (!numberMap.match(regName)) {
        $('#createMap').prop('disabled', true);
        $inp.addClass('error');
    } else {
        $('#createMap').prop('disabled', false);
        $inp.removeClass('error');
    }
}
//Функция перекодирования строки в формат UTF-8
function decode_utf8(s) {
    return decodeURIComponent(escape(s));
}