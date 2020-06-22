function getSection(select) {
    findSectionByIdChapter(select.value)
}

function findSectionByIdChapter(chapter_id) {
    let path = "rewriteStructureCollectionPage";
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/getListSections',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            chapter_id: chapter_id,
            path: path

        },
        success: function (response) {
            $('#lSection').html($(response).find('#dataLSection').html());
        }
    });
}

//Функция получения Параметра по id
function findChapter(chapter_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/findChapter',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            chapter_id: chapter_id
        },
        success: function (response) {

            $("#loadChapter").html($(response).find("#dataChapter").html());
            $("#loadListSection").html($(response).find("#dataListSection").html());
            let id = $('#collection_Id').val();
            $('#loadChapter').find($('#col_id').val(id));

            $('#deleteChapter').prop('disabled', false);
            $('#saveChapter').prop('disabled', false);

        }
    });
}

//Функция получения Значения коэффициента по id
function findSection(section_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/findSection',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            section_id: section_id
        },
        success: function (response) {

            $("#loadSection").html($(response).find("#dataSection").html());

            let id_S = $('#chapter_id').val();
            $('#loadSection').find($('#chapters_id').val(id_S));
            $('#section_id').val(section_id);


            $('#saveSection').prop('disabled', false);
            $('#deleteSection').prop('disabled', false);

        }
    });
}

//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Главы
$(document).on("submit", "#formCreateNewMapTable", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Новая карта не создана!');

        } else {
            $('#numMap').val(null);
            $('#namMap').val(null);

            alert('Новая карта создана!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

//Функция сбора данных с формы, и их последующая отправка в сервлет, для обновления данных Главы
$(document).on("submit", "#formUpdateChapter", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Данный не обновлены!');
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта не создана, проверьте введенные данные!'));
        } else {

            $("#loadListChapter").html($(response).find("#dataListChapter").html());
            $("#loadChapter").html($(response).find("#dataLoadChapter").html());


            alert('Данные обновлены!');

        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция сбора данных с формы, и их последующая отправка в сервлет, для обнолвения данных Значений Коэффициента
$(document).on("submit", "#formUpdateSection", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Данный не обновлены!');

        } else {

            $("#loadListSection").html($(response).find("#dataListSection").html());
            $("#loadSection").html($(response).find("#dataSection").html());
            alert('Данные обновлены!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Главы
$(document).on("submit", "#formCreateChapter", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Новая глава не создана!');

        } else {
            $("#loadListChapter").html($(response).find("#dataListChapter").html());
            $("#loadChapters").html($(response).find("#dataChapters").html());
            $('#nameChapter').val(null);

            alert('Новая глава создана!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Главы
$(document).on("submit", "#formCreateSection", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Новый раздел не создан!');

        } else {

            $('#nameSection').val(null);

            alert('Новый раздел создан!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

function deleteChapterById() {
    let res = confirm("Вы точно хотите удалить данную главу?");
    if (res) {
        let chapter_id = $("#chapter_id").val();
        let collection_id = $('#collection_Id').val();
        $('#saveChapter').prop('disabled', true);
        $('#deleteChapter').prop('disabled', true);
        $.ajax({
            method: 'get',
            url: 'http://localhost:8081/cstrmo/deleteChapter',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                chapter_id: chapter_id,
                collection_id: collection_id
            },
            success: function (response) {

                if (response === "fail") {
                    alert('Глава не удалена!');
                    $('#saveChapter').prop('disabled', false);
                    $('#deleteChapter').prop('disabled', false);
                } else {

                    $("#loadListChapter").html($(response).find("#dataListChapter").html());
                    $('#nameChapter').val(null);
                    alert('Глава удалена');
                }
            }
        });
    }
}

// Функция удаления значения коэффициента по его ID
function deleteSectionById() {
    let res = confirm("Вы точно хотите удалить данный раздел?");
    if (res) {
        let chapter_id = $('#chapters_id').val();
        let section_id = $('#section_id').val();
        $('#saveSection').prop('disabled', true);
        $('#deleteSection').prop('disabled', true);
        $.ajax({
            method: 'get',
            url: 'http://localhost:8081/cstrmo/deleteSection',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                chapter_id: chapter_id,
                section_id: section_id
            },
            success: function (response) {

                if (response === "fail") {
                    $('#saveSection').prop('disabled', false);
                    $('#deleteSection').prop('disabled', false);
                    alert('Раздел не удален!');
                } else {
                    $('#nameSection').val(null);
                    alert('Раздел удален!');
                    $("#loadListSection").html($(response).find("#dataListSection").html());
                }
            }
        });
    }
}