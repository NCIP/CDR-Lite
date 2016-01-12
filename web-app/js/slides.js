	
$(document).ready(function() {
    var dataHTMLStr = "";
    var title = "Aperio Slide For Specimen " + specimenid
   // alert(title)
    dataHTMLStr += '<div class="row clearfix"><div class="label">Case Id:</div><div class="value">' + caseid + '</div></div>';
   dataHTMLStr += '<div class="row clearfix"><div class="label">Tissue Type:</div><div class="value">' + tissueType + '</div></div>';
    dataHTMLStr += '<div class="row clearfix"><div class="label">PRC Comment:</div><div class="value">' + prcComment + '</div></div>';
   // dataHTMLStr += '<div class="row clearfix"><div class="label">Tissue Location:</div><div class="value">' + controllerData.tissueloc.name + '</div></div>';
    //dataHTMLStr += '<div class="row clearfix"><div class="label">Slide ID:</div><div class="value">' + controllerData.slideid + '</div></div>';
    //dataHTMLStr += '<div class="row clearfix"><div class="label">Image ID:</div><div class="value">' + controllerData.imageid + '</div></div>';
    //alert("wrong?????")
    //dataHTMLStr='<p>???</p>'
    $("h1").html(title);
    $("#slidedata").html(dataHTMLStr);
   var viewer = OpenSeadragon({
        id: "openseadragon",
        prefixUrl: "../js/openseadragon-bin-1.1.1/images/",
        //tileSources: APERIOIMGLOC + "/" + controllerData.caseid + "/" + controllerData.slideid + ".dzi"
        tileSources:  "/images/" + casePrivateId + "/" +dzi
    });
});
