    $(document).ready(function() {
//alert("hello");
          $("#historyOfCancerYesNo").change(function() {
            if($("#historyOfCancerYesNo").val() == 'Yes') {
                $("#addCancerHistRow").show()
            } else {
                $("#historyOfCancer").val('No')
                $("#addCancerHistRow").hide()
            }
        });
        
        
        
        $("#addGM").click(function(){
        document.getElementById("formGM").style.display = 'block';
        $(this).hide();
    });
    
    
     $("#addMed").click(function(){
        document.getElementById("formMed").style.display = 'block';
        $(this).hide();
    });
    
    
     $("#addCancer").click(function(){
        document.getElementById("formCancer").style.display = 'block';
        $(this).hide();
    });
       
   });
                   

                   
