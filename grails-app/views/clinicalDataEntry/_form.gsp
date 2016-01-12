<%@ page import="nci.bbrb.cdr.forms.ClinicalDataEntry" %>
<%@ page import="nci.bbrb.cdr.util.AppSetting" %>

<div class="dialog">
    <%
       Double versionValue = 0.0
    %>
    <table>
        <tbody>
            <%
                def labelNumber = 1
            %>
            <input type='hidden' name="caseRecord.id" value="${ clinicalDataEntryInstance?.caseRecord?.id}" />
            <g:hiddenField name="id" value="${clinicalDataEntryInstance?.id}" />  
            <g:set var="primaryTissueType" value="${clinicalDataEntryInstance.caseRecord?.primaryTissueType?.toString().toUpperCase()}"/>
            <g:set var="tumorStageList" value="${AppSetting?.findByCode("TUMOR_STAGE_"+primaryTissueType)?.bigValue?.split(",")?.toList()}" />
            <g:set var="ajccTumorStageList" value="${AppSetting?.findByCode('TUMOR_STAGE_AJCC_OVARY')?.bigValue?.split(",")?.toList()}" />
        <tr>
           
        <td colspan="2">
        <g:render template="/caseRecord/caseDetails" bean="${clinicalDataEntryInstance.caseRecord}" var="caseRecord" />    
        </td></tr>
        <tr>
            <td colspan="2" class="formheader">History of Cancer in Participant or blood relatives
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name" style="width:630px;"> 
                <label for="prevMalignancy">${labelNumber++}. Does the Participant have a history of prior malignancy?</label>
            </td>
            <td  valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'prevMalignancy', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${clinicalDataEntryInstance?.prevMalignancy}" name="prevMalignancy" />

            </td>
        </tr>

        <tr class="prop clearborder subentry" id="PrevCancerTable" style="display:${clinicalDataEntryInstance?.prevMalignancy == 'Yes'?'display':'none'}">
            <td colspan="2">
                <g:render template="PrevCancerTabContent"/>
            </td>
        </tr>
        
        <tr id="prevCancerSave" class="subentry" style="display:${clinicalDataEntryInstance?.prevMalignancy == 'Yes'?'display':'none'}">
            <td colspan="2"><g:actionSubmit style="display:none" id="prevCancerSaveBtn" action="savePrevCancerDiag" value="Save" /><g:actionSubmit style="display:none" id="prevCancerCancelBtn" value="Cancel" /><g:actionSubmit class="Btn commentsdtentry" id="prevCancerAddBtn" value="Add" /></td>
        </tr>            
            
        
        
        
        <tr class="clearborder prop" >
            <td valign="top" class="name">
                <label for="bloodRelCancer1">${labelNumber++}. Participant's blood relatives who have had a history of Cancer:</label>
                <span id="clinicaldataentry.bloodrelcancer" class="vocab-tooltip"></span>
            </td>
        </tr>
       <tr class="prop subentry">
            <td colspan="2" class="${hasErrors(bean: clinicalDataEntryInstance, field: 'bloodRelCancer1', 'errors')}">
                <table id="bloodrelative" class="tabledatecomments">
                    <tr><th class="relationship">Blood Relative</th><th class="cancer">Type of Cancer</th></tr>
                        <tbody>
                          <tr><td><g:checkBox id="bloodRelCancer1" name="bloodRelCancer1" value="Aunt" checked="${clinicalDataEntryInstance?.bloodRelCancer1 == 'Aunt'}" onClick="checkRelatives(this.form, 1)"/> <label for="bloodRelCancer1">Aunt</label></td><td id="relCancerType1Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType1', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer1 == 'Aunt'?'display':'none'}" name="relCancerType1" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType1}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer2" name="bloodRelCancer2" value="Brother" checked="${clinicalDataEntryInstance?.bloodRelCancer2 == 'Brother'}" onClick="checkRelatives(this.form, 2)"/> <label for="bloodRelCancer2">Brother</label></td><td id="relCancerType2Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType2', 'errors')}"><g:textField  style="display:${clinicalDataEntryInstance?.bloodRelCancer2 == 'Brother'?'display':'none'}" name="relCancerType2" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType2}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer3" name="bloodRelCancer3" value="Daughter" checked="${clinicalDataEntryInstance?.bloodRelCancer3 == 'Daughter'}" onClick="checkRelatives(this.form, 3)"/> <label for="bloodRelCancer3">Daughter</label></td><td id="relCancerType3Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType3', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer3 == 'Daughter'?'display':'none'}" name="relCancerType3" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType3}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer4" name="bloodRelCancer4" value="Father" checked="${clinicalDataEntryInstance?.bloodRelCancer4 == 'Father'}" onClick="checkRelatives(this.form, 4)"/> <label for="bloodRelCancer4">Father</label></td><td id="relCancerType4Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType4', 'errors')}" ><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer4 == 'Father'?'display':'none'}"  name="relCancerType4" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType4}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer5" name="bloodRelCancer5" value="Mother" checked="${clinicalDataEntryInstance?.bloodRelCancer5 == 'Mother'}" onClick="checkRelatives(this.form, 5)"/> <label for="bloodRelCancer5">Mother</label></td><td id="relCancerType5Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType5', 'errors')}" ><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer5 == 'Mother'?'display':'none'}" name="relCancerType5" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType5}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer6" name="bloodRelCancer6" value="Sister" checked="${clinicalDataEntryInstance?.bloodRelCancer6 == 'Sister'}" onClick="checkRelatives(this.form, 6)"/> <label for="bloodRelCancer6">Sister</label></td><td id="relCancerType6Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType6', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer6 == 'Sister'?'display':'none'}"  name="relCancerType6" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType6}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer7" name="bloodRelCancer7" value="Son" checked="${clinicalDataEntryInstance?.bloodRelCancer7 == 'Son'}" onClick="checkRelatives(this.form, 7)"/> <label for="bloodRelCancer7">Son</label></td><td id="relCancerType7Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType7', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer7 == 'Son'?'display':'none'}" name="relCancerType7" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType7}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer8" name="bloodRelCancer8" value="Uncle" checked="${clinicalDataEntryInstance?.bloodRelCancer8 == 'Uncle'}" onClick="checkRelatives(this.form, 8)"/> <label for="bloodRelCancer8">Uncle</label></td><td id="relCancerType8Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType8', 'errors')}" ><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer8 == 'Uncle'?'display':'none'}" name="relCancerType8" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType8}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer9" name="bloodRelCancer9" value="Grandmother" checked="${clinicalDataEntryInstance?.bloodRelCancer9 == 'Grandmother'}" onClick="checkRelatives(this.form, 9)"/> <label for="bloodRelCancer9">Grandmother</label></td><td id="relCancerType9Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType9', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer9 == 'Grandmother'?'display':'none'}" name="relCancerType9" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType9}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer10" name="bloodRelCancer10" value="Grandfather" checked="${clinicalDataEntryInstance?.bloodRelCancer10 == 'Grandfather'}" onClick="checkRelatives(this.form, 10)"/> <label for="bloodRelCancer10">Grandfather</label></td><td id="relCancerType10Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType10', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer10 == 'Grandfather'?'display':'none'}" name="relCancerType10" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType10}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer11" name="bloodRelCancer11" value="Nephew" checked="${clinicalDataEntryInstance?.bloodRelCancer11 == 'Nephew'}" onClick="checkRelatives(this.form, 11)"/> <label for="bloodRelCancer11">Nephew</label></td><td id="relCancerType11Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType11', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer11 == 'Nephew'?'display':'none'}"  name="relCancerType11" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType11}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer12" name="bloodRelCancer12" value="Niece" checked="${clinicalDataEntryInstance?.bloodRelCancer12 == 'Niece'}" onClick="checkRelatives(this.form, 12)"/> <label for="bloodRelCancer12">Niece</label></td><td id="relCancerType12Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType12', 'errors')}" ><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer12 == 'Niece'?'display':'none'}"  name="relCancerType12" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType12}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer13" name="bloodRelCancer13" value="Other" checked="${clinicalDataEntryInstance?.bloodRelCancer13 == 'Other'}" onClick="checkRelatives(this.form, 13)"/> <label for="bloodRelCancer13">Other - Specify</label></td><td></td></tr>
                          <tr><td class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'othBloodRelCancer', 'errors')}"><g:textField id="othbloodRel" style="display:${clinicalDataEntryInstance?.bloodRelCancer13 == 'Other'?'display':'none'}" name="othBloodRelCancer" maxlength="255" value="${clinicalDataEntryInstance?.othBloodRelCancer}" />&nbsp;</td><td id="relCancerType13Cell" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'relCancerType13', 'errors')}"><g:textField style="display:${clinicalDataEntryInstance?.bloodRelCancer13 == 'Other'?'display':'none'}" name="relCancerType13" maxlength="255" value="${clinicalDataEntryInstance?.relCancerType13}" /></td></tr>
                          <tr><td><g:checkBox id="bloodRelCancer14" name="bloodRelCancer14" value="None" checked="${clinicalDataEntryInstance?.bloodRelCancer14 == 'None'}" onClick="checkRelatives(this.form, 14)"/> <label for="bloodRelCancer14">None</label></td><td></td></tr>
                     
                        </tbody>
                </table>
            </td>
        </tr>
       
        
        <tr class="prop clearborder" >
            <td valign="top" class="name">
                <label for="isImmunoSupp">${labelNumber++}. Does the Participant have an immunosuppressive issue (HIV, organ transplant, steroid use, etc.)?</label>
                <span id="clinicaldataentry.immunosupressiveissue" class="vocab-tooltip"></span>
            </td>
            <td class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'isImmunoSupp', 'errors')}"><g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.isImmunoSupp)}"  name="isImmunoSupp" /></td>
        </tr>
        <tr class="prop subentry" id="immunoSuppRow" style="display:${clinicalDataEntryInstance?.isImmunoSupp == 'Yes'?'display':'none'}">
            <td colspan="2" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'immunoSuppStatus1', 'errors')}"><div>
                <table class="tabledatecomments">
                    <tr><td valign="top" ><g:checkBox id ="immunoSuppStatus1" name="immunoSuppStatus1" value="HIV" checked="${clinicalDataEntryInstance?.immunoSuppStatus1 == 'HIV'}" />&nbsp;<label for="immunoSuppStatus1">HIV</label></td></tr>
                    <tr><td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'immunoSuppStatus2', 'errors')}"><g:checkBox id ="immunoSuppStatus2" name="immunoSuppStatus2" value="Organ transplant" checked="${clinicalDataEntryInstance?.immunoSuppStatus2 == 'Organ transplant'}" />&nbsp;<label for="immunoSuppStatus2">Organ transplant</label></td></tr>
                    <tr><td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'immunoSuppStatus3', 'errors')}"><g:checkBox id ="immunoSuppStatus3" name="immunoSuppStatus3" value="Chronic systemic steroid use" checked="${clinicalDataEntryInstance?.immunoSuppStatus3 == 'Chronic systemic steroid use'}" />&nbsp;<label for="immunoSuppStatus3">Chronic systemic steroid use</label></td></tr>
                    <tr><td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'immunoSuppStatus4', 'errors')}"><g:checkBox id ="immunoSuppStatus4" name="immunoSuppStatus4" value="Other - specify" checked="${clinicalDataEntryInstance?.immunoSuppStatus4 == 'Other - specify'}" />&nbsp;<label for="immunoSuppStatus4">Other - specify</label></td></tr>
                    <tr class="prop" id="othImmStat" style="display:${clinicalDataEntryInstance?.immunoSuppStatus4 == 'Other - specify'?'display':'none'}"><td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'otherImmunoSuppStatus', 'errors')}"><g:textField name="otherImmunoSuppStatus" maxlength="255" value="${clinicalDataEntryInstance?.otherImmunoSuppStatus}" /></td></tr>
                </table></div>
            </td>
        </tr>

        

        
        <tr class="prop clearborder">
            <td valign="top" class="name">
                <label for="irradTherb4Surg">${labelNumber++}. Has the Participant received radiation therapy prior to surgery?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'irradTherb4Surg', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.irradTherb4Surg)}"  name="irradTherb4Surg" />
            </td>
        </tr>
            
        <tr class="prop clearborder subentry" id="IrradTable" style="display:${clinicalDataEntryInstance?.irradTherb4Surg == 'Yes'?'display':'none'}">
            <td colspan="2">
                <g:render template="IrradTabContent"/>
            </td>
        </tr>

        <tr id="irradSaveRow" class="subentry" style="display:${clinicalDataEntryInstance?.irradTherb4Surg == 'Yes'?'display':'none'}">
            <td colspan="2"><g:actionSubmit id="irradSaveBtn" style="display:none" class="Save" action="saveIrradTher" value="Save" /><g:actionSubmit style="display:none" id="irradCancelBtn" value="Cancel" /><g:actionSubmit class="Btn" id="irradAddBtn" value="Add" /></td>
             <%--  <td><g:submitToRemote id="irradSaveBtn" asynchronus="false" url="[controller: 'bpvClinicalDataEntry', action: 'saveIrradTher']" before="validateIrrad()" value="Save" update="IrradTableContent"/><g:actionSubmit style="display:none" id="irradCancelBtn" value="Cancel" /><g:actionSubmit id="irradAddBtn" value="Add" /></td> --%>
        </tr>            
            
        <tr class="prop clearborder">
            <td valign="top" class="name">
                <label for="chemoTherb4Surg">${labelNumber++}. Has the Participant received chemotherapy prior to surgery?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'chemoTherb4Surg', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.chemoTherb4Surg)}"  name="chemoTherb4Surg" />
            </td>
        </tr>
            
        <tr class="prop subentry clearborder" id="ChemoTable" style="display:${clinicalDataEntryInstance?.chemoTherb4Surg == 'Yes'?'display':'none'}">
            <td colspan="2">
                <g:render template="ChemoTabContent"/>
            </td>
        </tr>
            
        <tr id="chemoSaveRow" class="subentry" style="display:${clinicalDataEntryInstance?.chemoTherb4Surg == 'Yes'?'display':'none'}">
            <td colspan="2"><g:actionSubmit id="chemoSaveBtn" style="display:none" action="saveChemo" value="Save" /><g:actionSubmit style="display:none" id="chemoCancelBtn" value="Cancel" /><g:actionSubmit class="Btn" id="chemoAddBtn" value="Add" /></td>
        </tr>

 

        <tr class="prop clearborder">
            <td valign="top" class="name">
                <label for="immTherb4Surg">${labelNumber++}. Has the Participant received immunotherapy prior to surgery?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'immTherb4Surg', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.immTherb4Surg)}"  name="immTherb4Surg" />
            </td>
        </tr>

        <tr class="prop subentry clearborder" id="ImmunoTable" style="display:${clinicalDataEntryInstance?.immTherb4Surg == 'Yes'?'display':'none'}">
            <td colspan="2">
                <g:render template="ImmunoTabContent"/>
            </td>
        </tr>


        <tr id="immSaveRow" class="subentry" style="display:${clinicalDataEntryInstance?.immTherb4Surg == 'Yes'?'display':'none'}">
           <td colspan="2"><g:actionSubmit id="immSaveBtn" style="display:none" action="saveImmunoTher" value="Save" /><g:actionSubmit style="display:none" id="immCancelBtn" value="Cancel" /><g:actionSubmit class="Btn" id="immAddBtn" value="Add" /></td>
        </tr>            

        <tr class="prop clearborder">
            <td valign="top" class="name">
                <label for="hormTherb4Surg">${labelNumber++}. Has the Participant received hormonal therapy prior to surgery?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'hormTherb4Surg', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.hormTherb4Surg)}"  name="hormTherb4Surg" />
            </td>
        </tr>
            
        <tr class="prop clearborder subentry" id="HormTable" style="display:${clinicalDataEntryInstance?.hormTherb4Surg == 'Yes'?'display':'none'}" >
            <td colspan="2">
               <g:render template="HormTabContent"/>
            </td>
        </tr>
        <tr id="hormSaveRow" class="subentry" style="display:${clinicalDataEntryInstance?.hormTherb4Surg == 'Yes'?'display':'none'}" >
            <td colspan="2"><g:actionSubmit id="hormSaveBtn" style="display:none" action="saveHormonalTher" value="Save" /><g:actionSubmit style="display:none" id="hormCancelBtn" value="Cancel" /><g:actionSubmit class="Btn" id="hormAddBtn" value="Add" /></td>
        </tr>            
            

        <g:if test="${clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() == 'Colon'}">
            <tr class="prop clearborder">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Did the Participant have any additional Colorectal Cancer risk factors (as recorded in the medical record)?</label>
                </td>
                <td class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'isAddtlColoRisk', 'errors')}"><g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.isAddtlColoRisk)}"  name="isAddtlColoRisk" /></td>
            </tr>
              
            <tr class="prop" style="display:${clinicalDataEntryInstance?.isAddtlColoRisk == 'Yes'?'display':'none'}" id="addtlColoRiskRow">
                <td colspan="2" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'addtlColoRisk1', 'errors')}">
                    <table class="tabledatecomments">
                        <tr><td valign="top" >
                    <div>
                        <g:checkBox id ="addtlColoRisk1" name="addtlColoRisk1" value="${clinicalDataEntryInstance?.addtlColoRisk1}" />&nbsp;<label for="addtlColoRisk1">A diet that is high in red meats (beef, lamb, or liver) and processed meats (hot dogs and some luncheon meats)</label><br>
                        <g:checkBox id ="addtlColoRisk2" name="addtlColoRisk2" value="${clinicalDataEntryInstance?.addtlColoRisk2}" />&nbsp;<label for="addtlColoRisk2">Obesity – weight > 20% ideal body weight</label><br>
                        <g:checkBox id ="addtlColoRisk3" name="addtlColoRisk3" value="${clinicalDataEntryInstance?.addtlColoRisk3}" />&nbsp;<label for="addtlColoRisk3">Type II diabetes</label><br>
                        <g:checkBox id ="addtlColoRisk4" name="addtlColoRisk4" value="${clinicalDataEntryInstance?.addtlColoRisk4}" />&nbsp;<label for="addtlColoRisk4">Previous colorectal polyps</label><br>
                        <g:checkBox id ="addtlColoRisk5" name="addtlColoRisk5" value="${clinicalDataEntryInstance?.addtlColoRisk5}" />&nbsp;<label for="addtlColoRisk5">Diagnosis of Familial adenomatous polyposis in Participant or family member</label><br>
                        <g:checkBox id ="addtlColoRisk6" name="addtlColoRisk6" value="${clinicalDataEntryInstance?.addtlColoRisk6}" />&nbsp;<label for="addtlColoRisk6">Other risk factors - specify</label>
                    </div></td></tr>
                    </table>
                </td>
            </tr>

            <tr class="prop" id="otherColRiskRow" style="display:${clinicalDataEntryInstance?.addtlColoRisk6 == 'on'?'display':'none'}" >
                <td colspan="2" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'otherAddColRisk', 'errors')}">
                    <g:textArea class="textwide" name="otherAddColRisk" cols="40" rows="5" maxlength="4000" value="${clinicalDataEntryInstance?.otherAddColRisk}" />
                </td>
            </tr>
        </g:if>

        <g:if test="${clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()=='Lung'}">
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="isEnvCarc">${labelNumber++}. Was the Participant exposed to environmental/workplace carcinogens (arsenic, asbestos, diesel exhaust, chromium, and/or silica)?</label>
                </td>
                <td class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'isEnvCarc', 'errors')}"><g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.isEnvCarc)}"  name="isEnvCarc" /></td>
            </tr>
              
            <tr class="prop" style="display:${clinicalDataEntryInstance?.isEnvCarc == 'Yes'?'display':'none'}" id="envCarcRow">
                <td></td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'envCarc1', 'errors')}">
                <div>
                    <g:checkBox id ="envCarc1" name="envCarc1" value="${clinicalDataEntryInstance?.envCarc1}" />&nbsp;<label for="envCarc1">Exposure to arsenic</label><br>
                    <g:checkBox id ="envCarc2" name="envCarc2" value="${clinicalDataEntryInstance?.envCarc2}" />&nbsp;<label for="envCarc2">Exposure to asbestos</label><br>
                    <g:checkBox id ="envCarc3" name="envCarc3" value="${clinicalDataEntryInstance?.envCarc3}" />&nbsp;<label for="envCarc3">Exposure to diesel exhaust</label><br>
                    <g:checkBox id ="envCarc4" name="envCarc4" value="${clinicalDataEntryInstance?.envCarc4}" />&nbsp;<label for="envCarc4">Exposure to chromium</label><br>
                    <g:checkBox id ="envCarc5" name="envCarc5" value="${clinicalDataEntryInstance?.envCarc5}" />&nbsp;<label for="envCarc5">Exposure to silica</label>
                </div>
                </td>
            </tr>

            <tr class="prop" style="display:${clinicalDataEntryInstance?.isEnvCarc == 'Yes'?'display':'none'}" id="envCarcDescRow">
                <td colspan="2" class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'envCarcExpDesc', 'errors')}">
                    <label for="envCarcExpDesc"  class="subentry">Describe circumstances and duration of exposure to environmental carcinogens if available:</label><br />
                    <g:textArea class="textwide" name="envCarcExpDesc" cols="40" rows="5" maxlength="4000" value="${clinicalDataEntryInstance?.envCarcExpDesc}" />
                </td>
            </tr>
        </g:if>

        <tr><td colspan="2" class="formheader">Infectious Diseases</td></tr>
