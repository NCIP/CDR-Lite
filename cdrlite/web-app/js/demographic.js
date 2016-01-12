/* Please do not check in commented out code like alert(flags) , partial code etc... */
 
$(document).ready(function() {
    
    function checkHeight(){
        var h = document.getElementById("height").value;
        if(isNaN(h) || h<0 ){
            alert("The height must be a positive number");
            document.getElementById("height").focus();
            return false;
        }
        return true;
    }
    function checkWeight(){
        var w = document.getElementById("weight").value;
        if(isNaN(w) || w<0){
            alert("The weight must be a positive number");
            document.getElementById("weight").focus();
            return false;
        }
        return true;
    }

    $("#g1").change(function(){
        document.getElementById("otherGender").value='';
        document.getElementById("other").style.display = 'none';
    });  
    
    $("#g2").change(function(){
        document.getElementById("otherGender").value='';
        document.getElementById("other").style.display = 'none';
    }); 
    
    $("#g3").change(function(){
        document.getElementById("otherGender").value='';
        document.getElementById("other").style.display = 'none';
    });
    
    $("#g4").change(function(){
        $("#other").show();
    });  

    $("#height").change(function(){
        var h = document.getElementById("height").value;
        
        var bmi;
       
        //if(!isNaN(h) && !isNaN(w) && h!= 0 && w !=0){
        if(checkHeight())
        {
            var w = document.getElementById("weight").value;
            bmi=(703*w)/(h*h);
            bmi=bmi.toFixed(2); 
            document.getElementById("BMI").value=bmi;
            $("#bmi").html(bmi);
        }
    });

    $("#weight").change(function(){
       
        var w = document.getElementById("weight").value;
        var bmi;
        if(checkWeight())
        {
            //if(!isNaN(h) && !isNaN(w) && h != 0 && w !=0){
            var h = document.getElementById("height").value;
            bmi=(703*w)/(h*h);
            bmi=bmi.toFixed(2); 
            document.getElementById("BMI").value=bmi;
            $("#bmi").html(bmi);
            //}
        }
    });
});
 