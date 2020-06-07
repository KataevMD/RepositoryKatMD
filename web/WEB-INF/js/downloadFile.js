
function downloadFile() {
    let mapTable_id = $('#mapTableId').val();
    $.ajax({
        method:'get',
        url: 'http://localhost:8081/cstrmo/downloadFile',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
        },
        success: function (response) {

        }
    });
}
