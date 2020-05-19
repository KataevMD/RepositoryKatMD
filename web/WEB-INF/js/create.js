// $("#createForm").submit(function (e) { // Устанавливаем событие отправки для формы с id=form
//     e.preventDefault();
//     let form_data = $(this).serialize(); // Собираем все данные из формы
//     $.ajax({
//         type: "POST", // Метод отправки
//         url: "http://localhost:8081/cstrmo/createAccAdmin", // Путь до сервлета с функцией создания записи в БД
//         data: form_data,
//         success: function () {
//             alert("Наверное получилось!");
//         }
//     });
// });
$(document).on("submit", "#createForm", function(event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function(response) {
        if (response === "success"){
            alert("Новая учетная запись успешно добавлена в систему!");
            $('#createForm')[0].reset();
        }else {
            alert("Проверьте введенные данные!");
        }

    });
    event.preventDefault(); // Important! Prevents submitting the form.
});