function viewUpdateMap(mapTable_id) {
    $("#map_"+mapTable_id).attr('hidden',false)
}

function closeUpdateMap(mapTable_id) {
    $("#map_"+mapTable_id).attr('hidden',true)
}

function deleteMapTableById(mapTable_id) {
    let coll_id = $('#collection_Id').val();
    $.ajax({
        method:'get',
        url: 'http://localhost:8081/cstrmo/deleteMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id,
            collection_id: coll_id
        },
        success: function (response) {

                // $('#erer').toast('show');
                // $('.toast-body').text(decode_utf8('Справочник удален!'));
                if(response === "fail"){
                    alert(decode_utf8('Ошибка, карта не удалена!'));
                }else{
                alert(decode_utf8('Карта удалена!'));
                $("#tableMap").html($(response).find("data").html());
            }
        }
    });
}

function updateMap(mapTable_id) {
    let name = $('#nameMap_'+mapTable_id).val();
    let numberMap = $('#numberMap_'+mapTable_id).val();
    let formulMap = $('#formulMap_'+mapTable_id).val();
    let coll_id = $('#collection_Id').val();
    let regName = decode_utf8('^[А-Яа-яЁё,\\s]+$');
    let regNumber = decode_utf8('^[ 0-9]+$');

   if(name.length > 3 && name.match(regName) && numberMap.match(regNumber) && formulMap.length > 3){
        $.ajax({
            method:'post',
            url: 'http://localhost:8081/cstrmo/updateMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                mapTable_id: mapTable_id,
                nameMapTable: name,
                numberTable: numberMap,
                formul: formulMap,
                collection_id: coll_id
            },
            success: function (response) {
                if(response === "fail"){
                    alert(decode_utf8('Ошибка, данные не обновлены!'));
                }else{
                    alert(decode_utf8('Данные карты обновлены!'));
                    $("#tableMap").html($(response).find("data").html());
                }
            }
        });
   }
}
//Функции проверки введенных данных при редактировании записей Карт
function checkNumberMap(mapTable_id){
    let $inp = $('#numberMap_'+mapTable_id);
    let numberMap = $inp.val();
    let regName = decode_utf8('^[ 0-9]+$');
    if(!numberMap.match(regName)){
        $('#save'+mapTable_id).prop('disabled', true);
        $inp.blur().addClass('error');
    }else {
        $('#save'+mapTable_id).prop('disabled', false);
        $inp.removeClass('error');
    }
}
function checkNameMap(mapTable_id){
    let name = $('#nameMap_'+mapTable_id).val();
    let regName = decode_utf8('^[А-Яа-яЁё,\\s]+$');
    if(!name.match(regName)){
        $('#save'+mapTable_id).prop('disabled', true);
        $('#nameMap_'+mapTable_id).blur().addClass('error');
    }else {
        $('#save'+mapTable_id).prop('disabled', false);
        $('#nameMap_'+mapTable_id).removeClass('error');
    }
}
//Функция перекодирования строки в формат UTF-8
function decode_utf8(s) {
    return decodeURIComponent(escape(s));
}