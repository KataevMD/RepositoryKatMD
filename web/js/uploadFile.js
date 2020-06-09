$(document).ready(function () {
//Функция перекодирования строки в формат UTF-8
    function decode_utf8(s) {
        return decodeURIComponent(escape(s));
    }

    $('#file-input').change(function () {
        if (this.value) {
            let file = this.file;
            let deletePart = '.pdf';
            // $('#fileName').val(this.value);
            let splittedFakePath = this.value.split('\\');
            let newNameMap = 'table ';
            let nameMap = splittedFakePath[splittedFakePath.length - 1].replace(deletePart, '');
            let numberMap = nameMap.replace(/[^0-9]/gim, '');

            $('#fileName').val(newNameMap + numberMap);
            sendFiles(file);
        } else {

        }


    });

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
                if (data === "success") {
                    alert('Файл был успешно загружен!');
                    $('#downloadFile').attr('href', 'http://localhost:8081/cstrmo/downloadFile?mapTable_id='+$('#mapTableId').val());
                    $('#file-input').prop('disabled', true);
                } else if (data === "fail") {
                    alert('Файл не был загружен! За данной картой файл уже закреплен!');
                }

            }

        });
    }

});
function deleteFile() {
    let mapTable_id = $('#mapTableId').val();
    $.ajax({
        method:'get',
        url: 'http://localhost:8081/cstrmo/deleteFile',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
        },
        success: function (response) {
            if (response === "success") {
                alert('Файл удален!');
                $('#downloadFile').attr('href', '');
                $('#file-input').prop('disabled', false);
            } else if (response === "fail") {
                alert('Файл не обнаружен!');
            }
        }
    });
}