<%@ page import="nci.bbrb.cdr.forms.CancerHistory" %>

<script>
    $(document).ready(function(){
        
        $("#t4").change(function(){ 
            if(document.getElementById("t4").checked){
                $("#ot").show();
            } else {
                document.getElementById("ot").style.display = "none";
                document.getElementById("otherTreatment").value = "";
            }
         });
     });
     
    
  </script>
<div class="dialog">
    <table>
        <tbody>

      
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="primaryTumorSite"><g:message code="cancerHistory.primaryTumorSite.label" default="Primary Tumor Site" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'primaryTumorSite', 'errors')}">
                <g:textField name="primaryTumorSite" value="${cancerHistoryInstance?.primaryTumorSite}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="monthYearOfFirstDiagnosis"><g:message code="cancerHistory.monthYearOfFirstDiagnosis.label" default="Month Year Of First Diagnosis" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'monthYearOfFirstDiagnosis', 'errors')}">
                
                     <g:datePicker name="monthYearOfFirstDiagnosis" precision="month" value="${cancerHistoryInstance?.monthYearOfFirstDiagnosis}" default="none" noSelection="['': '']" years="${1900..2099}" />
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
              <label for="treatments"><g:message code="cancerHistory.treatments.label" default="History of any treatments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'treatments', 'errors')}">
              <div>
                <g:checkBox name="treatmentSurgery" id="t1" value="${cancerHistoryInstance?.treatmentSurgery}" />&nbsp;<label for="t1">Surgery</label><br/>
                <g:checkBox name="treatmentRadiation" id="t2" value="${cancerHistoryInstance?.treatmentRadiation}" />&nbsp;<label for="t2">Radiation</label><br/>
                <g:checkBox name="treatmentChemotherapy" id="t3" value="${cancerHistoryInstance?.treatmentChemotherapy}" />&nbsp;<label for="t3">Chemotherapy</label><br/>
                <g:checkBox name="treatmentOther" id="t4" value="${cancerHistoryInstance?.treatmentOther}" />&nbsp;<label for="t4">Other</label><br/>
                <g:checkBox name="treatmentNo" id="t5" value="${cancerHistoryInstance?.treatmentNo}" />&nbsp;<label for="t5">None</label><br/>
                <g:checkBox name="treatmentUnknown" id="t6" value="${cancerHistoryInstance?.treatmentUnknown}" />&nbsp;<label for="t6">Unknown</label><br/>
              </div>
            </td>
          </tr>
          <g:if test="${cancerHistoryInstance?.treatmentOther}">
            <tr class="prop"  id="ot" >
              <td valign="top" class="name">
                <label for="otherTreatment"><g:message code="cancerHistory.otherTreatment.label" default="If Other, specify:" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'otherTreatment', 'errors')}">
            <g:textField name="otherTreatment" value="${cancerHistoryInstance?.otherTreatment}" />
            </td>
            </tr>
          </g:if>
          <g:else>
            <tr class="prop"  id="ot" style="display:none">
              <td valign="top" class="name">
                <label for="otherTreatment"><g:message code="cancerHistory.otherTreatment.label" default="If Other, specify:" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'otherTreatment', 'errors')}">
            <g:textField name="otherTreatment" value="${cancerHistoryInstance?.otherTreatment}" />
            </td>
            </tr>
          </g:else>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="monthYearOfLastTreatment"><g:message code="cancerHistory.monthYearOfLastTreatment.label" default="Month Year Of Last Treatment" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'monthYearOfLastTreatment', 'errors')}">
               <g:datePicker name="monthYearOfLastTreatment" precision="month" value="${cancerHistoryInstance?.monthYearOfLastTreatment}" default="none" noSelection="['': '']" years="${1900..2099}" />
            </td>
        </tr>

        
        
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="source"><g:message code="cancerHistory.source.label" default="Source" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'source', 'errors')}">
              <g:select name="source" from="${nci.bbrb.cdr.forms.CancerHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.CancerHistory$SourceType?.values()*.name()}" value="${cancerHistoryInstance?.source?.name()}" noSelection="['': '']" />

            </td>
        </tr>

       
        
              
        
        
        

        </tbody>
    </table>
</div>  
