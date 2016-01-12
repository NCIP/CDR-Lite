<%@ page import="nci.bbrb.cdr.forms.TissueReceiptDissection" %>
<g:render template="/caseRecord/caseDetails" bean="${tissueReceiptDissectionInstance.caseRecord}" var="caseRecord" />
<div class="dialog">
    <table>
        <tbody>
            <input type='hidden' name="caseRecord.id" value="${ tissueReceiptDissectionInstance?.caseRecord?.id}" />
            <g:hiddenField name="id" value="${tissueReceiptDissectionInstance?.id}" />  
        
            <tr id="sopGuidanceSectionTitle" >
            <td colspan="2" class="formheader">Receipt and dissection of surgical tissue are expected to conform to your surgical tissue collection and processing SOP. <br/>
            Please specify any deviation(s) from the SOP in the Comments fields at the bottom of each section.
        </td>
        </tr>
            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="receiptDissectSOP">1. SOP governing receipt and dissection of surgical tissue in the Tissue Bank</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'receiptDissectSOP', 'errors')}">
                <g:textField name="receiptDissectSOP" value="${tissueReceiptDissectionInstance?.receiptDissectSOP}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeTissueReceived">2. Date and time tissue specimens were received in Tissue Bank from the Pathology Gross Room</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'dateTimeTissueReceived', 'errors')}">
                <g:jqDateTimePicker name="dateTimeTissueReceived" precision="minute" value="${tissueReceiptDissectionInstance?.dateTimeTissueReceived}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="tissueRecipient">3. Tissue specimens were received in Tissue Bank from the Pathology Gross Room by: (name)</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'tissueRecipient', 'errors')}">
                <g:textField name="tissueRecipient" value="${tissueReceiptDissectionInstance?.tissueRecipient}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="tissueReceiptComment">4. Comments/issues with tissue receipt or deviation(s) from SOP</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'tissueReceiptComment', 'errors')}">
                <g:textArea name="tissueReceiptComment" cols="40" rows="5" maxlength="4000" value="${tissueReceiptDissectionInstance?.tissueReceiptComment}"/>

            </td>
        </tr>

        <tr id="moduleOneSectionTitle" >
            <td colspan="2" class="formheader">Tumor Tissue Specimen Dissection Information. Note any deviation(s) from your SOP in the Comments field at 
