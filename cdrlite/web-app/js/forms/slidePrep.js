$(document).ready(function () {

    $(":input").click(function () {
        document.getElementById("changed").value = "Y";
        //alert("Changed!")
    });
   
     $("#heTimeInOven").on('change', function() {
           
            if($("#heTimeInOven").val() == 'Other (specify)') {
                $("#heTimeInOvenOsRow").show()
            } else {
                $("#heTimeInOvenOsRow").hide()
                $("#heTimeInOvenOs").val('')
            }
        });
        
                
        /*
        $("#heTimeInOven").on('change', function() {
           
            $("#heTimeInOvenOsRow").toggle(this.value == 'Other (specify)')
            
        });
        */

        $("#heOvenTemp").on('change', function() {
            if($("#heOvenTemp").val() == 'Other (specify)') {
                $("#heOvenTempOsRow").show()
            } else {
                $("#heOvenTempOsRow").hide()
                $("#heOvenTempOs").val('')
            }
        });

        $("#heDeParrafinMethod").on('change', function() {
            if($("#heDeParrafinMethod").val() == 'Other (specify)') {
                $("#heDeParrafinMethodOsRow").show()
            } else {
                $("#heDeParrafinMethodOsRow").hide()
                $("#heDeParrafinMethodOs").val('')
            }
        });

        $("#heStainMethod").on('change', function() {
            if($("#heStainMethod").val() == 'Other (specify)') {
                $("#heStainMethodOsRow").show()
            } else {
                $("#heStainMethodOsRow").hide()
                $("#heStainMethodOs").val('')
            }
        });

        $("#heClearingMethod").on('change', function() {
            if($("#heClearingMethod").val() == 'Other (specify)') {
                $("#heClearingMethodOsRow").show()
            } else {
                $("#heClearingMethodOsRow").hide()
                $("#heClearingMethodOs").val('')
            }
        });

        $("#heCoverSlipping").on('change', function() {
            if($("#heCoverSlipping").val() == 'Other (specify)') {
                $("#heCoverSlippingOsRow").show()
            } else {
                $("#heCoverSlippingOsRow").hide()
                $("#heCoverSlippingOs").val('')
            }
        });

        $("#heEquipMaint").on('change', function() {
            if($("#heEquipMaint").val() == 'Other (specify)') {
                $("#heEquipMaintOsRow").show()
            } else {
                $("#heEquipMaintOsRow").hide()
                $("#heEquipMaintOs").val('')
            }
        });
       
});

function sub() {

    var changed = document.getElementById("changed").value;
    if (changed == "Y") {
        alert("Please save/update the change first !");
        return false;
    }
}