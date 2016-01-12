

<g:set var="labelNumber" value="${1}"/>
<script type="text/javascript">
    $(document).ready(function() {


    $("#photoTaken_no").change(function() {
            if (${!tissueGrossEvaluationInstance.photos}) {
    $("#reasonNoPhotoRow").show()
    $("#photosRow").hide()
    } else {
        if (${tissueGrossEvaluationInstance.photos?.rmFlg == null || tissueGrossEvaluationInstance.photos?.rmFlg =='Y'}){
            alert('Please remove every uploaded photos and save the form')
            $("#photoTaken_yes").attr('checked', true)
        }
    }
    });


    });
</script>
<g:set var="cid" value="${tissueGrossEvaluationInstance?.caseRecord?.id ?: params.caseRecord?.id}" />

<g:render template="/caseRecord/caseDetails" bean="${tissueGrossEvaluationInstance.caseRecord}" var="caseRecord" />    

<div class="list">
    <table id ="tissuegrosseval" class="tdwrap">
        <tbody>

            <tr><td colspan="2" class="formheader">Receipt of Tissue in Pathology Gross Room</td></tr>


            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tissueReceived">Tissue received in Gross Room from OR?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'tissueReceived', 'errors')}">
                    <g:bpvYesNoRadioPicker name="tissueReceived" checked="${tissueGrossEvaluationInstance?.tissueReceived}" />
                </td>                
            </tr>    
            <tr id="tissueNotReceivedReasonTr" class="prop ${tissueGrossEvaluationInstance?.tissueReceived == 'No'?'':'hide'}" >
                <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'tissueNotReceivedReason', 'errors')}">
                    <label for="tissueNotReceivedReason">Explain why:</label><br />
                    <g:textArea class="textwide" name="tissueNotReceivedReason" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.tissueNotReceivedReason}" />
                </td>
            </tr>
        </tbody>     
        <tbody id="restOfTheForm" class="${tissueGrossEvaluationInstance?.tissueReceived == 'Yes' ?'':'hide'}">
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="dateTimeArrived">${labelNumber++}. Date and time Specimen arrived in pathology gross room from OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'dateTimeArrived', 'errors')}">
                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dateTimeArrived" value="${tissueGrossEvaluationInstance?.dateTimeArrived}" />
                </td>                
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="nameReceived">${labelNumber++}. Specimen was received in gross room by:</label>
                </td>
                <td valign="top" class=" value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'nameReceived', 'errors')}">
                    <g:textField name="nameReceived" value="${tissueGrossEvaluationInstance?.nameReceived}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="transport">${labelNumber++}. SOP governing transport of tissue from OR to pathology gross room:</label>
                </td>
                <td valign="top" class=" value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'transportSOP', 'errors')}">
                    <g:textField name="transportSOP" value="${tissueGrossEvaluationInstance?.transportSOP}" />


                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="transportPerformed">${labelNumber++}.
                        Transport of tissue was performed per Surgical Tissue Collection and Preservation SOP:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'transportPerformed', 'errors')}">
                    <g:bpvYesNoRadioPicker name="transportPerformed" checked="${tissueGrossEvaluationInstance?.transportPerformed}" />
                </td>
            </tr>

            <g:if test="${tissueGrossEvaluationInstance?.transportPerformed == 'No'}">
                <tr class="prop" id="transportCommentsRow" style="display:display">
                    <td valign="top" class="name">
                        <label for="transportComments">&nbsp;&nbsp;&nbsp;&nbsp;Tissue transport comments:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'transportComments', 'errors')}">
                        <g:textArea name="transportComments" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.transportComments}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop" id="transportCommentsRow" style="display:none">
                    <td valign="top" class="name">
                        <label for="transportComments">&nbsp;&nbsp;&nbsp;&nbsp;Tissue transport comments:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'transportComments', 'errors')}">
                        <g:textArea name="transportComments" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.transportComments}" />
                    </td>
                </tr>
            </g:else>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="roomTemperature">${labelNumber++}. Temperature of pathology gross room when specimen arrived from OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'roomTemperature', 'errors')}">
                    <g:textField class="numNegFloat" name="roomTemperature" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'roomTemperature')}" />&nbsp;&nbsp;
                    <g:select name="roomTemperatureUnit" value="${tissueGrossEvaluationInstance?.roomTemperatureUnit}" keys="${['Fahrenheit']}" from="${['°F']}" noSelection="['Celsius':'°C']"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="roomHumidity">${labelNumber++}. Humidity of pathology gross room when specimen arrived from OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'roomHumidity', 'errors')}">
                    <g:textField class="numFloat" name="roomHumidity" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'roomHumidity')}" /> %
                </td>
            </tr>

            <tr><td colspan="2" class="formheader">Gross Evaluation of Resected Tissue</td></tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="nameEvaluated">${labelNumber++}. Gross evaluation of resected tissue was performed by:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'nameEvaluated', 'errors')}">
                    <g:textField name="nameEvaluated" value="${tissueGrossEvaluationInstance?.nameEvaluated}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="resectionH">${labelNumber++}. Dimensions of resection:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="resectionH" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'resectionH')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'resectionH', 'errors')} numFloat" /> cm x
                    <g:textField name="resectionW" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'resectionW')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'resectionW', 'errors')} numFloat" /> cm x
                    <g:textField name="resectionD" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'resectionD')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'resectionD', 'errors')} numFloat" /> cm
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="resectionWeight">${labelNumber++}. Weight of resection:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'resectionWeight', 'errors')}">
                    <g:textField name="resectionWeight" class="numFloat" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'resectionWeight')}" /> Grams
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="diseaseObserved">${labelNumber++}. Gross appearance of disease was observed in resected tissue:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'diseaseObserved', 'errors')}">
                    <g:bpvYesNoRadioPicker name="diseaseObserved" checked="${tissueGrossEvaluationInstance?.diseaseObserved}" />
                </td>
            </tr>

            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'diseaseComments', 'errors')}">
                    <label for="diseaseComments">${labelNumber++}. Comments:</label><br />
                    <g:textArea class="textwide" name="diseaseComments" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.diseaseComments}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="diagnosis">${labelNumber++}. Gross diagnosis of resected tissue:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'diagnosis', 'errors')}">
                    <g:textField name="diagnosis" value="${tissueGrossEvaluationInstance?.diagnosis}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="photoTaken">${labelNumber++}. Photograph(s) of tissue was/were taken in pathology gross room?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'photoTaken', 'errors')}">
                    <g:bpvYesNoRadioPicker name="photoTaken" checked="${tissueGrossEvaluationInstance?.photoTaken}" />
                </td>
            </tr>

            <tr class="prop subentry" id="photosRow" style="display:${tissueGrossEvaluationInstance.photoTaken=='Yes'?'display':'none'}">
                <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'photos', 'errors')}">
                    <label for="photos">Tissue photographs:</label><br />
                    <g:render template="photoTable" bean="${tissueGrossEvaluationInstance}" var="tissueGrossEvaluationInstance" /> 
                    <g:if test="${params.action != 'create'}">
                        <div>
                            <g:link class="photoLink uibutton" controller="tissueGrossEvaluation" action="upload" id="${tissueGrossEvaluationInstance.id}" onclick="return confirm('Unsaved data will be lost. Are you sure to proceed?')">
                                <span class="ui-icon ui-icon-circle-arrow-n"></span>Upload
                            </g:link>
                        </div>
                    </g:if>
                    <g:else>
                        <span style="color:red">Form needs to be saved before photos can be uploaded</span>
                    </g:else>
                </td>
            </tr>

            <tr class="prop subentry" id="reasonNoPhotoRow" style="display:${tissueGrossEvaluationInstance?.photoTaken == 'No' ? 'display' : 'none'}">
                <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'reasonNoPhoto', 'errors')}">
                    <label for="reasonNoPhoto">Explain why:</label><br />
                    <g:textArea class="textwide" name="reasonNoPhoto" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.reasonNoPhoto}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="inkUsed">${labelNumber++}. Pathology ink used?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'inkUsed', 'errors')}">
                    <g:bpvYesNoRadioPicker name="inkUsed" checked="${tissueGrossEvaluationInstance?.inkUsed}" />
                </td>
            </tr>

            <g:if test="${tissueGrossEvaluationInstance?.inkUsed == 'Yes'}">
                <tr class="prop subentry" id="inkTypeRow" style="display:display">
                    <td valign="top" class="name">
                        <label for="inkType">Specify the type of ink:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'inkType', 'errors')}">
                        <g:textField name="inkType" value="${tissueGrossEvaluationInstance?.inkType}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop subentry" id="inkTypeRow" style="display:none">
                    <td valign="top" class="name">
                        <label for="inkType">Specify the type of ink:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'inkType', 'errors')}">
                        <g:textField name="inkType" value="${tissueGrossEvaluationInstance?.inkType}" />
                    </td>
                </tr>
            </g:else>

            <tr><td colspan="2" class="formheader">Gross Evaluation of Tumor Tissue</td></tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="excessReleased">${labelNumber++}. Tumor tissue was released to the tissue bank?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'excessReleased', 'errors')}">
                    <g:bpvYesNoRadioPicker name="excessReleased" checked="${tissueGrossEvaluationInstance?.excessReleased}" />
                </td>
            </tr>

            <g:if test="${tissueGrossEvaluationInstance?.excessReleased == 'No'}">
                <tr class="prop subentry" id="noReleaseReasonRow" style="display:display">
                    <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'noReleaseReason', 'errors')}">
                        <label for="noReleaseReason">Specify reason:</label><br />
                        <g:textArea class="textwide" class="textwide" name="noReleaseReason" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.noReleaseReason}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop subentry" id="noReleaseReasonRow" style="display:none">
                    <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'noReleaseReason', 'errors')}">
                        <label for="noReleaseReason">Specify reason:</label><br />
                        <g:textArea class="textwide" name="noReleaseReason" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.noReleaseReason}" />
                    </td>
                </tr>
            </g:else>

            <tr class="prop" id="tissueBankIdRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="tissueBankId">${labelNumber++}. Tissue Bank ID:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'tissueBankId', 'errors')} ${warningMap?.get('tissueBankId') ? 'warnings' : ''}">
                    <g:textField  name="tissueBankId"  value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'tissueBankId')}" /> 
                </td>
            </tr>

            <tr class="prop" id="excessHRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="excessH">${labelNumber++}. Dimensions of tissue:</label>
                </td>
                <td valign="top" class="value ${(warningMap?.get('excessH') || warningMap?.get('excessW') || warningMap?.get('excessD'))? 'warnings' : ''}"> 
                    <g:textField name="excessH" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'excessH')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'excessH', 'errors')} numFloat" onChange="displayWarningForNumberValue('excessH', '', '', 'Tissue Height')"/> cm x
                    <g:textField name="excessW" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'excessW')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'excessW', 'errors')} numFloat" onChange="displayWarningForNumberValue('excessW', '', '', 'Tissue Width')"/> cm x
                    <g:textField name="excessD" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'excessD')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'excessD', 'errors')} numFloat" onChange="displayWarningForNumberValue('excessD', '', '', 'Tissue Depth')"/> cm

                </td>

            </tr>

            <tr class="prop" id="areaPercentageRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="areaPercentage">${labelNumber++}. Percentage of gross area of necrosis of material sent to tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'areaPercentage', 'errors')} ${warningMap?.get('areaPercentage') ? 'warnings' : ''}">
                    <g:textField class="numFloat" name="areaPercentage" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'areaPercentage')}" onChange="displayWarningForNumberValue('areaPercentage', '', '20', 'Area Percentage')"/> %
                </td>
            </tr>

            <tr class="prop" id="contentPercentageRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="contentPercentage">${labelNumber++}. Percentage of tumor content of material sent to tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'contentPercentage', 'errors')} ${warningMap?.get('contentPercentage') ? 'warnings' : ''}">
                    <g:textField class="numFloat" name="contentPercentage" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'contentPercentage')}" onChange="displayWarningForNumberValue('contentPercentage', '50', '', 'Content Percentage')"/> %
                </td>
            </tr>

            <tr class="prop" id="appearanceRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="appearance">${labelNumber++}. Gross appearance of material sent to tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'appearance', 'errors')}">
                    <div>
                        <g:radio name="appearance" id="appearance1" value="Metastatic" checked="${tissueGrossEvaluationInstance?.appearance == 'Metastatic'}"/>&nbsp;<label for="appearance1">Metastatic</label><br/>
                        <g:radio name="appearance" id="appearance2" value="Tumor" checked="${tissueGrossEvaluationInstance?.appearance == 'Tumor'}"/>&nbsp;<label for="appearance2">Tumor</label><br/>
                        <g:radio name="appearance" id="appearance3" value="Tumor Center" checked="${tissueGrossEvaluationInstance?.appearance == 'Tumor Center'}"/>&nbsp;<label for="appearance3">Tumor Center</label><br/>
                        <g:radio name="appearance" id="appearance4" value="Tumor Edge" checked="${tissueGrossEvaluationInstance?.appearance == 'Tumor Edge'}"/>&nbsp;<label for="appearance4">Tumor Edge</label><br/>
                        <g:radio name="appearance" id="appearance5" class="hide" value="" checked="${tissueGrossEvaluationInstance?.appearance == ''}"/>
                    </div>
                </td>
            </tr>
