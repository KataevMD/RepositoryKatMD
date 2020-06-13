$(function () {
    // 6 create an instance when the DOM is ready
    $('#jstree').jstree();
    // 7 bind to events triggered on the tree

    $('#jstree').on("changed.jstree", function (e, data) {
        console.log(data.selected);
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
                $("#loadMapTable").html($(response).find("#loadData").html());
            }else {
                alert("Такой карты нет?");
            }

        }
    });
}