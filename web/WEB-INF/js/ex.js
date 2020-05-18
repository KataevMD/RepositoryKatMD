// function findDate(mapTable_id) {
//     document.getElementById('mapTable').classList.remove("hidden");
//     // $.ajax({
//     //     url: 'http://localhost:8081/cstrmo/viewParamAndCoeff',     // URL - сервлет
//     //     data: {                 // передаваемые сервлету данные
//     //         mapTable_id: mapTable_id
//     //     },
//     //     success: function (response) {
//     //         $("#mapTable").html($(response).find("data"));
//     //     }
//     // });
//
//     $.get("http://localhost:8081/cstrmo/viewParamAndCoeff?mapTable_id="+mapTable_id, function (responseJson) {          // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response JSON...
//         let $table = $("<table>").appendTo($("#mapTable"));
//         let $tab =                                                         // Create HTML <table> element and append it to HTML DOM element with ID "somediv".
//         $.each(responseJson, function (index, product) {    // Iterate over the JSON array.
//             $("<tr>").appendTo($table)                     // Create HTML <tr> element, set its text content with currently iterated item and append it to the <table>.
//                 .append($("<td>").text(product.id))        // Create HTML <td> element, set its text content with id of currently iterated product and append it to the <tr>.
//                 .append($("<td>").text(product.name));    // Create HTML <td> element, set its text content with price of currently iterated product and append it to the <tr>.
//         });
//     });
// }
$(document).on("click", ".tableM", function() {
    document.getElementById('mapTable').classList.remove("hidden"); // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
    let mapTable_id = this.id;
    $.get("http://localhost:8081/cstrmo/viewParamAndCoeff?mapTable_id="+mapTable_id, function(responseJson) {          // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response JSON...
        let $table = $("<table id='tableMapTable' class='table table-bordered container text-left'>").appendTo($("#mapTable")); // Create HTML <table> element and append it to HTML DOM element with ID "somediv".
        $("<tr>").appendTo($table).append($("<td>").text("Параметр")).append($("<td>").text("Степень параметра"));
        $.each(responseJson, function(index, product) {    // Iterate over the JSON array.
            $("<tr>").appendTo($table)                     // Create HTML <tr> element, set its text content with currently iterated item and append it to the <table>.
                .append($("<td>").text(product.nameParametr))        // Create HTML <td> element, set its text content with id of currently iterated product and append it to the <tr>.
                .append($("<td>").text(product.step));     // Create HTML <td> element, set its text content with name of currently iterated product and append it to the <tr>.

        });
    });
});
function tree_toggle(event) {
    event = event || window.event
    let clickedElem = event.target || event.srcElement

    if (!hasClass(clickedElem, 'Expand')) {
        return // клик не там
    }

    // Node, на который кликнули
    let node = clickedElem.parentNode
    if (hasClass(node, 'ExpandLeaf')) {
        return // клик на листе
    }

    // определить новый класс для узла
    let newClass = hasClass(node, 'ExpandOpen') ? 'ExpandClosed' : 'ExpandOpen'
    // заменить текущий класс на newClass
    // регексп находит отдельно стоящий open|close и меняет на newClass
    let re = /(^|\s)(ExpandOpen|ExpandClosed)(\s|$)/
    node.className = node.className.replace(re, '$1' + newClass + '$3')
}


function hasClass(elem, className) {
    return new RegExp("(^|\\s)" + className + "(\\s|$)").test(elem.className)
}

