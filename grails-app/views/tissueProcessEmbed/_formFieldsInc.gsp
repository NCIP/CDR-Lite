%{-- <%@ page import="nci.bbrb.cdr.staticmembers.SOP" %> --}%

<script type="text/javascript">
    $(document).ready(function() {
        $("#tissProcessorMdl_LPRTP").click(function() {
            if(this.checked) {
                $("#othTissProcessorMdl").val('')
                $("#othTissProcessorMdlRow").hide()
            }
        });

        $("#tissProcessorMdl_Other").click(function() {
            if(this.checked) {
                $("#othTissProcessorMdlRow").show()
            }
        });

        $("#procMaintenance_Yes").click(function() {
            if(this.checked) {
                $("#othProcMaintenance").val('')
                $("#othProcMaintenanceRow").hide()
            }
        });

        $("#procMaintenance_No").click(function() {
            if(this.checked) {
                $("#othProcMaintenanceRow").show()
            }
        });

        $("#alcoholType_AE").click(function() {
            if(this.checked) {
                $("#othAlcoholType").val('')
                $("#othAlcoholTypeRow").hide()
            }
        });

        $("#alcoholType_Other").click(function() {
            if(this.checked) {
                $("#othAlcoholTypeRow").show()
            }
        });

        $("#clearingAgt_Xylene").click(function() {
            if(this.checked) {
                $("#othClearingAgt").val('')
                $("#othClearingAgtRow").hide()
            }
        })

        $("#clearingAgt_Other").click(function() {
            if(this.checked) {
                $("#othClearingAgtRow").show()
            }
        });

        $("#alcoholStgDur_Yes").click(function() {
            if(this.checked) {
                $("#othAlcoholStgDur").val('')
                $("#othAlcoholStgDurRow").hide()
            }
        })

        $("#alcoholStgDur_No").click(function() {
            if(this.checked) {
                $("#othAlcoholStgDurRow").show()
            }
        });

        $("#dehydrationProcDur_Yes").click(function() {
            if(this.checked) {
                $("#othDehydrationProcDur").val('')
                $("#othDehydrationProcDurRow").hide()
            }
        })

        $("#dehydrationProcDur_No").click(function() {
            if(this.checked) {
                $("#othDehydrationProcDurRow").show()
            }
        });

        $("#temperatureDehyd_Yes").click(function() {
            if(this.checked) {
                $("#othTemperatureDehyd").val('')
                $("#othTemperatureDehydRow").hide()
            }
        })

        $("#temperatureDehyd_No").click(function() {
            if(this.checked) {
                $("#othTemperatureDehydRow").show()
            }
        });

        $("#numStages_Yes").click(function() {
            if(this.checked) {
                $("#othNumStages").val('')
                $("#othNumStagesRow").hide()
            }
        })

        $("#numStages_No").click(function() {
            if(this.checked) {
                $("#othNumStagesRow").show()
            }
        });

        $("#clearingAgtDur_Yes").click(function() {
            if(this.checked) {
                $("#othClearingAgtDur").val('')
                $("#othClearingAgtDurRow").hide()
            }
        })

        $("#clearingAgtDur_No").click(function() {
            if(this.checked) {
                $("#othClearingAgtDurRow").show()
            }
        });

        $("#temperatureClearingAgt_Yes").click(function() {
            if(this.checked) {
                $("#othTemperatureClearingAgt").val('')
                $("#othTemperatureClearingAgtRow").hide()
            }
        })

        $("#temperatureClearingAgt_No").click(function() {
            if(this.checked) {
                $("#othTemperatureClearingAgtRow").show()
            }
        });

        $("#paraffImpreg_Yes").click(function() {
            if(this.checked) {
                $("#othParaffImpreg").val('')
                $("#othParaffImpregRow").hide()
            }
        })

        $("#paraffImpreg_No").click(function() {
            if(this.checked) {
                $("#othParaffImpregRow").show()
            }
        });

        $("#tempParaffinProc_Yes").click(function() {
            if(this.checked) {
                $("#othTempParaffinProc").val('')
                $("#othTempParaffinProcRow").hide()
            }
        })

        $("#tempParaffinProc_No").click(function() {
            if(this.checked) {
                $("#othTempParaffinProcRow").show()
            }
        });

        $("#paraffinManufacturer_Fisher").click(function() {
            if(this.checked) {
                $("#otherParaffinManufacturer").val('')
                $("#otherParaffinManufacturerRow").hide()
            }
        })

        $("#paraffinManufacturer_Other").click(function() {
            if(this.checked) {
                $("#otherParaffinManufacturerRow").show()
            }
        });

        $("#paraffinUsage_FW").click(function() {
            if(this.checked) {
                $("#otherParaffinUsage").val('')
                $("#otherParaffinUsageRow").hide()
            }
        })

        $("#paraffinUsage_Other").click(function() {
            if(this.checked) {
                $("#otherParaffinUsageRow").show()
            }
        });

        $("#storedFfpeBlocksPerSop_Yes").click(function() {
            if(this.checked) {
                $("#othStoredFfpeBlocksPerSop").val('')
                $("#othStoredFfpeBlocksPerSopRow").hide()
            }
        })

        $("#storedFfpeBlocksPerSop_No").click(function() {
            if(this.checked) {
                $("#othStoredFfpeBlocksPerSopRow").show()
            }
        });
    });
