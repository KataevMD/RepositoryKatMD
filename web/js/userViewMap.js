$(function () {
    $("#jstree").jstree({
        "plugins": ["search"]
    });
    let to = false;
    $('#search').keyup(function () {
        if (to) {
            clearTimeout(to);
        }
        to = setTimeout(function () {
            let v = $('#search').val();
            $('#jstree').jstree(true).search(v);
        }, 250);
    });
});
function viewMapTable(mapTable_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/viewMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
        },
        success: function (response) {
            if (response != null) {
                $('#openParamAndCoeff').removeClass('disabled');
                $("#blockWithUpdateMapTable").html($(response).find("#loadData").html());
                $("#param").html($(response).find("#dataParam").html());
                $("#coeff").html($(response).find("#dataCoeff").html());
            } else {
                alert("Такой карты нет?");
            }

        }
    });
}