$(document).ready(function () {
    let dropZone = $('#upload-container');

    $('#file-input').focus(function () {
        $('label').addClass('focus');
    })
        .focusout(function () {
            $('label').removeClass('focus');
        });


    dropZone.on('drag dragstart dragend dragover dragenter dragleave drop', function () {
        return false;
    });

    dropZone.on('dragover dragenter', function () {
        dropZone.addClass('dragover');
    });

    dropZone.on('dragleave', function (e) {
        let dx = e.pageX - dropZone.offset().left;
        let dy = e.pageY - dropZone.offset().top;
        if ((dx < 0) || (dx > dropZone.width()) || (dy < 0) || (dy > dropZone.height())) {
            dropZone.removeClass('dragover');
        }
    });

    dropZone.on('drop', function (e) {
        dropZone.removeClass('dragover');
        let files = e.originalEvent.dataTransfer.files;
        sendFiles(files);
    });

    function sendFiles(files) {

        let Data = new FormData($('#upload-container')[0]);
        $(files).each(function (index, file) {
            Data.append('file', file);
        });

        $.ajax({
            url: 'http://localhost:8081/cstrmo/importMapTable',
            type: 'post',
            data: Data,
            contentType: false,
            processData: false,
            success: function (data) {
                alert('Файлы были успешно загружены!');
            }
        });
    }

    $('#file-input').change(function () {
        let files = this.files;
        sendFiles(files);
    });

});

function getChapter(select) {
    findChapterByIdColl(select.value)
}

function findChapterByIdColl(collection_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/loadListChapter',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            collection_id: collection_id

        },
        success: function (response) {

            $('#listChapter').html($(response).find('#dataListChapter').html());


        }
    });
}

function getSection(select) {
    findSectionByIdChapter(select.value)
}

function findSectionByIdChapter(chapter_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/loadListSection',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            chapter_id: chapter_id

        },
        success: function (response) {

            $('#listSection').html($(response).find('#dataListSection').html());


        }
    });
}

function selectDischarge(select) {
    $('#discharge_id').val(select.value);
}

function selectTypeMap(select) {
    $('#typeMapTable_id').val(select.value);
}

function selectTypeTime(select) {
    $('#typeTime_id').val(select.value);
}

function selectSection(select) {
    $('#section_id').val(select.value);
}