//Функция получения Списка разделов по id Главы
function getListSection(chapter_id) {


    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/getListSection',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            chapter_id: chapter_id
        },
        success: function (response) {

            $("#loadListSection").html($(response).find("#dataListSection").html());
            $("#loadChapter").html($(response).find("#dataLoadChapter").html());

            $('#saveChapter').prop('disabled', false);
            $('#deleteChapter').prop('disabled', false);


            let id = $('#collection_id').val();
            $('#loadChapter').find($('#col_d').val(id));
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

            // $('#coeff_id').val(coefficient_id);
            // $('#coeffId').val(coefficient_id);
            // $('#showFormNewValueCoefficient').prop('disabled', false);
        }
    });
}
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