<%--
            <tr class="prop" id="secTissueCollectRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="secTissueCollect">${labelNumber++}. Was a second piece of tumor tissue collected?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'secTissueCollect', 'errors')}">
                    <g:bpvYesNoRadioPicker name="secTissueCollect" checked="${tissueGrossEvaluationInstance?.secTissueCollect}" />
                </td>
            </tr>


            <tr class="prop" id="secTisHRow"  style="display:${tissueGrossEvaluationInstance?.secTissueCollect == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="secTisH">${labelNumber++}. Dimensions of second piece of tumor tissue (if applicable):</label>
                </td>
                <td valign="top" class="value ${(warningMap?.get('secTisH') || warningMap?.get('secTisW') || warningMap?.get('secTisD'))? 'warnings' : ''}"> 
                    <g:textField name="secTisH" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'secTisH')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'secTisH', 'errors')} numFloat" onChange="displayWarningForNumberValue('secTisH', '', '', 'Tissue Height')"/> cm x
                    <g:textField name="secTisW" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'secTisW')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'secTisW', 'errors')} numFloat" onChange="displayWarningForNumberValue('secTisW', '', '', 'Tissue Width')"/> cm x
                    <g:textField name="secTisD" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'secTisD')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'secTisD', 'errors')} numFloat" onChange="displayWarningForNumberValue('secTisD', '', '', 'Tissue Depth')"/> cm
                    <br><br><br>



                </td>

            </tr>


            <tr class="prop" id="stAreaPercentageRow" style="display:${tissueGrossEvaluationInstance?.secTissueCollect == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="stAreaPercentage">${labelNumber++}. Percentage of gross area of necrosis of second piece of tumor tissue  sent to tissue bank (if applicable):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'stAreaPercentage', 'errors')} ${warningMap?.get('stAreaPercentage') ? 'warnings' : ''}">
                    <g:textField class="numFloat" name="stAreaPercentage" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'stAreaPercentage')}" onChange="displayWarningForNumberValue('stAreaPercentage', '', '20', 'Second Tissue Area Percentage')"/> %
                </td>
            </tr>

            <tr class="prop" id="stContentPercentageRow" style="display:${tissueGrossEvaluationInstance?.secTissueCollect == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="stContentPercentage">${labelNumber++}. Percentage of tumor content of second piece of tumor tissue  sent to tissue bank (if applicable):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'stContentPercentage', 'errors')} ${warningMap?.get('stContentPercentage') ? 'warnings' : ''}">
                    <g:textField class="numFloat" name="stContentPercentage" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'stContentPercentage')}" onChange="displayWarningForNumberValue('stContentPercentage', '50', '', 'Second Tissue Content Percentage')"/> %
                </td>
            </tr>

            <tr class="prop" id="stAppearanceRow" style="display:${tissueGrossEvaluationInstance?.secTissueCollect == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="stAppearance">${labelNumber++}. Gross appearance of second piece of tumor tissue  sent to tissue bank (if applicable):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'stAppearance', 'errors')}">
                    <div>
                        <g:radio name="stAppearance" id="stappearance1" value="Metastatic" checked="${tissueGrossEvaluationInstance?.stAppearance == 'Metastatic'}"/>&nbsp;<label for="stappearance1">Metastatic</label><br/>
                        <g:radio name="stAppearance" id="stappearance2" value="Tumor" checked="${tissueGrossEvaluationInstance?.stAppearance == 'Tumor'}"/>&nbsp;<label for="stappearance2">Tumor</label><br/>
                        <g:radio name="stAppearance" id="stappearance3" value="Tumor Center" checked="${tissueGrossEvaluationInstance?.stAppearance == 'Tumor Center'}"/>&nbsp;<label for="stappearance3">Tumor Center</label><br/>
                        <g:radio name="stAppearance" id="stappearance4" value="Tumor Edge" checked="${tissueGrossEvaluationInstance?.stAppearance == 'Tumor Edge'}"/>&nbsp;<label for="stappearance4">Tumor Edge</label><br/>
                        <g:radio name="stAppearance" id="stappearance5" class="hide" value="" checked="${tissueGrossEvaluationInstance?.stAppearance == ''}"/>
                    </div>
                </td>
            </tr>
