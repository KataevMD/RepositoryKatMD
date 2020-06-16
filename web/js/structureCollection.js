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
    $("#structure").text("Структура справочника");
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
