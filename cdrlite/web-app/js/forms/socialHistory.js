$(document).ready(function () {
    //$("#smkStartRow").hide();
    // $("#smkYrsRow").hide();
    // $("#smkPkWkRow").hide();
    // $("#smkLastYrsRow").hide();
    $(":input").change(function () {
        document.getElementById("changed").value = "Y";
        //alert("Changed!")
    });

    if ($("#sm4").attr('checked')) {
        $("#sm4").trigger("click")
    }

    if ($("#sm3").attr('checked')) {
        $("#sm3").trigger("click")
    }

    $("#sm5").click(function () {
        $("#smkStartRow").hide();
        $("#smkYrsRow").hide();
        $("#smkPkWkRow").hide();
        $("#smkLastYrsRow").hide();

        $("#smokeAgeStart").val('');
        $("#smokeYears").val('');
        $("#smokePackWeek").val('');
        $("#yrSinceLastSmoke").val('');

    });
    $("#sm4").click(function () {
        $("#smkStartRow").show();
        $("#smokeAgeStart").focus();
        $("#smkYrsRow").show();
        $("#smkPkWkRow").show();
        $("#smkLastYrsRow").show();

    });

    $("#sm3").click(function () {
        $("#smkStartRow").show();
        $("#smokeAgeStart").focus();
        $("#smkYrsRow").show();
        $("#smkPkWkRow").show();
        $("#smkLastYrsRow").show();
    });

    $("#sm2").click(function () {
        $("#smkStartRow").show();
        $("#smokeAgeStart").focus();
        $("#smkYrsRow").show();
        $("#smkPkWkRow").show();
        $("#smkLastYrsRow").show();
    });



    $("#sm1").click(function () {
        $("#smkStartRow").hide();
        $("#smkYrsRow").hide();
        $("#smkPkWkRow").hide();
        $("#smkLastYrsRow").hide();

        $("#smokeAgeStart").val('');
        $("#smokeYears").val('');
        $("#smokePackWeek").val('');
        $("#yrSinceLastSmoke").val('');
    });
    
    
    $("#consum5").click(function () {
        
        $("#moreThan2DrinksRow").hide();
        $("#numYrsAlcCon").hide();
        $("#numYrsAlcCon").val('');
       
    });
    
     $("#consum1").click(function () {
         $("#moreThan2DrinksRow").hide();
        $("#numYrsAlcCon").hide();
        $("#numYrsAlcCon").val('');
       
    });
    
    $("#consum2").click(function () {
        $("#moreThan2DrinksRow").show();
        $("#numYrsAlcCon").show();
        
       
    });
    
    $("#consum3").click(function () {
        $("#moreThan2DrinksRow").show();
        $("#numYrsAlcCon").show();
        
       
    });
    
    $("#consum4").click(function () {
        $("#moreThan2DrinksRow").show();
        $("#numYrsAlcCon").show();
       
    });
    

    $("#secHandSmHist2").click(function () {
        $("#secHandSmokeHistYesDiv").show();
    });

    $("#secHandSmHist1").click(function () {
        
        $("#secHandSmokeHistYesDiv").hide();
        $("#secHandSmHist3").prop('checked', false);
        $("#secHandSmHist4").prop('checked', false);
    });



    $("#smokeAgeStart").AllowNumericOnly();
    $("#smokeYears").AllowNumericOnly();
    $("#smokePackWeek").AllowNumericOnly();
    $("#yrSinceLastSmoke").AllowNumericOnly();

});

function sub() {
    
    var changed = document.getElementById("changed").value;
    if (changed == "Y") {
        alert("Please save/update the change first !");
        return false;
    }

}









