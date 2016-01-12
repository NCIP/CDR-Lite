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
    });
</script>
<g:if test="${params.action != 'create' && params.action != 'save'}">
    <table>
        <tbody>
            <tr class="prop">
                <td valign="top">
                  <div class="clearfix">
                    <dl class="formdetails left"><dt>Date opened:</dt><dd><g:formatDate format="MM/dd/yyyy" date="${queryInstance?.dateCreated}" /></dd></dl>
                    <dl class="formdetails left"><dt>Query status:</dt><dd>${queryInstance?.queryStatus}</dd></dl>
                    <dl class="formdetails left"><dt>Query ID:</dt><dd>${queryInstance?.id}</dd></dl>
                    <g:if test="${queryInstance?.queryStatus?.code == 'CLOSED'}">
                        <dl class="formdetails left"><dt>Closed by:</dt><dd>${queryInstance?.closedBy}</dd></dl>
                        <dl class="formdetails left"><dt>Date closed:</dt><dd><g:formatDate format="MM/dd/yyyy" date="${queryInstance?.dateClosed}" /></dd></dl>
                    </g:if>
                    <g:if test="${queryInstance?.accessId}">
                        <dl class="formdetails left"><dt>Access ID:</dt><dd>${queryInstance?.accessId}</dd></dl>
                    </g:if>
                  </div>
                </td>
            </tr>      
        </tbody>
    </table>
</g:if>

