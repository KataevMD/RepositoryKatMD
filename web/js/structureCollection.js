

$(function () {
    $("#jstree").jstree({
        "plugins" : [ "search" ]
    });
    let to = false;
    $('#search').keyup(function () {
        if(to) { clearTimeout(to); }
        to = setTimeout(function () {
            let v = $('#search').val();
            $('#jstree').jstree(true).search(v);
        }, 250);
    });
});

//Функция удаления карты по ее ID
function deleteMapTableById(mapTable_id) {
    let coll_id = $('#collection_id').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/deleteMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
            collection_id: coll_id
        },
        success: function (response) {

            if (response === "fail") {
                alert('Карта не удалена!')
            } else {
                alert('Карта удалена!')
                $("#blockWithUpdateMapTable").html($(response).find("#loadData").html());
                // $("#structureTree").html($(response).find("#dataStructureTree").html());
            }
        }
    });
}

function findMapTable(mapTable_id) {
    let collection_id =  $('#collection_id').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/findMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
            collection_id: collection_id
        },
        success: function (response) {
            if(response != null) {
                $('#blockWithUpdateMapTable').prop('hidden', false);
               $('#blockWithUpdateStructure').prop('hidden', true);
                $('#openParamAndCoeff').removeClass('disabled');

                $("#blockWithUpdateMapTable").html($(response).find("#loadData").html());

            }else {
                alert("Такой карты нет?");
            }

        }
    });
}
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Главы
$(document).on("submit", "#formUpdateCollection", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Данные справчоника не обновлены!');

        } else {

            $('#nameSection').val(null);

            alert('Данные справчоника обновлены!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