<%--                <tr class="prop">                
                    <td valign="top" class="name">
                        <label>${labelNumber++}. Has the Participant been diagnosed with:</label>
                    </td>
                    <td></td>
                </tr>--%>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="hepB" >${labelNumber++}. Has the Participant been diagnosed with Hepatitis B?</label>
            </td>
            <td valign="top"  class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'hepB', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.hepB)}"  name="hepB" />
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="hepC" >${labelNumber++}. Has the Participant been diagnosed with Hepatitis C?</label>
            </td>
            <td valign="top"  class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'hepC', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.hepC)}"  name="hepC" />
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="hiv" >${labelNumber++}. Has the Participant been diagnosed with HIV?</label>
            </td>
            <td valign="top"  class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'hiv', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.hiv)}"  name="hiv" />
            </td>
        </tr>
               
        <tr class="prop">
            <td valign="top" class="name">
                <label for="scrAssay">${labelNumber++}. Does the Participant have a history of repeatedly reactive screening assays for HIV-1 or HIV-2 antibodies regardless of the results of supplemental assays?</label>
            </td>
            <td valign="top"  class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'scrAssay', 'errors')}">
                <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.scrAssay)}"  name="scrAssay" />
            </td>
        </tr>            
        <tr class="prop" id="othInfectRow" >
            <td colspan="2" class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'otherInfect', 'errors')}">
                <label for="otherInfect" >${labelNumber++}.  Other infectious diseases:</label><br />
                <g:textArea name="otherInfect" class="textwide" cols="40" rows="5" maxlength="255" value="${clinicalDataEntryInstance?.otherInfect}" />
            </td>
        </tr>                
            
        <g:if test="${clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() == 'Ovary'||
                      clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() == 'Uterus'}">
            <tr><td colspan="2"  class="formheader">Reproductive History</td></tr>              
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="wasPregnant">${labelNumber++}. Has the Participant ever been pregnant?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'wasPregnant', 'errors')}">
                    <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.wasPregnant)}"  name="wasPregnant" />
                </td>
            </tr>

            <tr class="prop" id="totPregRow" style="display:${clinicalDataEntryInstance?.wasPregnant == 'Yes'?'display':'none'}" >
                <td valign="top" class="name">
                    <label for="totPregnancies" class="subentry">What is the total number of pregnancies?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'totPregnancies', 'errors')}">
                    <g:textField size="2" maxlength="2" name="totPregnancies" value="${clinicalDataEntryInstance?.totPregnancies}" onkeyup="isNumericValidation(this)" />
                </td>
            </tr>

            <tr class="prop" id="totLBRow" style="display:${clinicalDataEntryInstance?.wasPregnant == 'Yes'?'display':'none'}" >
                <td valign="top" class="name">
                    <label for="totLiveBirths" class="subentry">What is the total number of live births?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'totLiveBirths', 'errors')}">
                    <g:textField size="2" maxlength="2" name="totLiveBirths" value="${clinicalDataEntryInstance?.totLiveBirths}" onkeyup="isNumericValidation(this)" />
                </td>
            </tr>

            <tr class="prop" id="firstChildRow" style="display:${clinicalDataEntryInstance?.wasPregnant == 'Yes'?'display':'none'}" >
                <td valign="top" class="name">
                    <label for="ageAt1stChild" class="subentry">What was the Participant's age when her first biological child was born?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'ageAt1stChild', 'errors')}">
                    <g:textField size="2" maxlength="2" name="ageAt1stChild" value="${clinicalDataEntryInstance?.ageAt1stChild}" onkeyup="isNumericValidation(this)" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="gynSurg">${labelNumber++}. Has the Participant had any of these gynecological surgeries in the past?</label>
                </td>
                <td valign="top"  class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'gynSurg', 'errors')}">
                    <div>
                        <g:radio name="gynSurg" id="gynSurg1" value="Hysterectomy" checked="${clinicalDataEntryInstance?.gynSurg == 'Hysterectomy'}" />&nbsp;<label for="gynSurg1">Hysterectomy</label><br/>
                        <g:radio name="gynSurg" id="gynSurg2" value="Unilateral oophorectomy" checked="${clinicalDataEntryInstance?.gynSurg == 'Unilateral oophorectomy'}" />&nbsp;<label for="gynSurg2">Unilateral oophorectomy</label><br/>
                        <g:radio name="gynSurg" id="gynSurg3" value="Neither hysterectomy nor oophorectomy" checked="${clinicalDataEntryInstance?.gynSurg == 'Neither hysterectomy nor oophorectomy'}" />&nbsp;<label for="gynSurg3">Neither hysterectomy nor oophorectomy</label><br/>
                        <g:radio name="gynSurg" id="gynSurg4" value="Unknown" checked="${clinicalDataEntryInstance?.gynSurg == 'Unknown'}" />&nbsp;<label for="gynSurg4">Unknown</label>
                    </div>  
                </td>
            </tr>
                
            <tr><td colspan="2" class="formheader">Hormonal Birth Control Use</td></tr>
            <tr class="prop clearborder">
                <td valign="top" class="name">
                    <label for="hormBirthControl">${labelNumber++}. Has the Participant ever used hormonally based birth control?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'hormBirthControl', 'errors')}" >
                    <div>
                        <g:radio name="hormBirthControl" id="hbcStat1" value="Current user" checked="${clinicalDataEntryInstance?.hormBirthControl == 'Current user'}" />&nbsp;<label for="hbcStat1">Current user</label><br/>
                        <g:radio name="hormBirthControl" id="hbcStat2" value="Former user" checked="${clinicalDataEntryInstance?.hormBirthControl == 'Former user'}" />&nbsp;<label for="hbcStat2">Former user</label><br/>
                        <g:radio name="hormBirthControl" id="hbcStat3" value="Never used" checked="${clinicalDataEntryInstance?.hormBirthControl == 'Never used'}" />&nbsp;<label for="hbcStat3">Never used</label><br/>
                        <g:radio name="hormBirthControl" id="hbcStat4" value="Unknown" checked="${clinicalDataEntryInstance?.hormBirthControl == 'Unknown'}" />&nbsp;<label for="hbcStat4">Unknown</label>
                    </div>  
                </td>
            </tr>

            <tr class="prop clearborder subentry" id="HBCTable" style="display:${clinicalDataEntryInstance?.hormBirthControl == 'Current user' || clinicalDataEntryInstance?.hormBirthControl == 'Former user' ?'display':'none'}" >
                <td colspan="2">
                    <g:render template="HBCTabContent"/>
                </td>
            </tr>

            <tr id="hbcSaveRow" class="subentry clearborder" style="display:${clinicalDataEntryInstance?.hormBirthControl == 'Current user' || clinicalDataEntryInstance?.hormBirthControl == 'Former user' ?'display':'none'}" >
                <td  colspan="2"><g:actionSubmit id="hbcSaveBtn" style="display:none" action="saveHormonalBC" value="Save" /><g:actionSubmit style="display:none" id="hbcCancelBtn" value="Cancel" /><g:actionSubmit class="Btn" id="hbcAddBtn" value="Add" /></td>
            </tr>                
            <tr class="prop" id="othFormHBCDescRow" style="display:${clinicalDataEntryInstance?.hormBirthControl == 'Current user' || clinicalDataEntryInstance?.hormBirthControl == 'Former user' ?'display':'none'}" >
                <td colspan="2" class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'othHorBC', 'errors')}">
                    <label for="othHorBC" class="subentry">General comment:</label><br />
                        <g:textArea name="othHorBC" class="textwide" cols="40" rows="5" maxlength="4000" value="${clinicalDataEntryInstance?.othHorBC}" />
                </td>
            </tr>
                

            <tr><td colspan="2" class="formheader">Hormone Replacement Therapy Use</td></tr>
            <tr class="prop clearborder">
                <td valign="top" class="name">
                    <label for="usedHorReplaceTher">${labelNumber++}. Has the Participant ever used Hormone replacement therapy?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'usedHorReplaceTher', 'errors')}">
                    <g:yesNoUnknownRadioPicker checked="${(clinicalDataEntryInstance?.usedHorReplaceTher)}"  name="usedHorReplaceTher" />
                </td>
            </tr>

            <tr class="prop clearborder subentry" id="HRTTable" style="display:${clinicalDataEntryInstance?.usedHorReplaceTher == 'Yes'?'display':'none'}" >
                <td colspan="2">
                    <g:render template="HRTTabContent"/>
                </td>
            </tr>

                
            <tr id="hrtSaveRow" class="subentry clearborder" style="display:${clinicalDataEntryInstance?.usedHorReplaceTher == 'Yes'?'display':'none'}" >
              <td colspan="2"><g:actionSubmit id="hrtSaveBtn" style="display:none" action="saveHormonalRT" value="Save" /><g:actionSubmit style="display:none" id="hrtCancelBtn" value="Cancel" /><g:actionSubmit class="Btn" id="hrtAddBtn" value="Add" /></td>
            </tr>  
            
            <tr class="prop" id="othFormHRTDescRow" style="display:${clinicalDataEntryInstance?.usedHorReplaceTher == 'Yes'?'display':'none'}" >
                <td colspan="2" class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'othHorRT', 'errors')}">
                    <label for="othHorRT" class="subentry">General Comment:</label><br />
                    <g:textArea class="textwide" name="othHorRT" cols="40" rows="5" maxlength="4000" value="${clinicalDataEntryInstance?.othHorRT}" />
                </td>
            </tr>
                
            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'menoStatus', 'errors')}">
                    <label for="menoStatus">${labelNumber++}. Indicate Participant's menopausal status:</label>
                    <div class="subentry value menoStatus">
                        <g:radio name="menoStatus" id="ms1" value="Less than 6 months since LMP AND no prior bilateral oophorectomy AND not on estrogen replacement" checked="${clinicalDataEntryInstance?.menoStatus == 'Less than 6 months since LMP AND no prior bilateral oophorectomy AND not on estrogen replacement'}" />&nbsp;<label for="ms1">Premenopausal: Less than 6 months since LMP AND no prior bilateral oophorectomy AND not on estrogen replacement</label><br>
                        <g:radio name="menoStatus" id="ms2" value="6-12 months since last menstrual period" checked="${clinicalDataEntryInstance?.menoStatus == '6-12 months since last menstrual period'}" />&nbsp;<label for="ms2">Perimenopausal: 6-12 months since last menstrual period</label><br>
                        <g:radio name="menoStatus" id="ms3" value="prior bilateral oophorectomy OR more than 12 months since LMP with no prior hysterectomy" checked="${clinicalDataEntryInstance?.menoStatus == 'prior bilateral oophorectomy OR more than 12 months since LMP with no prior hysterectomy'}" />&nbsp;<label for="ms3">Postmenopausal: prior bilateral oophorectomy OR more than 12 months since LMP with no prior hysterectomy</label><br>
                        <g:radio name="menoStatus" id="ms4" value="neither pre- nor post-menopausal" checked="${clinicalDataEntryInstance?.menoStatus == 'neither pre- nor post-menopausal'}" />&nbsp;<label for="ms4">Indeterminate: neither pre- nor post-menopausal</label>
                    </div>  
                </td>
            </tr>
        </g:if>
        <g:if test="${clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() != 'Ovary'&&
                      clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() !='Uterus'}">       

        <tr><td colspan="2" class="formheader">Clinical tumor stage group (AJCC 7th Edition)</td></tr>
        <g:if test="${tumorStageList}">
        <tr class="prop">
            <td valign="top" class="name">
                <label for="clinicalTumStgGrp">${labelNumber++}. Clinical tumor stage group (AJCC 7th Edition):</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'clinicalTumStgGrp', 'errors')}">
                    <g:select name="clinicalTumStgGrp" from="${tumorStageList}" value="${clinicalDataEntryInstance?.clinicalTumStgGrp}" noSelection="['': '']" />
               
            </td>
        </tr>
        </g:if>
        <g:else>
            <td cospan="2" class="name">${labelNumber++}. Tumor staging is not available for this tissue type: (${clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()}). Please check the appsettings table</td>
            </g:else>
        </g:if>
        <g:if test="${clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() == 'Ovary'||
                      clinicalDataEntryInstance.caseRecord.primaryTissueType.toString() =='Uterus'}">
            <tr><td colspan="2" class="formheader">Clinical FIGO Stage Or  Clinical tumor stage group (AJCC 7th Edition) </td></tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="clinicalFIGOStg">${labelNumber++}. Clinical FIGO stage:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'clinicalFIGOStg', 'errors')}">
                    <g:select name="clinicalFIGOStg" from="${tumorStageList}" value="${clinicalDataEntryInstance?.clinicalFIGOStg}" noSelection="['': '']" />
                </td>
            </tr>
            <tr><td>OR</td><td></td>
            </tr>
            <tr>
            <td valign="top" class="name">
                <label for="clinicalTumStgGrp"> Clinical tumor stage group (AJCC 7th Edition):</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'clinicalTumStgGrp', 'errors')}">
                    <g:select name="clinicalTumStgGrp" from="${ajccTumorStageList}" value="${clinicalDataEntryInstance?.clinicalTumStgGrp}" noSelection="['': '']" />
                </td>
            </tr>
        </g:if>
                
        <tr><td colspan="2" class="formheader">Record Karnofsky Score OR Eastern Cancer Oncology (ECOG) Score</td></tr>
        <tr class="prop clearborder">
            <td colspan="2" class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'perfStatusScale', 'errors')}">
                <label for="perfStatusScale">${labelNumber++}. Performance Status Scale recorded:</label>
                <div class="subentry value perfStatusScale">
                    <g:radio name="perfStatusScale" id="karnofsky60" value="Karnofsky Score" checked="${clinicalDataEntryInstance?.perfStatusScale == 'Karnofsky Score'}" />&nbsp;<label for="karnofsky">Karnofsky Score</label><br>
                    <g:radio name="perfStatusScale" id="ecog60" value="Eastern Cancer Oncology Group" checked="${clinicalDataEntryInstance?.perfStatusScale == 'Eastern Cancer Oncology Group'}" />&nbsp;<label for="ecog">Eastern Cancer Oncology Group</label><br>
                    <g:radio name="perfStatusScale" id="notRecorded60" value="Not Recorded" checked="${clinicalDataEntryInstance?.perfStatusScale == 'Not Recorded'}"/>&nbsp;<label for="notRecorded">Not recorded</label><br>
                </div>   
            </td>
        </tr>

        <tr class="prop" id="karnofskyRow" style="display:${clinicalDataEntryInstance?.perfStatusScale == 'Karnofsky Score'?'display':'none'}" >
            <td class="name subentry ${hasErrors(bean: clinicalDataEntryInstance, field: 'karnofskyScore', 'errors')}" colspan="2">
                <label for="karnofskyScore" class="subentry">Karnofsky Score:</label>
                <div class="subentry value karnofskyScore">
                    <g:radio name="karnofskyScore" id="asym100" value="asymptomatic" checked="${clinicalDataEntryInstance?.karnofskyScore == 'asymptomatic'}" />&nbsp;<label for="asym100">100: asymptomatic</label><br>
                    <g:radio name="karnofskyScore" id="symp8090" value="symptomatic but fully ambulatory" checked="${clinicalDataEntryInstance?.karnofskyScore == 'symptomatic but fully ambulatory'}" />&nbsp;<label for="symp8090">80-90: symptomatic but fully ambulatory</label><br>
                    <g:radio name="karnofskyScore" id="symp6070" value="symptomatic but in bed less than 50% of the day" checked="${clinicalDataEntryInstance?.karnofskyScore == 'symptomatic but in bed less than 50% of the day'}" />&nbsp;<label for="symp6070">60-70: symptomatic but in bed less than 50% of the day</label><br>
                    <g:radio name="karnofskyScore" id="symp4050" value="symptomatic, in bed more than 50% of the day, but not bed ridden" checked="${clinicalDataEntryInstance?.karnofskyScore == 'symptomatic, in bed more than 50% of the day, but not bed ridden'}" />&nbsp;<label for="symp4050">40-50: symptomatic, in bed more than 50% of the day, but not bed ridden</label><br>
                    <g:radio name="karnofskyScore" id="bedridden2030" value="bed ridden" checked="${clinicalDataEntryInstance?.karnofskyScore == 'bed ridden'}" />&nbsp;<label for="bedridden2030">20-30: bed ridden</label>
                </div>   
            </td>
        </tr>

        <tr class="prop" id="ecogRow" style="display:${clinicalDataEntryInstance?.perfStatusScale == 'Eastern Cancer Oncology Group'?'display':'none'}" >
            <td class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'ecogStatus', 'errors')}" colspan="2">
                <label for="ecogStatus" class="subentry">ECOG Functional Performance Status</label>
                <div class="subentry value ecogStatus">
                    <g:radio name="ecogStatus" id="asym" value="asymptomatic" checked="${clinicalDataEntryInstance?.ecogStatus == 'asymptomatic'}" />&nbsp;<label for="asym">0: asymptomatic</label><br>
                    <g:radio name="ecogStatus" id="symp1" value="symptomatic but fully ambulatory" checked="${clinicalDataEntryInstance?.ecogStatus == 'symptomatic but fully ambulatory'}" />&nbsp;<label for="symp1">1: symptomatic but fully ambulatory</label><br>
                    <g:radio name="ecogStatus" id="symp2" value="symptomatic but in bed less than 50% of the day" checked="${clinicalDataEntryInstance?.ecogStatus == 'symptomatic but in bed less than 50% of the day'}" />&nbsp;<label for="symp2">2: symptomatic but in bed less than 50% of the day</label><br>
                    <g:radio name="ecogStatus" id="symp3" value="symptomatic, in bed more than 50% of the day, but not bed ridden" checked="${clinicalDataEntryInstance?.ecogStatus == 'symptomatic, in bed more than 50% of the day, but not bed ridden'}" />&nbsp;<label for="symp3">3: symptomatic, in bed more than 50% of the day, but not bed ridden</label><br>
                    <g:radio name="ecogStatus" id="bedridden4" value="bed ridden" checked="${clinicalDataEntryInstance?.ecogStatus == 'bed ridden'}" />&nbsp;<label for="bedridden4">4: bed ridden</label>
                </div>  
            </td>
        </tr>

        <tr class="prop ${(versionValue >= 6.0) ? '' :'clearborder'}" id="timingOfScoreTR" style="display:${  (!clinicalDataEntryInstance?.perfStatusScale)||(clinicalDataEntryInstance?.perfStatusScale.trim().equals(''))||(clinicalDataEntryInstance?.perfStatusScale == 'Not Recorded') ? 'none' : 'display' }" >
            <td class="name ${hasErrors(bean: clinicalDataEntryInstance, field: 'timingOfScore', 'errors')}" colspan="2">
                <label for="timingOfScore">${labelNumber++}. Timing of score:</label>
                <div class="subentry value timingOfScore">
                    <g:radio name="timingOfScore" id="Preoperative" value="Preoperative" checked="${clinicalDataEntryInstance?.timingOfScore == 'Preoperative'}" />&nbsp;<label for="Preoperative">Preoperative</label><br>
                    <g:radio name="timingOfScore" id="Preadjuvant" value="Pre-adjuvant therapy" checked="${clinicalDataEntryInstance?.timingOfScore == 'Pre-adjuvant therapy'}" />&nbsp;<label for="Preadjuvant">Pre-adjuvant therapy</label><br>
                    <g:radio name="timingOfScore" id="Postadjuvant" value="Post adjuvant therapy" checked="${clinicalDataEntryInstance?.timingOfScore == 'Post adjuvant therapy'}" />&nbsp;<label for="Postadjuvant">Post adjuvant therapy</label><br>
                    <g:radio name="timingOfScore" id="tosUnknown" value="Unknown" checked="${clinicalDataEntryInstance?.timingOfScore == 'Unknown'}" />&nbsp;<label for="tosUnknown">Unknown</label><br>
                    <g:radio name="timingOfScore" id="othTimScore" value="Other, Specify" checked="${clinicalDataEntryInstance?.timingOfScore == 'Other, Specify'}" />&nbsp;<label for="othTimScore">Other, Specify</label>
                </div>  
            </td>
        </tr>

        <tr class="subentry prop" id="timingOfScoreOsRow" style="display:${clinicalDataEntryInstance?.timingOfScore == 'Other, Specify'?((!clinicalDataEntryInstance?.perfStatusScale)||(clinicalDataEntryInstance?.perfStatusScale == 'Not Recorded')||(clinicalDataEntryInstance?.perfStatusScale.trim().equals(''))?'none':'display'):'none'}">
            <td colspan="2" class="value ${hasErrors(bean: clinicalDataEntryInstance, field: 'timingOfScoreOs', 'errors')}">
                <g:textField name="timingOfScoreOs" id="timingOfScoreOs" maxlength="255" value="${clinicalDataEntryInstance?.timingOfScoreOs}" />
            </td>
        </tr>               

        <tr class="prop">
            <td valign="top" colspan="2" class="name${hasErrors(bean: clinicalDataEntryInstance, field: 'comments', 'errors')}">
                <label for="comments">${labelNumber++}. Comments:</label>
                <br/>
                <g:textArea  class="textwide" name="comments" name="comments" cols="40" rows="5" maxlength="4000" value="${clinicalDataEntryInstance?.comments}"/>
            </td>
        </tr>

        </tbody>
    </table>
</div>  
