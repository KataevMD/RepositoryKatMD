$('.table-filters input').on('input', function () {
    filterTable($(this).parents('table'));
});

function filterTable($table) {
    let $filters = $table.find('.table-filters td');
    let $rows = $table.find('.table-data');
    $rows.each(function (rowIndex) {
        let valid = true;
        $(this).find('td').each(function (colIndex) {
            if ($filters.eq(colIndex).find('input').val()) {
                if ($(this).html().toLowerCase().indexOf(
                    $filters.eq(colIndex).find('input').val().toLowerCase()) === -1) {
                    valid = valid && false;
                }
            }
        });
        if (valid === true) {
            $(this).css('display', '');
        } else {
            $(this).css('display', 'none');
        }
    });
}

function filter(element) {
    let value = $(element).val();

    $("#listColl > li").each(function() {
        if ($(this).text().toLowerCase().search(value) > -1) {
            $(this).show();
        }
        else {
            $(this).hide();
        }
    });
}
function filterCoeff(element) {
    let value = $(element).val();

    $("#listCoeff > li").each(function() {
        if ($(this).text().toLowerCase().search(value) > -1) {
            $(this).show();
        }
        else {
            $(this).hide();
        }
    });
}
function filterChapter(element) {
    let value = $(element).val();

    $("#listChapter > li").each(function() {
        if ($(this).text().toLowerCase().search(value) > -1) {
            $(this).show();
        }
        else {
            $(this).hide();
        }
    });
}
function filterColl(element) {
    let value = $(element).val();

    $("#collection > option").each(function() {
        if ($(this).text().toLowerCase().search(value) > -1) {
            $(this).show();
        }
        else {
            $(this).hide();
        }
    });
}