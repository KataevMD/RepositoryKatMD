function viewUpdateMap(mapTable_id) {
    $("#map_"+mapTable_id).attr('hidden',false)
}

function closeUpdateMap(mapTable_id) {
    $("#map_"+mapTable_id).attr('hidden',true)
}
function deleteMapTableById(mapTable_id) {
    $.ajax({
        url: 'http://localhost:8081/cstrmo/deleteMapTable',     // URL - сервлет
        data: {                 // передаваемые сервлету данные
            mapTable_id: mapTable_id
        },
        success: function (response) {
            if(response === "success"){
                // $('#erer').toast('show');
                // $('.toast-body').text(decode_utf8('Справочник удален!'));
                alert(decode_utf8('Справочник удален!'));
                $("#tr_"+mapTable_id).remove();
            }
        }
    });
}

function updateMap(mapTable_id) {
    let name = $('#nameMap_'+mapTable_id).val();
    if(name.length > 0 && name.match("^[А-Яа-яЁё\s]+$")){
        $.ajax({
            method:'post',
            url: 'http://localhost:8081/cstrmo/updateMapTable',     // URL - сервлет
            data: {                 // передаваемые сервлету данные
                mapTable_id: mapTable_id,
                nameMapTable: name
            },
            success: function (response) {
                if(response === "success"){
                    // $('#erer').toast('show');
                    // $('.toast-body').text(decode_utf8('Справочник удален!'));
                    alert(decode_utf8('Данные успешно обновлены!'));
                    location.reload();
                }
            }
        });
    }
}