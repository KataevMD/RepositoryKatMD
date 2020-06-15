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
function findMapTable(mapTable_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/findMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
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
//Функция сбора данных с формы, и их последующая отправка в сервлет, для обнолвения данных Справчоника
$(document).on("submit", "#formUpdateCollection", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Название не изменено!');

        } else {
            $("#loadCollection").html($(response).find("#dataLoadCollection").html());

            alert('Название справочника изменено!');
        }


    });
    event.preventDefault(); // Important! Prevents submitting the form.
});


