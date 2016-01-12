$(document).ready(function () {

    $(":input").change(function () {
        document.getElementById("changed").value = "Y";
        //alert("Changed!")
    });

    $("#tissueReceived_no").click(function() {

        $('#restOfTheForm').hide();

        $("#excessReleased_no").prop('checked', true);
        $("#excessReleased_no").change();
        $('#tissueNotReceivedReasonTr').show();
        
        
        /* reset all values that you may have entered for 'Yes' */
        
        
    });
    
    
    $("#tissueReceived_yes").click(function() {
         $('#restOfTheForm').show();
         $('#tissueNotReceivedReason').val('');
         $('#tissueNotReceivedReasonTr').hide();
    });
      
        $("#transportPerformed_yes").change(function() {
            $("#transportCommentsRow").hide()    
            $("#transportComments").val('')
        });

        $("#transportPerformed_no").change(function() {
            $("#transportCommentsRow").show()
        });
        
        $("#photoTaken_yes").click(function() {
            $("#photosRow").show()
            $("#reasonNoPhotoRow").hide()
            $("#reasonNoPhoto").val("")
        });

        $("#photoTaken_no").click(function() {
            $("#photosRow").hide()
            $("#reasonNoPhotoRow").show()
            
        });
        
        $("#inkUsed_yes").click(function() {
            $("#inkTypeRow").show()
        });

        $("#inkUsed_no").click(function() {
            $("#inkTypeRow").hide()
            $("#inkType").val('')
        });
        
        $("#excessReleased_yes").click(function() {
            $("#noReleaseReasonRow").hide()
            $("#noReleaseReason").val('')
            $("#parentSpecimenRow").show()
            $("#excessHRow").show()
            $("#areaPercentageRow").show()
            $("#contentPercentageRow").show()
            $("#appearanceRow").show()
            $("#normalAdjHeaderRow").show()
            $("#normalAdjReleasedRow").show()
            $("#secTissueCollectRow").show()
            $("#dimenMeetCriteriaRow").show()
            
            if ($("#normalAdjReleased_yes").attr('checked'))
            {
                $("#normalAdjHRow").show()
            }
            else
            {
                $("#normalAdjHRow").hide()
                $("#normalAdjH").val('0')
                $("#normalAdjW").val('0')
                $("#normalAdjD").val('0')
            }
            $("#transferHeaderRow").show()
            $("#timeTransferredRow").show()
        });

        $("#excessReleased_no").click(function() {
            $("#noReleaseReasonRow").show()
            $("#parentSpecimenRow").hide()
            $("#excessHRow").hide()
            $("#excessH").val('0')
            $("#excessW").val('0')
            $("#excessD").val('0')
            $("#areaPercentageRow").hide()
            $("#areaPercentage").val('')
            $("#contentPercentageRow").hide()
            $("#contentPercentage").val('')
            $("#appearanceRow").hide()
            $("#appearance5").attr('checked', true) // This radio button's value is blank. By checking it, the appearance field will be set to blank.
            $("#normalAdjHeaderRow").hide()
            $("#normalAdjReleasedRow").hide()
            $("#normalAdjReleasedBlank").attr('checked', true) // This radio button's value is blank. By checking it, the normalAdjReleased field will be set to blank.
            $("#normalAdjHRow").hide()
            $("#normalAdjH").val('0')
            $("#normalAdjW").val('0')
            $("#normalAdjD").val('0')
            $("#transferHeaderRow").hide()
            $("#timeTransferredRow").hide()
            $("#timeTransferred").val('')
            $("#secTissueCollectRow").hide()
            $("#dimenMeetCriteriaRow").hide()
            $("#dimNoMeetCriteriaReason").hide()
            
            
        });
        
        $("#normalAdjReleased_yes").change(function() {
            
            $("#normalAdjHRow").show()
        });

        $("#normalAdjReleased_no").change(function() {
            
            $("#normalAdjHRow").hide()
            
            $("#normalAdjH").val('0')
            $("#normalAdjW").val('0')
            $("#normalAdjD").val('0')
        });
        
       
        
         $("#dimenMeetCriteria_yes").change(function() {
            
            $("#dimNoMeetCriteriaReason").hide()
            $("#dimNoMeetCriteriaReason").val('')
        });

        $("#dimenMeetCriteria_no").change(function() {
            
            $("#dimNoMeetCriteriaReason").show()
        });
        
        $('.saveAction').click(function() {
            var val = $('#roomTemperature').val()
            val = val.replace(/,/g, '')

            val = $('#roomHumidity').val()
            val = val.replace(/,/g, '')

            if (val < 0 || val > 100) {
                alert("Question #6 must be between 0 and 100")
                $('#roomHumidity').focus()
                return false
            }
            

            
            val = $('#areaPercentage').val()
            val = val.replace(/,/g, '')
/*            if (isNaN(val)) {
                alert('Question #17 must be a number')
                $('#areaPercentage').focus()
                return false
            }*/
            if (val < 0 || val > 100) {
                alert("Question #17 must be between 0 and 100")
                $('#areaPercentage').focus()
                return false
            }
            
            val = $('#contentPercentage').val()
            val = val.replace(/,/g, '')
/*            if (isNaN(val)) {
                alert('Question #18 must be a number')
                $('#contentPercentage').focus()
                return false
            }*/
            if (val < 0 || val > 100) {
                alert("Question #18 must be between 0 and 100")
                $('#contentPercentage').focus()
                return false
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