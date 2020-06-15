
function viewUpdateMap(mapTable_id) {
    $("#map_" + mapTable_id).attr('hidden', false)
}

function closeUpdateMap(mapTable_id) {
    $("#map_" + mapTable_id).attr('hidden', true)
}

//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Карты
$(document).on("submit", "#formUpdateMap", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            // $('#error').toast('show');
            // $('#bodyError').text('Карта не создана, проверьте введенные данные!');
            alert('Данные не обновлены!');
        }
        $("#loadMapTable").html($(response).find("#loadData").html());
        // $('.close').click();
        // $('#error').toast('show');
        // $('#bodyError').text('Карта успешно создана!');
        alert('Данные обновлены!');

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
                $('#bodyError').text('Карта не удалена!');
            } else {
                $('#error').toast('show');
                $('#bodyError').text('Карта удалена!');
                $("#tableMap").html($(response).find("data").html());
            }
        }
    });
}

// $('#save').click(function () {
//     let mapTable_id = $('#map_id').val();
//
//     let name = $('#nameMap_' + mapTable_id).val();
//     let numberMap = $('#numberMap_' + mapTable_id).val();
//     let formulMap = $('#formulMap_' + mapTable_id).val();
//     let coll_id = $('#collection_Id').val();
//
//     $.ajax({
//         method: 'post',
//         url: 'http://localhost:8081/cstrmo/updateMapTable',     // URL - сервлет
//         data: {                 // передаваемые сервлету данные
//             mapTable_id: mapTable_id,
//             nameMapTable: name,
//             numberTable: numberMap,
//             formul: formulMap,
//             collection_id: coll_id
//         },
//         success: function (response) {
//             if (response === "fail") {
//                 $('#error').toast('show');
//                 $('#bodyError').text('Проверьте введенные данные!');
//             } else {
//                 $('#error').toast('show');
//                 $('#bodyError').text('Данные карты обновлены!');
//                 $("#tableMap").html($(response).find("data").html());
//             }
//         }
//     });
// });


$('#number').change(function () {
    let $inp = $('#numberMap');
    let numberMap = $inp.val();
    let regName = '^[0-9]+$';
    if (!numberMap.match(regName)) {
        $('#save').prop('disabled', true);
        $inp.blur().addClass('error');
    } else {
        $('#save').prop('disabled', false);
        $inp.removeClass('error');
    }
});


function checkNameMap(mapTable_id) {
    let name = $('#nameMap_'+mapTable_id).val();
    let regName = '^[А-Яа-яЁё,\\s]+$';
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
    let regName = '^[А-Яа-яЁё,\\s]+$';
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
    let regName = '^[0-9]+$';
    if (!numberMap.match(regName)) {
        $('#createMap').prop('disabled', true);
        $inp.addClass('error');
    } else {
        $('#createMap').prop('disabled', false);
        $inp.removeClass('error');
    }
}

function cloneMapTable(collection_id) {
    let mapTable_id = $('#mapTable_id').val();
    $.ajax({
        method:'post',
        url: 'http://localhost:8081/cstrmo/cloneableMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            collection_id: collection_id,
            mapTable_id: mapTable_id
        },
        success: function (response) {
            $("#tableMap").html($(response).find("data").html());
            $('.close').click();
        }
    });
}
function getMapId(mapTable_id) {
    $('#mapTable_id').val(mapTable_id);
}