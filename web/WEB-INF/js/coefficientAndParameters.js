//Функция получения Значений Коэффициента по id Коэффициента
function getValueCoeff(coefficient_id) {
    $.ajax({
        method:'get',
        url: 'http://localhost:8081/cstrmo/getValueCoefficient',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            coefficient_id: coefficient_id
        },
        success: function (response) {
            $("#tableValCoeff").html($(response).find("data").html());
        }
    });
}
//Функция отображения блока редактирования Параметров
function viewUpdateParameter(parameter_id) {
    $("#updateParam_"+parameter_id).attr('hidden',false)
}
// Функция скрытия блока редактирования Параметра
function closeUpdateParameter(parameter_id) {
    $("#updateParam_"+parameter_id).attr('hidden',true)
}

//Функция отображения блока редактирования Коэффициента
function viewUpdateCoeff(parameter_id) {
    $("#updateCoeff_"+parameter_id).attr('hidden',false)
}
// Функция скрытия блока редактирования Коэффициента
function closeUpdateCoefficient(parameter_id) {
    $("#updateCoeff_"+parameter_id).attr('hidden',true)
}

//Функция отображения блока редактирования Значения Коэффициента
function viewUpdateValueCoeff(parameter_id) {
    $("#updateValueCoeff_"+parameter_id).attr('hidden',false)
}
// Функция скрытия блока редактирования Значения Коэффициента
function closeUpdateValueCoeff(parameter_id) {
    $("#updateValueCoeff_"+parameter_id).attr('hidden',true)
}