the bottom of this section. </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="parentTissueDissectedBy">5. Dissection of gross tissue specimen was performed by</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'parentTissueDissectedBy', 'errors')}">
                <g:textField name="parentTissueDissectedBy" value="${tissueReceiptDissectionInstance?.parentTissueDissectedBy}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="parentTissueDissectBegan">6. Time dissection of gross tissue specimen began</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'parentTissueDissectBegan', 'errors')}">
                <g:textField name="parentTissueDissectBegan" value="${tissueReceiptDissectionInstance?.parentTissueDissectBegan}"  class="timeEntry" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="parentTissueDissectEnded">7. Time dissection of gross tissue specimen ended</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'parentTissueDissectEnded', 'errors')}">
                <g:textField name="parentTissueDissectEnded" value="${tissueReceiptDissectionInstance?.parentTissueDissectEnded}"  class="timeEntry" />

            </td>
        </tr>

        
              
        <tr class="prop" id="grossAppearanceRow">
            <td valign="top" class="name">
                <label for="grossAppearance">8. Gross appearance of tissue specimen as determined in Pathology Gross Room</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'grossAppearance', 'errors')}">
                <g:select name="grossAppearance"  from="${['Tumor','Other-specify']}" value="${tissueReceiptDissectionInstance?.grossAppearance}" noSelection="['':'']" />

            </td>
        </tr>
       
        <script>
            $("#grossAppearance").change(function() {
            if($("#grossAppearance").val() == 'Other-specify') {
                $("#otherGrossAppearanceRow").show()
            } else {
                $("#otherGrossAppearance").val('')
                $("#otherGrossAppearanceRow").hide()
            }
        });
        </script>
        <tr class="prop"  id="otherGrossAppearanceRow" style="display:${tissueReceiptDissectionInstance?.grossAppearance =='Other-specify'?'display':'none'}">
            <td valign="top" class="name">
                <label for="otherGrossAppearance">Other Gross Appearance of specimen</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'otherGrossAppearance', 'errors')}">
                <g:textField name="otherGrossAppearance" value="${tissueReceiptDissectionInstance?.otherGrossAppearance}"/>

            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="tumorSource">9. Source of tumor tissue</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'tumorSource', 'errors')}">
                <g:textField name="tumorSource" value="${tissueReceiptDissectionInstance?.tumorSource}"/>

            </td>
        </tr>

        
        <tr class="prop" id="collectionProcedureRow">
            <td valign="top" class="name">
                <label for="collectionProcedure">10. Tissue collection procedure</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'collectionProcedure', 'errors')}">
                <g:select name="collectionProcedure"  from="${['Surgical','Core-biopsy','Needle-biopsy','Other-specify']}"  value="${tissueReceiptDissectionInstance?.collectionProcedure}"  noSelection="['': '']" />

            </td>
        </tr>
        
        <script>
            $("#collectionProcedure").change(function() {
            if($("#collectionProcedure").val() == 'Other-specify') {
                $("#otherCollectionProcedureRow").show()
            } else {
                $("#otherCollectionProcedure").val('')
                $("#otherCollectionProcedureRow").hide()
            }
            });

        </script>
        
        <tr class="prop"  id="otherCollectionProcedureRow" style="display:${tissueReceiptDissectionInstance?.collectionProcedure =='Other-specify'?'display':'none'}">
            <td valign="top" class="name">
                <label for="otherCollectionProcedure"><g:message code="tissueReceiptDissection.otherCollectionProcedure.label" default="Other Collection Procedure" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'otherCollectionProcedure', 'errors')}">
                <g:textField name="otherCollectionProcedure" value="${tissueReceiptDissectionInstance?.otherCollectionProcedure}"/>

            </td>
        </tr>

        <tr id="fixativeSectionTitle">
                <td colspan="2" class="formheader">Required Study Tissue</td>
        </tr>

        <tr class="prop" id="fixativeTypeRow">
            <td valign="top" class="name">
                <label for="fixativeType">11.<g:message code="tissueReceiptDissection.fixativeType.label" default="Fixative Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativeType', 'errors')}">
                <g:select name="fixativeType"  from="${['Buffered-formalin','Ethanol','PAXgene tissues','Other-specify']}" value="${tissueReceiptDissectionInstance?.fixativeType}" noSelection="['': '']"/>

            </td>
        </tr>
        <script>
         $("#fixativeType").change(function() {
            if($("#fixativeType").val() == 'Other-specify') {
                $("#otherFixativeTypeRow").show()
            } else {
                $("#otherFixativeType").val('');
                $("#otherFixativeTypeRow").hide()
            }
        });
        </script>
        
        <tr class="prop" id="otherFixativeTypeRow" style="display:${tissueReceiptDissectionInstance?.fixativeType =='Other-specify'?'display':'none'}">
            <td valign="top" class="name">
                <label for="otherFixativeType"><g:message code="tissueReceiptDissection.otherFixativeType.label" default="Other Fixative Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'otherFixativeType', 'errors')}">
                 <g:textField name="otherFixativeType" value="${tissueReceiptDissectionInstance?.otherFixativeType}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="fixativeFormula">12.<g:message code="tissueReceiptDissection.fixativeFormula.label" default="Fixative Formula" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativeFormula', 'errors')}">
                <g:textField name="fixativeFormula" value="${tissueReceiptDissectionInstance?.fixativeFormula}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="fixativePH">13. <g:message code="tissueReceiptDissection.fixativePH.label" default="Fixative pH" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativePH', 'errors')}">
                <g:textField name="fixativePH" value="${tissueReceiptDissectionInstance?.fixativePH}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="fixativeManufacturer">14. Manufacturer of fixative</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativeManufacturer', 'errors')}">
                <g:textField name="fixativeManufacturer" value="${tissueReceiptDissectionInstance?.fixativeManufacturer}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="fixativeLotNum">15. <g:message code="tissueReceiptDissection.fixativeLotNum.label" default="Fixative Lot Num" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativeLotNum', 'errors')}">
                <g:textField name="fixativeLotNum" value="${tissueReceiptDissectionInstance?.fixativeLotNum}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateFixativeLotNumExpired">16. <g:message code="tissueReceiptDissection.dateFixativeLotNumExpired.label" default="Date Fixative Lot Num Expired" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'dateFixativeLotNumExpired', 'errors')}">
                <g:jqDateTimePicker name="dateFixativeLotNumExpired" precision="day"  value="${tissueReceiptDissectionInstance?.dateFixativeLotNumExpired}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="fixativeProductNum">17. <g:message code="tissueReceiptDissection.fixativeProductNum.label" default="Fixative Product Num" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativeProductNum', 'errors')}">
                <g:textField name="fixativeProductNum" value="${tissueReceiptDissectionInstance?.fixativeProductNum}"/>

            </td>
        </tr>

        
        <tr class="prop"  id="fixativeProductTypeRow">
            <td valign="top" class="name">
                <label for="fixativeProductType">18. Is fixative a commercial product or prepared in-house</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'fixativeProductType', 'errors')}">
               <g:select name="fixativeProductType" from="${['Commercial','In-house','Other-specify']}"  value="${tissueReceiptDissectionInstance?.fixativeProductType}" noSelection="['': '']" />

            </td>
        </tr>

        <script>   
          
          $('#fixativeProductType').change(function() {
            if($('#fixativeProductType').val() == 'Other-specify') {
                $('#otherFixativeProductTypeRow').show()
            } else {
                $('#otherFixativeProductType').val('')
                $('#otherFixativeProductTypeRow').hide()
            }
        });
        
         </script>    
        <tr class="prop" id="otherFixativeProductTypeRow"  style="display:${tissueReceiptDissectionInstance?.fixativeProductType =='Other-specify'?'display':'none'}">
            <td valign="top" class="name">
                <label for="otherFixativeProductType"><g:message code="tissueReceiptDissection.otherFixativeProductType.label" default="Other Fixative Product Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'otherFixativeProductType', 'errors')}">
                <g:textField name="otherFixativeProductType" value="${tissueReceiptDissectionInstance?.otherFixativeProductType}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="parentTissueSopComment">19.Comments/issues with tissue fixation or deviation(s) from SOP</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueReceiptDissectionInstance, field: 'parentTissueSopComment', 'errors')}">
                <g:textArea name="parentTissueSopComment" cols="40" rows="5" maxlength="4000" value="${tissueReceiptDissectionInstance?.parentTissueSopComment}"/>

            </td>
        </tr>


        </tbody>
    </table>
</div>  
