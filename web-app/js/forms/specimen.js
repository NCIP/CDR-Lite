/* Please do not check in commented out code like alert(flags), partial code etc. */
/* stolen / copied from query.js by Tabor */

function adjustTissueLocation() {
    $.ajax({
        type: 'GET',
        dataType: 'text', 
        url: '/cdrlite/specimenRecord/getTissueLocation?id=' + $("#tissueType").val()
    }).done(function(data) {
        alert('data: ' + data)
        alert($(this).data('options'))
        $('#tissueLocation').html(data);
    });
}

$(document).ready(function() {
//    alert('Hello!');
    $(":input").change(function () {
        document.getElementById("changed").value = "Y";
//        alert("Changed!");
    });
    
//    $("#tissueType").change(function() {
//        alert('Tissue Type: ' + $("#tissueType").val());
//        if ($("#tissueType").val().length) {
//            adjustTissueLocation();
//        } 
//    });
});

function sub() {
    var changed = document.getElementById("changed").value;
    if (changed === "Y") {
        alert("Please save/update the change first !");
        return false;
    }
}