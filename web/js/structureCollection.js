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
                // $('#error').toast('show');
                // $('#bodyError').text('Данные карты обновлены!');

                // $('#save').removeAttr('disabled');
                $('#openParamAndCoeff').removeClass('disabled');
                // $('#deleteMapTable').removeAttr('disabled');
                $("#loadMapTable").html($(response).find("#loadData").html());
                // $('#collection_Id').val($('#Col').val());
            }else {
                alert("Такой карты нет?");
            }

        }
    });
}