--%>
            <tr class="prop" id="dimenMeetCriteriaRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="dimenMeetCriteria">${labelNumber++}. Do the dimensions of each experimental piece meet the criteria specified within the BPS Surgical Tissue Collection and Preservation Procedure?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'dimenMeetCriteria', 'errors')}">
                    <g:bpvYesNoRadioPicker name="dimenMeetCriteria" checked="${tissueGrossEvaluationInstance?.dimenMeetCriteria}" />
                </td>
            </tr>



            <g:if test="${tissueGrossEvaluationInstance?.dimenMeetCriteria == 'No'}">
                <tr class="prop subentry" id="dimNoMeetCriteriaReason" style="display:display">
                    <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'dimNoMeetCriteriaReas', 'errors')}">
                        <label for="dimNoMeetCriteriaReas">Specify reason:</label><br />
                        <g:textArea class="textwide" class="textwide" name="dimNoMeetCriteriaReas" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.dimNoMeetCriteriaReas}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop subentry" id="dimNoMeetCriteriaReason" style="display:none">
                    <td colspan="2" class="name ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'dimNoMeetCriteriaReas', 'errors')}">
                        <label for="dimNoMeetCriteriaReas">Specify reason:</label><br />
                        <g:textArea class="textwide" name="dimNoMeetCriteriaReas" cols="40" rows="5" value="${tissueGrossEvaluationInstance?.dimNoMeetCriteriaReas}" />
                    </td>
                </tr>
            </g:else>




            <tr id="normalAdjHeaderRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td colspan="2" class="formheader">Normal Adjacent Tissue Information (if applicable)</td>
            </tr>

            <tr class="prop" id="normalAdjReleasedRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="normalAdjReleased">${labelNumber++}. Normal adjacent tissue was released to the tissue bank in addition to tumor tissue?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'normalAdjReleased', 'errors')}">
                    <g:bpvYesNoRadioPicker name="normalAdjReleased" checked="${tissueGrossEvaluationInstance?.normalAdjReleased}" />
                    <g:radio name="normalAdjReleased" id="normalAdjReleasedBlank" class="hide" value="" checked="${tissueGrossEvaluationInstance?.normalAdjReleased == ''}"/>
                </td>
            </tr>

            <tr class="prop" id="normalAdjHRow" style="display:${(tissueGrossEvaluationInstance?.excessReleased == 'Yes')&&(tissueGrossEvaluationInstance?.normalAdjReleased == 'Yes') ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="normalAdjH">${labelNumber++}. Dimensions of tissue:</label>
                </td>
                <td valign="top" class="value ${(warningMap?.get('normalAdjH') || warningMap?.get('normalAdjW') || warningMap?.get('normalAdjD'))? 'warnings' : ''}">
                    <g:textField name="normalAdjH" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'normalAdjH')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'normalAdjH', 'errors')} numFloat" onChange="displayWarningForNumberValue('normalAdjH', '1', '', 'Tissue Height')"/> cm x
                    <g:textField name="normalAdjW" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'normalAdjW')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'normalAdjW', 'errors')} numFloat" onChange="displayWarningForNumberValue('normalAdjW', '1', '', 'Tissue Width')"/> cm x
                    <g:textField name="normalAdjD" size="5" value="${fieldValue(bean: tissueGrossEvaluationInstance, field: 'normalAdjD')}" class="${hasErrors(bean: tissueGrossEvaluationInstance, field: 'normalAdjD', 'errors')} numFloat" onChange="displayWarningForNumberValue('normalAdjD', '1', '', 'Tissue Depth')"/> cm
                </td>
            </tr>

            <tr id="transferHeaderRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td colspan="2" class="formheader">Transfer of Tissue to Tissue Bank</td>
            </tr>

            <tr class="prop" id="timeTransferredRow" style="display:${tissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="timeTransferred">${labelNumber++}. Time specimen was transferred from the pathology gross room to the tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueGrossEvaluationInstance, field: 'timeTransferred', 'errors')}">
                    <g:textField name="timeTransferred" value="${tissueGrossEvaluationInstance?.timeTransferred}" class="timeEntry" />
                </td>
            </tr>

        </tbody>
    </table>
</div>