</script>

%{-- <g:render template="/formMetadata/timeConstraint" bean="${tissueProcessEmbedInstance.formMetadata}" var="formMetadata"/> --}%
<g:render template="/caseRecord/caseDetails" bean="${tissueProcessEmbedInstance.caseRecord}" var="caseRecord"/>
<g:set var="labelNumber" value="${1}"/>

<div class="list">
    <table>
        <tbody>
          %{--<tr class="prop">
                <td valign="top" class="name">
                    <label for="expKeyBarcodeId">${labelNumber++}. Experimental Key Barcode ID:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'expKeyBarcodeId', 'errors')}">
                    <g:textField name="expKeyBarcodeId" value="${tissueProcessEmbedInstance?.expKeyBarcodeId}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="parentBarcodeId">${labelNumber++}. Parent Tissue Specimen ID:</label>
                </td>
                <td valign="top" class="value}">
                  
                  <%-- Auto populated manaully or read.  This is to match the gross/module specimen created later on the FFPE worksheet main.--%>                  
                  
                  <g:if test="${tissueProcessEmbedInstance.caseRecord.bpvWorkSheet?.parentSampleId}">
                      ${tissueProcessEmbedInstance.caseRecord.bpvWorkSheet.parentSampleId}
                  </g:if>
                  <g:else>
                    ${tissueProcessEmbedInstance.caseRecord.caseId}-00
                  </g:else>
                </td>
            </tr>
            --}%
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="processingSop">${labelNumber++}. SOP governing processing of formalin-fixed Tissue:</label>
                </td>
                <td valign="top" class="value">
                    %{-- 
                    <g:if test="${params.action == 'create'}">
                        ${tissueProcessEmbedInstance?.formMetadata?.sops?.get(0)?.sopNumber}
                        ${tissueProcessEmbedInstance?.formMetadata?.sops?.get(0)?.sopName}  
                        ${tissueProcessEmbedInstance?.formMetadata?.sops?.get(0)?.activeSopVer}
                    </g:if>
                    <g:else>
                        ${tissueProcessEmbedInstance?.processingSOP?.sopNumber}
                        ${SOP.get(tissueProcessEmbedInstance?.processingSOP?.sopId)?.sopName}  
                        ${tissueProcessEmbedInstance?.processingSOP?.sopVersion}
                    </g:else>
                    --}%
                    <g:textField name="processingSOP" value="${tissueProcessEmbedInstance?.processingSOP}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tissProcessorMdl">${labelNumber++}. Make and model of tissue processor:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'tissProcessorMdl', 'errors')}">
                    <div>
                        <g:radio name="tissProcessorMdl" id="tissProcessorMdl_LPRTP" value="Leica Peloris Rapid Tissue Processor" checked="${tissueProcessEmbedInstance?.tissProcessorMdl == 'Leica Peloris Rapid Tissue Processor'}"/>
                        &nbsp;<label for="tissProcessorMdl_LPRTP">Leica Peloris Rapid Tissue Processor</label>
                        <br/>
                        <g:radio name="tissProcessorMdl" id="tissProcessorMdl_Other" value="Other, Specify" checked="${tissueProcessEmbedInstance?.tissProcessorMdl == 'Other, Specify'}"/>
                        &nbsp;<label for="tissProcessorMdl_Other">Other, Specify</label><br>
                        <span id="othTissProcessorMdlRow" style="display:${tissueProcessEmbedInstance?.tissProcessorMdl == 'Other, Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othTissProcessorMdl', 'errors')}">
                           <g:textField name="othTissProcessorMdl" value="${tissueProcessEmbedInstance?.othTissProcessorMdl}"/> 
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="procMaintenance">${labelNumber++}. Was processor maintenance provided as per the manufacturer recommendation:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'procMaintenance', 'errors')}">
                    <div>
                        <g:radio name="procMaintenance" id="procMaintenance_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.procMaintenance == 'Yes'}"/>
                        &nbsp;<label for="procMaintenance_Yes">Yes</label>
                        <br/>
                        <g:radio name="procMaintenance" id="procMaintenance_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.procMaintenance == 'No - Specify'}"/>
                        &nbsp;<label for="procMaintenance_No">No - Specify</label><br>
                        <span id="othProcMaintenanceRow" style="display:${tissueProcessEmbedInstance?.procMaintenance == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othProcMaintenance', 'errors')}">
                            <g:textField name="othProcMaintenance" value="${tissueProcessEmbedInstance?.othProcMaintenance}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="alcoholType">${labelNumber++}. Type of alcohol:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'alcoholType', 'errors')}">
                    <div>
                        <g:radio name="alcoholType" id="alcoholType_AE" value="Absolute Ethanol" checked="${tissueProcessEmbedInstance?.alcoholType == 'Absolute Ethanol'}"/>
                        &nbsp;<label for="alcoholType_AE">Absolute Ethanol (100%)</label>
                        <br/>
                        <g:radio name="alcoholType" id="alcoholType_Other" value="Other, Specify" checked="${tissueProcessEmbedInstance?.alcoholType == 'Other, Specify'}"/>
                        &nbsp;<label for="alcoholType_Other">Other, Specify</label><br>
                        <span id="othAlcoholTypeRow" style="display:${tissueProcessEmbedInstance?.alcoholType == 'Other, Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othAlcoholType', 'errors')}">
                            <g:textField name="othAlcoholType" value="${tissueProcessEmbedInstance?.othAlcoholType}"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="clearingAgt">${labelNumber++}. Type of clearing agent:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'clearingAgt', 'errors')}">
                    <div>
                        <g:radio name="clearingAgt" id="clearingAgt_Xylene" value="Xylene" checked="${tissueProcessEmbedInstance?.clearingAgt == 'Xylene'}"/>
                        &nbsp;<label for="clearingAgt_Xylene">Xylene</label>
                        <br/>
                        <g:radio name="clearingAgt" id="clearingAgt_Other" value="Other, Specify" checked="${tissueProcessEmbedInstance?.clearingAgt == 'Other, Specify'}"/>
                        &nbsp;<label for="clearingAgt_Other">Other, Specify</label><br>
                        <span id="othClearingAgtRow" style="display:${tissueProcessEmbedInstance?.clearingAgt == 'Other, Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othClearingAgt', 'errors')}">
                            <g:textField name="othClearingAgt" value="${tissueProcessEmbedInstance?.othClearingAgt}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr><td colspan="2" class="formheader">Were the following done as per the formalin-fixed tissue processing SOP?</td></tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="alcoholStgDur">${labelNumber++}. Alcohol stage duration:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'alcoholStgDur', 'errors')}">
                    <div>
                        <g:radio name="alcoholStgDur" id="alcoholStgDur_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.alcoholStgDur == 'Yes'}"/>
                        &nbsp;<label for="alcoholStgDur_Yes">Yes</label>
                        <br/>
                        <g:radio name="alcoholStgDur" id="alcoholStgDur_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.alcoholStgDur == 'No - Specify'}"/>
                        &nbsp;<label for="alcoholStgDur_No">No - Specify</label><br>
                        <span id="othAlcoholStgDurRow" style="display:${tissueProcessEmbedInstance?.alcoholStgDur == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othAlcoholStgDur', 'errors')}">
                            <g:textField name="othAlcoholStgDur" value="${tissueProcessEmbedInstance?.othAlcoholStgDur}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="dehydrationProcDur">${labelNumber++}. Duration of dehydration process:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'dehydrationProcDur', 'errors')}">
                    <div>
                        <g:radio name="dehydrationProcDur" id="dehydrationProcDur_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.dehydrationProcDur == 'Yes'}"/>
                        &nbsp;<label for="dehydrationProcDur_Yes">Yes</label>
                        <br/>
                        <g:radio name="dehydrationProcDur" id="dehydrationProcDur_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.dehydrationProcDur == 'No - Specify'}"/>
                        &nbsp;<label for="dehydrationProcDur_No">No - Specify</label><br>
                        <span id="othDehydrationProcDurRow" style="display:${tissueProcessEmbedInstance?.dehydrationProcDur == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othDehydrationProcDur', 'errors')}">
                            <g:textField name="othDehydrationProcDur" value="${tissueProcessEmbedInstance?.othDehydrationProcDur}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="temperatureDehyd">${labelNumber++}. Temperature of dehydration:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'temperatureDehyd', 'errors')}">
                    <div>
                        <g:radio name="temperatureDehyd" id="temperatureDehyd_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.temperatureDehyd == 'Yes'}"/>
                        &nbsp;<label for="temperatureDehyd_Yes">Yes</label>
                        <br/>
                        <g:radio name="temperatureDehyd" id="temperatureDehyd_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.temperatureDehyd == 'No - Specify'}"/>
                        &nbsp;<label for="temperatureDehyd_No">No - Specify</label><br>
                        <span id="othTemperatureDehydRow" style="display:${tissueProcessEmbedInstance?.temperatureDehyd == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othTemperatureDehyd', 'errors')}">
                            <g:textField name="othTemperatureDehyd" value="${tissueProcessEmbedInstance?.othTemperatureDehyd}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="numStages">${labelNumber++}. Number of stages/replicates:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'numStages', 'errors')}">
                    <div>
                        <g:radio name="numStages" id="numStages_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.numStages == 'Yes'}"/>
                        &nbsp;<label for="numStages_Yes">Yes</label>
                        <br/>
                        <g:radio name="numStages" id="numStages_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.numStages == 'No - Specify'}"/>
                        &nbsp;<label for="numStages_No">No - Specify</label><br>
                        <span id="othNumStagesRow" style="display:${tissueProcessEmbedInstance?.numStages == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othNumStages', 'errors')}">
                            <g:textField name="othNumStages" value="${tissueProcessEmbedInstance?.othNumStages}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="clearingAgtDur">${labelNumber++}. Duration in clearing agent:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'clearingAgtDur', 'errors')}">
                    <div>
                        <g:radio name="clearingAgtDur" id="clearingAgtDur_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.clearingAgtDur == 'Yes'}"/>
                        &nbsp;<label for="clearingAgtDur_Yes">Yes</label>
                        <br/>
                        <g:radio name="clearingAgtDur" id="clearingAgtDur_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.clearingAgtDur == 'No - Specify'}"/>
                        &nbsp;<label for="clearingAgtDur_No">No - Specify</label><br>
                        <span id="othClearingAgtDurRow" style="display:${tissueProcessEmbedInstance?.clearingAgtDur == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othClearingAgtDur', 'errors')}">
                            <g:textField name="othClearingAgtDur" value="${tissueProcessEmbedInstance?.othClearingAgtDur}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="temperatureClearingAgt">${labelNumber++}. Temperature of clearing agent:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'temperatureClearingAgt', 'errors')}">
                    <div>
                        <g:radio name="temperatureClearingAgt" id="temperatureClearingAgt_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.temperatureClearingAgt == 'Yes'}"/>
                        &nbsp;<label for="temperatureClearingAgt_Yes">Yes</label>
                        <br/>
                        <g:radio name="temperatureClearingAgt" id="temperatureClearingAgt_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.temperatureClearingAgt == 'No - Specify'}"/>
                        &nbsp;<label for="temperatureClearingAgt_No">No - Specify</label><br>
                        <span id="othTemperatureClearingAgtRow" style="display:${tissueProcessEmbedInstance?.temperatureClearingAgt == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othTemperatureClearingAgt', 'errors')}">
                            <g:textField name="othTemperatureClearingAgt" value="${tissueProcessEmbedInstance?.othTemperatureClearingAgt}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="paraffImpreg">${labelNumber++}. Paraffin impregnation method:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'paraffImpreg', 'errors')}">
                    <div>
                        <g:radio name="paraffImpreg" id="paraffImpreg_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.paraffImpreg == 'Yes'}"/>
                        &nbsp;<label for="paraffImpreg_Yes">Yes</label>
                        <br/>
                        <g:radio name="paraffImpreg" id="paraffImpreg_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.paraffImpreg == 'No - Specify'}"/>
                        &nbsp;<label for="paraffImpreg_No">No - Specify</label><br>
                        <span id="othParaffImpregRow" style="display:${tissueProcessEmbedInstance?.paraffImpreg == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othParaffImpreg', 'errors')}">
                            <g:textField name="othParaffImpreg" value="${tissueProcessEmbedInstance?.othParaffImpreg}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tempParaffinProc">${labelNumber++}. Temperature of paraffin:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'tempParaffinProc', 'errors')}">
                    <div>
                        <g:radio name="tempParaffinProc" id="tempParaffinProc_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.tempParaffinProc == 'Yes'}"/>
                        &nbsp;<label for="tempParaffinProc_Yes">Yes</label>
                        <br/>
                        <g:radio name="tempParaffinProc" id="tempParaffinProc_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.tempParaffinProc == 'No - Specify'}"/>
                        &nbsp;<label for="tempParaffinProc_No">No - Specify</label><br>
                        <span id="othTempParaffinProcRow" style="display:${tissueProcessEmbedInstance?.tempParaffinProc == 'No - Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othTempParaffinProc', 'errors')}">
                            <g:textField name="othTempParaffinProc" value="${tissueProcessEmbedInstance?.othTempParaffinProc}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: tissueProcessEmbedInstance, field: 'addtlCommtsProc', 'errors')}">
                    <label for="addtlCommtsProc">${labelNumber++}. Provide any comments related to processing of formalin-fixed tissues:</label><br />
                    <g:textArea class="textwide" name="addtlCommtsProc" cols="40" rows="5" value="${tissueProcessEmbedInstance?.addtlCommtsProc}"/>
                </td>
            </tr>
            <tr><td colspan="2" class="formheader">Embedding</td></tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="embeddingSop">${labelNumber++}. SOP governing embedding of tissue:</label>
                </td>
                <td valign="top" class="value">
                    %{--
                    <g:if test="${params.action == 'create'}">
                        ${tissueProcessEmbedInstance?.formMetadata?.sops?.get(1)?.sopNumber}
                        ${tissueProcessEmbedInstance?.formMetadata?.sops?.get(1)?.sopName}  
                        ${tissueProcessEmbedInstance?.formMetadata?.sops?.get(1)?.activeSopVer}
                    </g:if>
                    <g:else>
                        ${tissueProcessEmbedInstance?.embeddingSOP?.sopNumber}
                        ${SOP.get(tissueProcessEmbedInstance?.embeddingSOP?.sopId)?.sopName}  
                        ${tissueProcessEmbedInstance?.embeddingSOP?.sopVersion}
                    </g:else>
                    --}%
                    <g:textField name="embeddingSOP" value="${tissueProcessEmbedInstance?.embeddingSOP}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="typeParaffin">${labelNumber++}. Type of paraffin:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'typeParaffin', 'errors')}">
                    <g:textField name="typeParaffin" value="${tissueProcessEmbedInstance?.typeParaffin}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="paraffinManufacturer">${labelNumber++}. Manufacturer of paraffin:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'paraffinManufacturer', 'errors')}">
                    <div>
                        <g:radio name="paraffinManufacturer" id="paraffinManufacturer_Fisher" value="Fisher" checked="${tissueProcessEmbedInstance?.paraffinManufacturer == 'Fisher'}"/>
                        &nbsp;<label for="paraffinManufacturer_Fisher">Fisher</label>
                        <br/>
                        <g:radio name="paraffinManufacturer" id="paraffinManufacturer_Other" value="Other, Specify" checked="${tissueProcessEmbedInstance?.paraffinManufacturer == 'Other, Specify'}"/>
                        &nbsp;<label for="paraffinManufacturer_Other">Other, Specify</label><br>
                        <span id="otherParaffinManufacturerRow" style="display:${tissueProcessEmbedInstance?.paraffinManufacturer == 'Other, Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'otherParaffinManufacturer', 'errors')}">
                            <g:textField name="otherParaffinManufacturer" value="${tissueProcessEmbedInstance?.otherParaffinManufacturer}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="paraffinProductNum">${labelNumber++}. Paraffin product #:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'paraffinProductNum', 'errors')}">
                    <g:textField name="paraffinProductNum" value="${tissueProcessEmbedInstance?.paraffinProductNum}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="paraffinLotNum">${labelNumber++}. Paraffin lot #:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'paraffinLotNum', 'errors')}">
                    <g:textField name="paraffinLotNum" value="${tissueProcessEmbedInstance?.paraffinLotNum}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tempParaffinEmbed">${labelNumber++}. Temperature of paraffin dispensed for embedding:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'tempParaffinEmbed', 'errors')}">
                    <g:textField size="4" name="tempParaffinEmbed" value="${fieldValue(bean: tissueProcessEmbedInstance, field: 'tempParaffinEmbed')}" onkeyup="isNumericValidation(this)"/>&nbsp;&nbsp;
                    <g:select name="tempParaffinEmbedUnit" value="${tissueProcessEmbedInstance?.tempParaffinEmbedUnit}" keys="${['Fahrenheit']}" from="${['°F']}" noSelection="['Celsius':'°C']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="paraffinUsage">${labelNumber++}. Type of paraffin used in embedding:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'paraffinUsage', 'errors')}">
                    <div>
                        <g:radio name="paraffinUsage" id="paraffinUsage_FW" value="Fresh Paraffin" checked="${tissueProcessEmbedInstance?.paraffinUsage == 'Fresh Paraffin'}"/>
                        &nbsp;<label for="paraffinUsage_FW">Fresh Paraffin</label>
                        <br/>
                        <g:radio name="paraffinUsage" id="paraffinUsage_Other" value="Other, Specify" checked="${tissueProcessEmbedInstance?.paraffinUsage == 'Other, Specify'}"/>
                        &nbsp;<label for="paraffinUsage_Other">Other, Specify</label><br>
                        <span id="otherParaffinUsageRow" style="display:${tissueProcessEmbedInstance?.paraffinUsage == 'Other, Specify'?'display':'none'}" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'otherParaffinUsage', 'errors')}">
                            <g:textField name="otherParaffinUsage" value="${tissueProcessEmbedInstance?.otherParaffinUsage}"/>
                        </span>
                    </div>
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="waxAge">${labelNumber++}. Age of paraffin:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'waxAge', 'errors')}">
                    <g:textField name="waxAge" value="${tissueProcessEmbedInstance?.waxAge}" onkeyup="isNumericValidation(this)"/>&nbsp;day(s)
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="totalTimeBlocksCooled">${labelNumber++}. Total time the freshly poured blocks were cooled:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'totalTimeBlocksCooled', 'errors')}">
                    <g:textField name="totalTimeBlocksCooled" value="${tissueProcessEmbedInstance?.totalTimeBlocksCooled}" onkeyup="isNumericValidation(this)"/>&nbsp;minute(s)
                </td>
            </tr>
            <tr><td colspan="2" class="formheader">FFPE Block Storage</td></tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="handleTrackStoreSop">${labelNumber++}. SOP governing handling, tracking and storage of FFPE tissue block:</label>                   
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'siteSOPProcEmbed', 'errors')}">
                  <g:textField name="siteSOPProcEmbed" value="${tissueProcessEmbedInstance?.siteSOPProcEmbed}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="storedFfpeBlocksPerSop">${labelNumber++}. Were the FFPE blocks stored as per SOP:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tissueProcessEmbedInstance, field: 'storedFfpeBlocksPerSop', 'errors')}">
                    <div>
                        <g:radio name="storedFfpeBlocksPerSop" id="storedFfpeBlocksPerSop_Yes" value="Yes" checked="${tissueProcessEmbedInstance?.storedFfpeBlocksPerSop == 'Yes'}"/>
                        &nbsp;<label for="storedFfpeBlocksPerSop_Yes">Yes</label>
                        <br/>
                        <g:radio name="storedFfpeBlocksPerSop" id="storedFfpeBlocksPerSop_No" value="No - Specify" checked="${tissueProcessEmbedInstance?.storedFfpeBlocksPerSop == 'No - Specify'}"/>
                        &nbsp;<label for="storedFfpeBlocksPerSop_No">No - Specify</label>
                    </div>
                </td>
            </tr>
            <tr class="prop" id="othStoredFfpeBlocksPerSopRow" style="display:${tissueProcessEmbedInstance?.storedFfpeBlocksPerSop == 'No - Specify'?'display':'none'}">
                <td colspan="2" class="name ${hasErrors(bean: tissueProcessEmbedInstance, field: 'othStoredFfpeBlocksPerSop', 'errors')}">
                    
                    <g:textArea class="textwide" name="othStoredFfpeBlocksPerSop" cols="40" rows="5" value="${tissueProcessEmbedInstance?.othStoredFfpeBlocksPerSop}"/>
                </td>
            </tr>
            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: tissueProcessEmbedInstance, field: 'addtlCommentsEmbed', 'errors')}">
                    <label for="addtlCommentsEmbed">${labelNumber++}. Provide any additional comments related to paraffin embedding of formalin-fixed tissue:</label><br />
                    <g:textArea class="textwide" name="addtlCommentsEmbed" cols="40" rows="5" value="${tissueProcessEmbedInstance?.addtlCommentsEmbed}"/>
                </td>
            </tr>
        </tbody>
    </table>
</div>