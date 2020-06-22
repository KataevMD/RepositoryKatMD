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
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Карты
$(document).on("submit", "#formUpdateMap", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Данные не обновлены!');
        }
        $("#blockWithUpdateMapTable").html($(response).find("#loadData").html());
        alert('Данные обновлены!');

    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция удаления карты по ее ID
function deleteMapTableById(mapTable_id) {
    let res = confirm("Вы точно хотите удалить данную карту?");
    if (res) {
        let coll_id = $('#collection_id').val();
        $.ajax({
            method: 'get',
            url: 'http://localhost:8081/cstrmo/deleteMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                mapTable_id: mapTable_id,
                collection_id: coll_id
            },
            success: function (response) {

                if (response === "fail") {
                    alert('Карта не удалена!')
                } else {
                    alert('Карта удалена!');
                    $("#blockWithUpdateMapTable").html($(response).find("#loadData").html());
                    $('#jstree').find($('#map_'+mapTable_id).empty().remove());
                }
            }
        });
    }
}

function findMapTable(mapTable_id) {
    let collection_id = $('#collection_id').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/findMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
            collection_id: collection_id
        },
        success: function (response) {
            if (response != null) {
                $('#blockWithUpdateMapTable').prop('hidden', false);
                $('#blockWithUpdateStructure').prop('hidden', true);
                $('#openParamAndCoeff').removeClass('disabled');

                $("#blockWithUpdateMapTable").html($(response).find("#loadData").html());

            } else {
                alert("Такой карты нет?");
            }

        }
    });
}

//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Главы
$(document).on("submit", "#formUpdateCollection", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Данные справчоника не обновлены!');

        } else {

            $('#nameSection').val(null);

            alert('Данные справчоника обновлены!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция удаления справочнкиа
function  deleteColl(){
    let res = confirm("Вы точно хотите удалить справочник?");
    if (res) {
        let collection_id = $('#collection_id').val();
        $.ajax({
            url: 'http://localhost:8081/cstrmo/deleteCollMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                collection_id: collection_id
            },
            success: function (response) {
                document.location.href = response;
            }
        });
    }
}
function findAllCollection() {
    let path = "structureCollectionPage";
    $.ajax({
        url: 'http://localhost:8081/cstrmo/findAllCollection',     // URL - сервлет
        data: {
             path: path     // передаваемые сервлету данные
        },
        success: function (response) {
           $('#mapTable_id').val( $('#id').val());
            $("#listColl").html($(response).find("#dataListColl").html());
        }
    });
}
function getListChapter(select) {
    let path = "structureCollectionPage";
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/getListChapter',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            collection_id: select.value,
            path: path
        },
        success: function (response) {
            $('#chapter').empty();
            $('#listChapter').html($(response).find('#dataListChapter').html());
            $('#chapter').prop('disabled', false);
            $('#section').prop('disabled', true).empty();
            $('#cloneableMap').prop('disabled', true);
        }
    });
}
function getListSection(select) {
    $('#blockChapter').prop('disabled', true);
    let path = "structureCollectionPage";
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/getListSections',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            chapter_id: select.value,
            path: path
        },
        success: function (response) {
            $('#listSection').html($(response).find('#dataListSection').html());
            $('#section').prop('disabled', false);

        }
    });
}
function selectSections() {
    $('#blockSection').prop('disabled', true);
    $('#cloneableMap').prop('disabled', false);
}
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой Главы
$(document).on("submit", "#formCloneableMapTable", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "success") {
            alert('Карта успешно клонирована!');
        }
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});