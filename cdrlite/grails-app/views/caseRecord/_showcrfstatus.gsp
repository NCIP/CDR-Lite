<%@ page import="nci.bbrb.cdr.util.AppSetting" %>

<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>




<tr class="prop"><td valign="top" class="name formheader" colspan="2">CRF Status:</td></tr>
<tr>
    <td valign="top" class="value" colspan="2">
        <div class="list">
            <table>
                <thead>
                    <tr>
                        <th>Form</th>
                        <th>Status</th>
                        <th>Date Submitted</th>
                    </tr>
                </thead>
                <tbody>

                    <tr class="odd ${caseStatus?.hideBlood ? 'hide' : ''}">
                        <td>Blood Collection and Processing Form</td>
                        <td>
                            <g:if test="${caseStatus?.blood == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/blood/save?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.blood == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="blood" action="edit" id="${caseRecordInstance.blood.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="blood" action="show" id="${caseRecordInstance.blood.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.blood == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="blood" action="show" id="${caseRecordInstance.blood.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.blood?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.blood?.submittedBy}</b>"><g:if test="${caseRecordInstance.blood?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                                                <!-- surgery anesthesia form -->
                    <tr class="odd ${caseStatus?.hideSurgeryAnesthesia ? 'hide' : ''}">
                        <td>Surgery Anesthesia Form</td>
                        <td>
                            <g:if test="${caseStatus?.surgeryAnesthesia == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/surgeryAnesthesia/save?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.surgeryAnesthesia == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="surgeryAnesthesia" action="edit" id="${caseRecordInstance.surgeryAnesthesia.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="surgeryAnesthesia" action="show" id="${caseRecordInstance.surgeryAnesthesia.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.surgeryAnesthesia == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="surgeryAnesthesia" action="show" id="${caseRecordInstance.surgeryAnesthesia.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.surgeryAnesthesia?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.surgeryAnesthesia?.submittedBy}</b>"><g:if test="${caseRecordInstance.surgeryAnesthesia?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                    
                                                    <!-- tissue gross evaluation form -->
                    <tr class="odd ${caseStatus?.hideTissueGrossEvaluation ? 'hide' : ''}">
                        <td>Tissue Gross Evaluation Form</td>
                        <td>
                            <g:if test="${caseStatus?.tissueGrossEvaluation == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/tissueGrossEvaluation/create?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.tissueGrossEvaluation == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="tissueGrossEvaluation" action="edit" id="${caseRecordInstance.tissueGrossEvaluation.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="tissueGrossEvaluation" action="show" id="${caseRecordInstance.tissueGrossEvaluation.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.tissueGrossEvaluation == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="tissueGrossEvaluation" action="show" id="${caseRecordInstance.tissueGrossEvaluation.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.tissueGrossEvaluation?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.tissueGrossEvaluation?.submittedBy}</b>"><g:if test="${caseRecordInstance.tissueGrossEvaluation?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                        <!-- END tissue gross evaluation form -->
                        <!-- Tissue Receipt and Dissection Form< -->
                        <tr class="odd ${caseStatus?.hideTissueReceiptDissection ? 'hide' : ''}">
                        <td>Tissue Receipt and Dissection Form</td>
                        <td>
                            <g:if test="${caseStatus?.tissueReceiptDissection == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/tissueReceiptDissection/create?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.tissueReceiptDissection == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="tissueReceiptDissection" action="edit" id="${caseRecordInstance.tissueReceiptsAndDissection.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="tissueReceiptDissection" action="show" id="${caseRecordInstance.tissueReceiptsAndDissection.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.tissueReceiptDissection == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="tissueReceiptDissection" action="show" id="${caseRecordInstance.tissueReceiptsAndDissection.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.tissueReceiptsAndDissection?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.tissueReceiptsAndDissection?.submittedBy}</b>"><g:if test="${caseRecordInstance.tissueReceiptsAndDissection?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>

                        %{-- Specimen preservation form (enter specimens) --}%
                        <tr class="odd ${caseStatus?.hideSpecimenPreservation ? 'hide' : ''}">
                        <td>Tissue Preservation Form (Add specimens)</td>
                        <td>
                            <g:if test="${caseStatus?.specimenPreservation == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/specimenRecord/create?caseRecord.id=${caseRecordInstance.id}">(Add Specimens)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.specimenPreservation == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/specimenRecord/create?caseRecord.id=${caseRecordInstance.id}">(Add Specimens)</a>
                                </g:if>
                                <g:else>
                                    <g:link controller="specimenRecord" action="list" id="${caseRecordInstance.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.specimenPreservation == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="specimenRecord" action="list" id="${caseRecordInstance.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.statusDate}"/>
                            %{--
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance?.submittedBy}</b>">
                            <g:if test="${caseRecordInstance?.submittedBy}">
                                <span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span>
                            </g:if>
                            </span>
                            --}%
                        </td>
                        </tr>



                        
                          %{-- Tissue Processing-Embedding Form --}%
                    <tr class="odd ${caseStatus?.hideTissueProcessEmbed ? 'hide' : ''}">
                        <td>${nci.bbrb.cdr.forms.TissueProcessEmbedController.CDR_FORM_NAME}</td>
                        <td>
                            <g:if test="${caseStatus?.tissueProcessEmbed == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/tissueProcessEmbed/create?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.tissueProcessEmbed == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="tissueProcessEmbed" action="edit" id="${caseRecordInstance.tissueProcessEmbed.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="tissueProcessEmbed" action="show" id="${caseRecordInstance.tissueProcessEmbed.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.tissueProcessEmbed == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="tissueProcessEmbed" action="show" id="${caseRecordInstance.tissueProcessEmbed.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.tissueProcessEmbed?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.tissueProcessEmbed?.submittedBy}</b>"><g:if test="${caseRecordInstance.tissueProcessEmbed?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                    <tr class="odd ${caseStatus?.hideSlideSection ? 'hide' : ''}">
              <td>Slide Sectioning Form (Add slides)</td>
              <td>
                  <g:if test="${caseStatus?.slideSection == 1}">
                      <span class="no">Not Started</span>
                        <g:if test="${canModify}">
                        <a href="/cdrlite/slideSection/create?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                        </g:if>
                  </g:if>
                  <g:elseif test="${caseStatus?.slideSection == 2}">
                      <span class="incomplete">In Progress</span>
                      <g:if test="${canModify}">
                        %{-- <g:link controller="caseRecord" action="addspec" caseRecordInstance="$caseRecordInstance">(Add)</g:link> --}%
                        <a href="/cdrlite/slideSection/edit?slideSection.id=${caseRecordInstance.slideSection.id}">(Edit)</a>
                      </g:if>
                  </g:elseif>
                  <g:elseif test="${caseStatus?.slideSection == 3}">
                    <span class="yes">Completed</span>
                    %{-- <g:link controller="specimenRecord" action="show" id="${caseRecordInstance.specimenRecord.id}">(View)</g:link> --}%
                      <a href="/cdrlite/slideSection/show?slideSection.id=${caseRecordInstance.slideSection.id}">(View)</a>
                  </g:elseif>
              </td>
              <td>
              <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.slideSection?.dateSubmitted}"/>
              <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.slideSection?.submittedBy}</b>"><g:if test="${caseRecordInstance.slideSection?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
              </td>
          </tr>
                    
                                              <!-- Slide prep form -->
                    <tr class="odd ${caseStatus?.hideSlidePrep ? 'hide' : ''}">
                        <td>Slide Prep and staining Form</td>
                        <td>
                            <g:if test="${caseStatus?.slidePrep == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/slidePrep/create?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.slidePrep == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="slidePrep" action="edit" id="${caseRecordInstance.slidePrep.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="slidePrep" action="show" id="${caseRecordInstance.slidePrep.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.slidePrep == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="slidePrep" action="show" id="${caseRecordInstance.slidePrep.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.slidePrep?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.slidePrep?.submittedBy}</b>"><g:if test="${caseRecordInstance.slidePrep?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                                                      <!-- END Slide Prep form -->  

                    
                        <tr class="even ${caseStatus?.hideFinalSurgicalPath ? 'hide' : ''}">
                            <td>Surgical Pathology Form</td>
                            <td>
                            <g:if test="${!caseRecordInstance.finalSurgicalPath}">
                                <span class="no filelabel">Not Uploaded</span>
                                <g:if test="${canModify}">
                                    <g:link controller="localPathReview" action="upload" id="${caseRecordInstance.id}" class="uibutton removepadding" title="Upload"><span class="ui-icon ui-icon-circle-arrow-n">Upload</span></g:link>
                                </g:if>
                            </g:if>
                            <g:else>
                                <span class="yes">Uploaded</span>
                                &nbsp;<g:link controller="localPathReview" action="download" id="${caseRecordInstance.id}" class="uibutton removepadding" title="Download"><span class="ui-icon ui-icon-circle-arrow-s">Download</span></g:link>
                                <g:if test="${canModify}">
                                    &nbsp;<g:link controller="localPathReview" action="remove" id="${caseRecordInstance.id}" onclick="return confirm('Are you sure to remove the file?')" class="uibutton removepadding" title="Delete"><span class="ui-icon ui-icon-trash">Delete</span></g:link>
                                </g:if>
                            </g:else>
                            </td>
                            <td>
                                <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.dateFspUploaded}"/>
                                <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.fspUploadedBy}</b>"><g:if test="${caseRecordInstance.fspUploadedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                        <tr class="odd ${caseStatus?.hideClinicalDataEntry ? 'hide' : ''}">
                        <td>Clinical Data Entry Form</td>
                        <td>
                            <g:if test="${caseStatus?.clinicalDataEntry == 1}">
                                <span class="no">Not Started</span>
                                <g:if test="${canModify}">
                                    <a href="/cdrlite/clinicalDataEntry/create?caseRecord.id=${caseRecordInstance.id}">(Start)</a>
                                </g:if>
                            </g:if>
                            <g:elseif test="${caseStatus?.clinicalDataEntry == 2}">
                                <span class="incomplete">In Progress</span>
                                <g:if test="${canModify}">
                                    <g:link controller="clinicalDataEntry" action="edit" id="${caseRecordInstance.clinicalDataEntry.id}">(Edit)</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="clinicalDataEntry" action="show" id="${caseRecordInstance.clinicalDataEntry.id}">(View)</g:link>
                                </g:else>
                            </g:elseif>
                            <g:elseif test="${caseStatus?.clinicalDataEntry == 3}">
                                <span class="yes">Completed</span>
                                <g:link controller="clinicalDataEntry" action="show" id="${caseRecordInstance.clinicalDataEntry.id}">(View)</g:link>
                            </g:elseif>
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd HH:mm" date="${caseRecordInstance.clinicalDataEntry?.dateSubmitted}"/>
                            <span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.clinicalDataEntry?.submittedBy}</b>"><g:if test="${caseRecordInstance.clinicalDataEntry?.submittedBy}"><span class="uibutton removepadding borderless"><span class="ui-icon ui-icon-person"></span></span></g:if></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </td>
    </tr>