<div class="list">
    <table class="tdwrap">
        <tbody>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="organization">Organization:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'organization', 'errors')}">
                    <g:select name="organization.id" from="${nci.bbrb.cdr.staticmembers.Organization.list()}" optionKey="id" value="${queryInstance?.organization?.id}" noSelection="['null': '']" />
                </td>
            </tr>
          
            <g:if test="${!params.caseRecord?.id && !params.candidateRecord?.id}">
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="association">Associated with:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:radio name="association" id="association_case" value="case" checked="${queryInstance?.caseRecord}"/>&nbsp;<label for="association_case">Case Record</label><br/>
                        <g:radio name="association" id="association_candidate" value="candidate" checked="${queryInstance?.candidateRecord}"/>&nbsp;<label for="association_candidate">Candidate Record</label><br/>
                        <g:radio name="association" id="association_other" value="other" checked="${queryInstance?.other}"/>&nbsp;<label for="association_other">Other</label>
                    </td>
                </tr>
            </g:if>
            
            <tr id="caseRow" class="prop ${queryInstance?.caseRecord ? '' : 'hide'}">
            %{-- <g:if test="${  --}%
                <td valign="top" class="name">
                    <label for="caseRecord">Case Record:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'caseRecord', 'errors')}">
                    <g:if test="${params.action == 'show'}">
                        <g:displayCaseRecordLink caseRecord="${queryInstance.caseRecord}" session="${session}"/>
                        %{-- <g:link controller="caseRecord" action="display" id="${queryInstance?.caseRecord?.id}">${queryInstance?.caseRecord?.caseId}</g:link> --}%
                    </g:if>
                    <g:elseif test="${params.caseRecord?.id}">
                        ${nci.bbrb.cdr.datarecords.CaseRecord.get(params.caseRecord?.id)}
                        <g:hiddenField name="caseId" value="${queryInstance?.caseRecord?.caseId}" />
                    </g:elseif>
                    <g:else>
                        <g:textField name="caseId" value="${queryInstance?.caseRecord?.caseId}" /><div id="noCaseText" class="redtext"></div>
                    </g:else>
                </td>
            </tr>
            
            <tr id="candidateRow" class="prop ${queryInstance?.candidateRecord ? '' : 'hide'}">
                <td valign="top" class="name">
                    <label for="candidateRecord">Candidate Record:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'candidateRecord', 'errors')}">
                    <g:if test="${params.action == 'show'}">
                        <g:link controller="candidateRecord" action="show" id="${queryInstance?.candidateRecord?.id}">${queryInstance?.candidateRecord?.candidateId}</g:link>
                    </g:if>
                    <g:elseif test="${params.candidateRecord?.id}">
                        ${nci.bbrb.cdr.datarecords.CandidateRecord.get(params.candidateRecord?.id)}
                        <g:hiddenField name="candidateId" value="${queryInstance?.candidateRecord?.candidateId}" />
                    </g:elseif>
                    <g:else>
                        <g:textField name="candidateId" value="${queryInstance?.candidateRecord?.candidateId}" /><div id="noCandidateText" class="redtext"></div>
                    </g:else>
                </td>
            </tr>

            <tr id="otherRow" class="prop ${queryInstance?.other ? '' : 'hide'}">
                <td valign="top" class="name">
                    <label for="other">Other:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'other', 'errors')}">
                    <g:textField name="other" value="${queryInstance?.other}" />
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="isDcf">Is this a Data Correction Form (DCF)?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'isDcf', 'errors')}">
                    <g:bpvYesNoRadioPicker checked="${queryInstance?.isDcf}"  name="isDcf" />
                </td>
            </tr>
            
            <tr class="prop depends-on" data-id="isDcf_yes">
                <td valign="top" class="name">
                    <label for="dcfId">DCF ID:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'dcfId', 'errors')}">
                    <g:textField name="dcfId" value="${queryInstance?.dcfId}" />
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="queryType">Query type:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'queryType', 'errors')}">
                    <g:select name="queryType.id" from="${nci.bbrb.cdr.staticmembers.QueryType.list()}" optionKey="id" value="${queryInstance?.queryType?.id}" noSelection="['null': '']" />
                </td>
            </tr>

            <tr class="prop">
                <td colspan="2" valign="top" class="name ${hasErrors(bean: queryInstance, field: 'description', 'errors')}">
                    <label for="description">Description:</label><br />
                    <g:textArea class="textwidehigh" name="description" cols="40" rows="5" value="${queryInstance?.description}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="formName">Related form(s):</label>
                </td>
                <td>
                    <g:textField name="formName" value="${queryInstance?.formName}" />
                </td>
                %{--
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'gtexCrf', 'errors')}">
                    <div>
                        <g:set var="showFormList" value="${queryInstance?.organization?.code != 'VARI' && queryInstance?.organization?.code != 'BROAD'}" />
                        <span class="gtexFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'GTEX' && showFormList ? '' : 'hide'}"><g:checkBox name="gtexCrf" value="${queryInstance?.gtexCrf}" />&nbsp;<label for="gtexCrf">GTEx CRF</label><br /></span>
                        <span class="gtexFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'GTEX' && showFormList ? '' : 'hide'}"><g:checkBox name="gtexTrf" value="${queryInstance?.gtexTrf}" />&nbsp;<label for="gtexTrf">GTEx TRF</label><br /></span>
                        <span class="gtexCandidateFormCheckBox ${queryInstance?.candidateRecord?.study?.code == 'GTEX' && showFormList ? '' : 'hide'}"><g:checkBox name="gtexConsent" value="${queryInstance?.gtexConsent}" />&nbsp;<label for="gtexConsent">GTEx Consent Verification Form</label><br /></span>
                        <span class="gtexCandidateFormCheckBox ${queryInstance?.candidateRecord?.study?.code == 'GTEX' && showFormList ? '' : 'hide'}"><g:checkBox name="gtexDonorEligi" value="${queryInstance?.gtexDonorEligi}" />&nbsp;<label for="gtexDonorEligi">GTEx Donor Eligibility Form</label><br /></span>
                        <span class="bmsFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BMS' && showFormList ? '' : 'hide'}"><g:checkBox name="bmsTrf" value="${queryInstance?.bmsTrf}" />&nbsp;<label for="bmsTrf">BMS TRF</label><br /></span>
                        <span class="bpvCandidateFormCheckBox ${(queryInstance?.candidateRecord?.study?.code == 'BPV' || queryInstance?.caseRecord?.study?.code == 'BPV') && showFormList ? '' : 'hide'}"><g:checkBox name="bpvScreening" value="${queryInstance?.bpvScreening}" />&nbsp;<label for="bpvScreening">BPV Subject Screening Form</label><br /></span>
                        <span class="bpvCandidateFormCheckBox ${(queryInstance?.candidateRecord?.study?.code == 'BPV' || queryInstance?.caseRecord?.study?.code == 'BPV') && showFormList ? '' : 'hide'}"><g:checkBox name="bpvConsent" value="${queryInstance?.bpvConsent}" />&nbsp;<label for="bpvConsent">BPV Subject Consent Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvBlood" value="${queryInstance?.bpvBlood}" />&nbsp;<label for="bpvBlood">BPV Blood Collection and Processing Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvGross" value="${queryInstance?.bpvGross}" />&nbsp;<label for="bpvGross">BPV Tissue Gross Evaluation Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvSurgery" value="${queryInstance?.bpvSurgery}" />&nbsp;<label for="bpvSurgery">BPV Surgery-Anesthesia Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvDissection" value="${queryInstance?.bpvDissection}" />&nbsp;<label for="bpvDissection">BPV Tissue Receipt-Dissection Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvWorksheet" value="${queryInstance?.bpvWorksheet}" />&nbsp;<label for="bpvWorksheet">BPV Tissue Processing Worksheet</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvProcessing" value="${queryInstance?.bpvProcessing}" />&nbsp;<label for="bpvProcessing">BPV Processing-Embedding Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvStain" value="${queryInstance?.bpvStain}" />&nbsp;<label for="bpvStain">BPV FFPE Section-Stain Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvFinalSurgi" value="${queryInstance?.bpvFinalSurgi}" />&nbsp;<label for="bpvFinalSurgi">BPV Final Surgical Pathology Report</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvClinical" value="${queryInstance?.bpvClinical}" />&nbsp;<label for="bpvClinical">BPV Clinical Data Entry Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvQuality" value="${queryInstance?.bpvQuality}" />&nbsp;<label for="bpvQuality">BPV Case Quality Review Form</label><br /></span>
                        <span class="bpvFormCheckBox ${queryInstance?.caseRecord?.study?.code == 'BPV' && showFormList ? '' : 'hide'}"><g:checkBox name="bpvLocalPath" value="${queryInstance?.bpvLocalPath}" />&nbsp;<label for="bpvLocalPath">BPV Local Pathology Review Form</label><br /></span>
                    </div>
                </td>
                --}%
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="dueDate">Due date:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'dueDate', 'errors')}">
                    <g:jqDatePicker name="dueDate" value="${queryInstance?.dueDate}" />
                </td>
            </tr>
            
            %{--
                def queryManagerList = nci.bbrb.cdr.util.AppSetting.findByCode("QUERY_MANAGER")?.bigValue?.split(",")?.toList()
            --}%
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="openedBy">Opened by:</label>
                </td>
                <td>
                    <g:textField name="openedBy" value="${queryInstance?.openedBy}" />
                </td>
                %{--
                <td valign="top" class="value ${hasErrors(bean: queryInstance, field: 'openedBy', 'errors')}">
                    <g:if test="${queryInstance?.openedBy && !(queryInstance?.openedBy in queryManagerList)}">
                        ${queryInstance?.openedBy}
                    </g:if>
                    <g:else>
                        <g:select name="openedBy" from="${queryManagerList}" value="${queryInstance?.openedBy}" noSelection="['':'']" />
                    </g:else>
                </td>
                --}%
            </tr>
            
            <g:if test="${queryInstance?.deviation}">
              <!--hide from BSS view per Karna -->
                <g:if test="${session.authorities?.contains('ROLE_DM') || 
                          session.authorities?.contains('ROLE_SUPER') || 
                          session.authorities?.contains('ROLE_ADMIN')}">              
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="deviation">Related Deviation:</label>
                    </td>
                    <td valign="top">
                        <g:if test="${queryInstance?.deviation?.description?.size() <= 60}"><span><g:link controller="deviation" action="show" id="${queryInstance?.deviation?.id}">${queryInstance?.deviation?.id}</g:link>${": " + queryInstance?.deviation?.description}</span></g:if>
                        <g:else><span class="ca-tooltip-nobg" data-msg="${queryInstance?.deviation?.description?.replace('\n', '<br />')?.replace('\"', '\'')}"><g:link controller="deviation" action="show" id="${queryInstance?.deviation?.id}">${queryInstance?.deviation?.id}</g:link>${": " + queryInstance?.deviation?.description?.substring(0, 60)}&nbsp;&hellip;</span></g:else><br />
                    </td>
                </tr>
                </g:if>                
            </g:if>

        </tbody>
    </table>
</div>
