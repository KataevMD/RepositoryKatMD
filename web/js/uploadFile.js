
function selectFile(value) {
    if (value != null) {

        let file = value.file;
        let deletePart = '.pdf';
        let splittedFakePath = value.split('\\');
        let newNameMap = 'table ';
        let nameMap = splittedFakePath[splittedFakePath.length - 1].replace(deletePart, '');
        let numberMap = nameMap.replace(/[^0-9]/gim, '');
        $('#waitAnswer').modal('show');
        $('#fileName').val(newNameMap + numberMap);
        sendFiles(file);
    }

}


function sendFiles(file) {
    let maxFileSize = 5242880;
    let Data = new FormData($('#upload-container')[0]);
    $(file).each(function (index, file) {
        if ((file.size <= maxFileSize) && ((file.type === 'file/pdf'))) {
            Data.append('file', file);
        }
    });
    $.ajax({
        url: 'http://localhost:8081/cstrmo/uploadFileMapTable',
        type: 'post',
        data: Data,
        contentType: false,
        processData: false,
        success: function (data) {
            $('#waitAnswer').modal('hide');
            if (data === "success") {
                alert('Файл был успешно загружен!');
                $('#downloadFile').attr('href', 'http://localhost:8081/cstrmo/downloadFile?mapTable_id=' + $('#map_id').val()).removeClass('disabled');
                $('#file-input').val(null);
                $('#deleteFile').prop('disabled', false);
            } else if (data === "fail") {
                alert('Файл не был загружен! За данной картой файл уже закреплен!');
                $('#file-input').val(null);
            }

        }

    });
}

function deleteFile() {
    let mapTable_id = $('#map_id').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/deleteFile',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
        },
        success: function (response) {
            if (response === "success") {
                alert('Файл удален!');
                $('#downloadFile').attr('href', '').addClass('disabled');
              //  $('#file-input').prop('disabled', false);
                $('#deleteFile').prop('disabled', true);
            } else if (response === "fail") {
                alert('Файл не обнаружен!');
            }
        }
    });
}
