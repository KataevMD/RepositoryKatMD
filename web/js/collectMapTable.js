//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания новой записи Справочника
$(document).on("submit", "#createForm", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        $("#divColl").html($(response).find("data").html());
        $('.close').click();
        $('#addNewColl').toast('show');
        $('#createForm')[0].reset();
    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

//Функция удаления Справочника по его ID
function deleteCollMapTableById(collection_id) {
    let res = confirm("Вы точно хотите удалить справочник?");
    if (res) {
        $.ajax({
            url: 'http://localhost:8081/cstrmo/deleteCollMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                collection_id: collection_id
            },
            success: function (response) {
                $('#deleteColl').toast('show');
                $("#divColl").html($(response).find("data").html());

            }
        });
    }

}


