%{-- <%@ page import="nci.bbrb.cdr.staticmembers.Module" %> --}%
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<style type="text/css">
    textarea {width:213px; height: 75px}
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #fff; padding: .1em 1px; text-align: center; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
    .ui-widget-header a { color: none; }
</style>

<script>

    $(function() {
        $("#dialog:ui-dialog").dialog("destroy");
        var name = $("#slideId"),
            email = $( "#ctId"),
            password = $("#code"),
            volume = $("#volume");

        $("#add-slide").dialog({
            autoOpen: false,
            height: 115,
            width: 400,
            modal: true,
            buttons: {},
            close: function() {}
        });

        $("#addSlideBtn").button().click(function() {
            $("#add-slide" ).dialog("open");
            $("#newslideId").val("");
            $("#specimenId").val("")
            return false;
        });

        
        $("#saveBtn").click(function() {
    
            if($("#newslideId").val()==null || $("#newslideId").val().length==0){
              alert("Slide ID is a required field");
              return false;
            }else if($("#specimenId").val()==null || $("#specimenId").val().length==0){
              alert("Specimen ID is a required field");
              return false;
            }else{
                $("#add-slide").dialog("close");
                return true;
            }
        });
        

        $("#cancelBtn").click(function() {
            $("#add-slide").dialog("close");
            return false;
        });
    });
</script>
<g:set var="cid" value="${slideSectionInstance?.caseRecord?.id ?: params.caseRecord?.id}" />
<div id="add-slide">
    <g:formRemote name="slide" url="[controller: 'slideSection', action: 'addSlide']" update="slideDialog">
        <g:hiddenField name="caseId" value="${slideSectionInstance?.caseRecord?.id ?: params.caseRecord?.id}"/>
        <table>
            <tbody>
                <tr>
                    <th valign="top" class="name">
                        Slide ID
                    </th>
                     <th valign="top" class="name">
                        Specimen ID
                    </th>
                </tr>
                
                <tr class="prop">
                    <td valign="top" class="value ${hasErrors(bean: slideRecord, field: 'slideId', 'errors')}">
                        <g:textField name="slideId" id="newslideId" value=""/>
                    </td>
                    <td>
                    <g:select name="specimenRecord" id="specimenId" from="${slideSectionInstance?.caseRecord?.specimens}" optionKey="id" optionValue="specimenId"  noSelection="['': '']" />
                    </td>
                </tr>
                
                <tr class="prop">
                    <td colspan="4" class="popupbuttons ui-corner-all">
                        <g:actionSubmit class="button left" action="addSlide" value="Save" id="saveBtn"/> &nbsp;&nbsp;
                        <g:actionSubmit class="button right" action="update" value="Cancel" id="cancelBtn"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </g:formRemote>
</div>