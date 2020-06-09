//Функция получения Значений Коэффициента по id Коэффициента
function getValueCoeff(coefficient_id) {
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/getValueCoefficient',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            coefficient_id: coefficient_id
        },
        success: function (response) {
            $("#tableValCoeff").html($(response).find("#dataVal").html());
            $('#coeff_id').val(coefficient_id);
            $('#coeffId').val(coefficient_id);
            $('#showFormNewValueCoefficient').prop('disabled', false);
        }
    });
}

//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания нового Параметра
$(document).on("submit", "#formCreateParameter", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Параметр не создан!');
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта не создана, проверьте введенные данные!'));
        } else {
            $("#divTableParameter").html($(response).find("#dataParam").html());
            $('.close').click();
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта успешно создана!'));
            alert('Параметр создан!');
            $("#staticBackdropParameter").find('#formCreateParameter')[0].reset();
        }


    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания нового Коэффициента
$(document).on("submit", "#formCreateCoefficient", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Коэффициент не создан!');
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта не создана, проверьте введенные данные!'));
        } else {
            $("#divTableCoefficient").html($(response).find("#dataCoeff").html());
            $('.close').click();
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта успешно создана!'));
            alert('Коэффициент создан!');
            $("#staticBackdropCoefficient").find('#formCreateCoefficient')[0].reset();
        }


    });
    event.preventDefault(); // Important! Prevents submitting the form.
});
//Функция сбора данных с формы, и их последующая отправка в сервлет, для создания нового Значения Коэффициента
$(document).on("submit", "#formCreateValueCoefficient", function (event) {
    let $form = $(this);

    $.post($form.attr("action"), $form.serialize(), function (response) {
        if (response === "fail") {
            alert('Значение не создано!');
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта не создана, проверьте введенные данные!'));
        } else {
            $("#tableValCoeff").html($(response).find("#dataVal").html());
            $('.close').click();
            // $('#error').toast('show');
            // $('#bodyError').text(decode_utf8('Карта успешно создана!'));
            alert('Значение создано!');
            $("#staticBackdropValueCoefficient").find('#formCreateValueCoefficient')[0].reset();
        }


    });
    event.preventDefault(); // Important! Prevents submitting the form.
});

//Функция отображения блока редактирования Параметров
function viewUpdateParameter(parameter_id) {
    $("#updateParam_" + parameter_id).attr('hidden', false)
}

// Функция скрытия блока редактирования Параметра
function closeUpdateParameter(parameter_id) {
    $("#updateParam_" + parameter_id).attr('hidden', true)
}

//Функция отображения блока редактирования Коэффициента
function viewUpdateCoeff(parameter_id) {
    $("#updateCoeff_" + parameter_id).attr('hidden', false)
}

// Функция скрытия блока редактирования Коэффициента
function closeUpdateCoefficient(parameter_id) {
    $("#updateCoeff_" + parameter_id).attr('hidden', true)
}

//Функция отображения блока редактирования Значения Коэффициента
function viewUpdateValueCoeff(parameter_id) {
    $("#updateValueCoeff_" + parameter_id).attr('hidden', false)
}

// Функция скрытия блока редактирования Значения Коэффициента
function closeUpdateValueCoeff(parameter_id) {
    $("#updateValueCoeff_" + parameter_id).attr('hidden', true)
}

//Функция удаления параметра по его ID
function deleteParameterById(parameter_id) {
    let mapTable_id = $('#mapTableId').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/deleteParameter',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            parameter_id: parameter_id,
            mapTable_id: mapTable_id
        },
        success: function (response) {

            if (response === "fail") {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Карта не удалена!'));
            } else {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Карта удалена!'));
                $("#divTableParameter").html($(response).find("#dataParam").html());
            }
        }
    });
}

//Функция удаления коэффициента по его ID
function deleteCoefficientById(coefficient_id) {
    let mapTable_id = $('#mapTableId').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/deleteCoefficient',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            coefficient_id: coefficient_id,
            mapTable_id: mapTable_id
        },
        success: function (response) {

            if (response === "fail") {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Карта не удалена!'));
            } else {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Карта удалена!'));
                $("#divTableCoefficient").html($(response).find("#dataCoeff").html());
            }
        }
    });
}

//Функция удаления значения коэффициента по его ID
function deleteValueCoefficientById(coeffValue_id) {
    let coefficient_id = $('#coeffId').val();
    $.ajax({
        method: 'get',
        url: 'http://localhost:8081/cstrmo/deleteValueCoefficient',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            coeffValue_id: coeffValue_id,
            coefficient_id: coefficient_id
        },
        success: function (response) {

            if (response === "fail") {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Карта не удалена!'));
            } else {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Карта удалена!'));
                $("#tableValCoeff").html($(response).find("#dataVal").html());
            }
        }
    });
}

function updateParameter(parameter_id) {
    let nameParameter = $('#nameParam_' + parameter_id).val();
    let mapTable_id = $('#mapTableId').val();
    let step = $('#stepParam_' + parameter_id).val();
    $.ajax({
        method: 'post',
        url: 'http://localhost:8081/cstrmo/updateParameter',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            parameter_id: parameter_id,
            nameParameter: nameParameter,
            step: step,
            mapTable_id: mapTable_id
        },
        success: function (response) {
            if (response === "fail") {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Проверьте введенные данные!'));
            } else {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Данные карты обновлены!'));
                $("#divTableParameter").html($(response).find("#dataParam").html());
            }
        }
    });
}

function updateCoefficient(coefficient_id) {
    let nameCoefficient = $('#nameCoeff_' + coefficient_id).val();
    let mapTable_id = $('#mapTableId').val();
    $.ajax({
        method: 'post',
        url: 'http://localhost:8081/cstrmo/updateCoefficient',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            coefficient_id: coefficient_id,
            nameCoefficient: nameCoefficient,
            mapTable_id: mapTable_id
        },
        success: function (response) {
            if (response === "fail") {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Проверьте введенные данные!'));
            } else {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Данные карты обновлены!'));
                $("#divTableCoefficient").html($(response).find("#dataCoeff").html());
            }
        }
    });
}

function updateValueCoefficient(coeffValue_id) {
    let valName = $('#nameValueCoeff_' + coeffValue_id).val();
    let value = $('#valValueCoeff_' + coeffValue_id).val();
    let coefficient_id = $('#coeffId').val();
    $.ajax({
        method: 'post',
        url: 'http://localhost:8081/cstrmo/updateValueCoefficient',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            coeffValue_id: coeffValue_id,
            valName: valName,
            value: value,
            coefficient_id: coefficient_id
        },
        success: function (response) {
            if (response === "fail") {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Проверьте введенные данные!'));
            } else {
                // $('#error').toast('show');
                // $('#bodyError').text(decode_utf8('Данные карты обновлены!'));
                $("#tableValCoeff").html($(response).find("#dataVal").html());
            }
        }
    });
}