%{-- <%@ page import="nci.bbrb.cdr.staticmembers.Module" %> --}%
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>

<script type="text/javascript">
    $(document).ready(function() {
          $("#microtome").change(function() {
              if($("#microtome").val() == 'Other (specify)') {
                  $("#microtomeOsRow").show()
              } else {
                  $("#microtomeOsRow").hide()
                  $("#microtomeOs").val('')
              }
          });

          $("#microtomeBladeType").change(function() {
              if($("#microtomeBladeType").val() == 'Other (specify)') {
                  $("#microtomeBladeTypeOsRow").show()
              } else {
                  $("#microtomeBladeTypeOsRow").hide()
                  $("#microtomeBladeTypeOs").val('')
              }
          });

          $("#microtomeBladeAge").change(function() {
              if($("#microtomeBladeAge").val() == 'Other (specify)') {
                  $("#microtomeBladeAgeOsRow").show()
              } else {
                  $("#microtomeBladeAgeOsRow").hide()
                  $("#microtomeBladeAgeOs").val('')
              }
          });

          $("#facedBlockPrep").change(function() {
              if($("#facedBlockPrep").val() == 'Other (specify)') {
                  $("#facedBlockPrepOsRow").show()
              } else {
                  $("#facedBlockPrepOsRow").hide()
                  $("#facedBlockPrepOs").val('')
              }
          });

          $("#sectionThickness").change(function() {
              if($("#sectionThickness").val() == 'Other (specify)') {
                  $("#sectionThicknessOsRow").show()
              } else {
                  $("#sectionThicknessOsRow").hide()
                  $("#sectionThicknessOs").val('')
              }
          });

          $("#slideCharge").change(function() {
              if($("#slideCharge").val() == 'Other (specify)') {
                  $("#slideChargeOsRow").show()
              } else {
                  $("#slideChargeOsRow").hide()
                  $("#slideChargeOs").val('')
              }
        });

        $("#waterBathTemp").change(function() {
            if($("#waterBathTemp").val() == 'Other (specify)') {
                $("#waterBathTempOsRow").show()
            } else {
                $("#waterBathTempOsRow").hide()
                $("#waterBathTempOs").val('')
            }
        });

        $("#microtomeDailyMaint").change(function() {
            if($("#microtomeDailyMaint").val() == 'Other (specify)') {
                $("#microtomeDailyMaintOsRow").show()
            } else {
                $("#microtomeDailyMaintOsRow").hide()
                $("#microtomeDailyMaintOs").val('')
            }
        });

        $("#waterbathMaint").change(function() {
            if($("#waterbathMaint").val() == 'Other (specify)') {
                $("#waterbathMaintOsRow").show()
            } else {
                $("#waterbathMaintOsRow").hide()
                $("#waterbathMaintOs").val('')
            }
        });

    });
</script>
<g:set var="cid" value="${bpvSlidePrepInstance?.caseRecord?.id ?: params.caseRecord?.id}" />
<g:set var="labelNumber" value="${1}"/>
%{-- <g:render template="/formMetadata/timeConstraint" bean="${slideSectionInstance.formMetadata}" var="formMetadata"/> --}%
<g:render template="/caseRecord/caseDetails" bean="${slideSectionInstance?.caseRecord}" var="caseRecord" />

<div class="list">
    <table class="tdwrap">
        <tbody>
            <tr><td colspan="2" class="formheader">FFPE Sectioning</td></tr>
                <tr class="prop">
                    <td valign="top" class="name" style="width:300px;">
                        <label for="slideSectionTech"><g:message code="bpvSlidePrep.slideSectionTech.label" default="Slide Prep technician name:" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'slideSectionTech', 'errors')}">
                        <g:textField name="slideSectionTech" value="${slideSectionInstance?.slideSectionTech}" />
                    </td>
                </tr>

                <tr class="prop">
                    <td colspan="2" class="name formheader">Slides Created</td>
                </tr>

                <tr class="prop subentry clearborder">
                    <td valign="top" colspan="2" class="name" >
                        <div id="slideDialog">
                            <table>
                                <tbody>
                                  <tr>
                                      <th valign="top" class="name">Slide ID(s)<span id="bpvslideprep.slideid" class="vocab-tooltip"></span></th>
                                      <th valign="top" class="name">Specimen ID<span id="bpvslideprep.module" class="vocab-tooltip"></span></th>
                                      <th class="editOnly" valign="top" style="text-align: center">Action</th>
                                  </tr>
                                  <g:each in="${slides}" status="i" var="slide">
                                      <tr class="${i%2 == 0 ? 'even' : 'odd'}">
                                          <td> ${slide?.slideId}</td>
                                          <td> ${slide.specimenRecord.specimenId} </td>
                                          <td style="text-align: center" class="editOnly timeEntry">
                                             <g:remoteLink class="deleteOnly button ui-button  ui-state-default ui-corner-all removepadding" action="deleteSlide" value="Delete2" update="slideDialog" params="'caseId=${slide.caseId}'" id="${slide.id}">
                                             <span class="ui-icon ui-icon-trash">Delete</span>
                                             </g:remoteLink>
                                          </td>
                                      </tr>
                                  </g:each>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>

                <tr id="add1Row" class="subentry"><td colspan="2"><button class="Btn" id="addSlideBtn">Add</button></td></tr>

                <tr><td colspan="2" class="formheader">FFPE Sectioning Details</td></tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        ${labelNumber++}. Slide Prep SOP:<span id="bpvslideprep.ffpetissueprepsop" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'siteSOPSlideSection', 'errors')}">
                        <g:textField name="siteSOPSlideSection" value="${slideSectionInstance?.siteSOPSlideSection}" />
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        ${labelNumber++}. Microtome:<span id="bpvslideprep.microtome" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtome', 'errors')}">
                        <g:select name="microtome" from="${['Microm Ergostar HM200', 'Other (specify)']}" value="${slideSectionInstance.microtome}" noSelection="['': '']" />
                    </td>
                </tr>

                <tr class="prop" id="microtomeOsRow" style="display:${slideSectionInstance?.microtome == 'Other (specify)'?'display':'none'}">
                    <td valign="top" class="name">
                        &nbsp;&nbsp;&nbsp;&nbsp;Other Microtome (specify):<span id="bpvslideprep.othermicrotome" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeOs', 'errors')}">
                        <g:textField name="microtomeOs" value="${slideSectionInstance?.microtomeOs}" />
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                      ${labelNumber++}. Microtome blade type:<span id="bpvslideprep.microtomeblade" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeType', 'errors')}">
                        <g:select name="microtomeBladeType" from="${['Low profile Sakura Accu-Edge', 'Other (specify)']}" value="${slideSectionInstance.microtomeBladeType}" noSelection="['': '']" />
                    </td>
                </tr>

                <tr class="prop" id="microtomeBladeTypeOsRow" style="display:${slideSectionInstance?.microtomeBladeType == 'Other (specify)'?'display':'none'}">
                    <td valign="top" class="name">
                        &nbsp;&nbsp;&nbsp;&nbsp;Other Microtome Blade Type (specify):<span id="bpvslideprep.othermicrotomeblade" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeTypeOs', 'errors')}">
                        <g:textField name="microtomeBladeTypeOs" value="${slideSectionInstance?.microtomeBladeTypeOs}" />
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        ${labelNumber++}. Microtome blade age:<span id="bpvslideprep.microtomebladeage" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeAge', 'errors')}">
                        <g:select name="microtomeBladeAge" from="${['Fresh', 'Other (specify)']}" value="${slideSectionInstance.microtomeBladeAge}" noSelection="['': '']" />
                    </td>
                </tr>

                <tr class="prop" id="microtomeBladeAgeOsRow" style="display:${slideSectionInstance?.microtomeBladeAge == 'Other (specify)'?'display':'none'}">
                    <td valign="top" class="name">
                        &nbsp;&nbsp;&nbsp;&nbsp;Other Microtome blade age (specify):<span id="bpvslideprep.othermicrotomebladeage" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeAgeOs', 'errors')}">
                        <g:textField name="microtomeBladeAgeOs" value="${slideSectionInstance?.microtomeBladeAgeOs}" />
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        ${labelNumber++}. Preparation of block face for sectioning:<span id="bpvslideprep.blockfaceprep" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'facedBlockPrep', 'errors')}">
                        <g:select name="facedBlockPrep" from="${['20 Minutes on ice', 'Other (specify)']}" value="${slideSectionInstance.facedBlockPrep}" noSelection="['': '']" />
                    </td>
                </tr>

                <tr class="prop" id="facedBlockPrepOsRow" style="display:${slideSectionInstance?.facedBlockPrep == 'Other (specify)'?'display':'none'}">
                  <td valign="top" class="name">
                      &nbsp;&nbsp;&nbsp;&nbsp;Other Faced Block Prep (specify):<span id="bpvslideprep.otherblockfaceprep" class="vocab-tooltip"></span>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'facedBlockPrepOs', 'errors')}">
                      <g:textField name="facedBlockPrepOs" value="${slideSectionInstance?.facedBlockPrepOs}" />
                  </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        ${labelNumber++}. Section thickness:<span id="bpvslideprep.sectionthickness" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'sectionThickness', 'errors')}">
                        <g:select name="sectionThickness" from="${['4-5 micrometers', 'Other (specify)']}" value="${slideSectionInstance.sectionThickness}" noSelection="['': '']" />
                    </td>
                </tr>

                  <tr class="prop" id="sectionThicknessOsRow" style="display:${slideSectionInstance?.sectionThickness == 'Other (specify)'?'display':'none'}">
                    <td valign="top" class="name">
                        &nbsp;&nbsp;&nbsp;&nbsp;Other section thickness (specify):<span id="bpvslideprep.othersectionthickness" class="vocab-tooltip"></span>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'sectionThicknessOs', 'errors')}">
                        <g:textField name="sectionThicknessOs" value="${slideSectionInstance?.sectionThicknessOs}" />
                    </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. Slide charge:<span id="bpvslideprep.slidecharge" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'slideCharge', 'errors')}">
                          <g:select name="slideCharge" from="${['Charged','Uncharged','Other (specify)']}" value="${slideSectionInstance.slideCharge}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop" id="slideChargeOsRow" style="display:${slideSectionInstance?.slideCharge == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">
                          &nbsp;&nbsp;&nbsp;&nbsp;Other Slide charge (specify):<span id="bpvslideprep.otherslidecharge" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'slideChargeOs', 'errors')}">
                          <g:textField name="slideChargeOs" value="${slideSectionInstance?.slideChargeOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. Water bath temp:<span id="bpvslideprep.waterbathtemp" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterBathTemp', 'errors')}">
                          <g:select name="waterBathTemp" from="${['43 (+/-2)°C', 'Other (specify)']}" value="${slideSectionInstance.waterBathTemp}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop" id="waterBathTempOsRow" style="display:${slideSectionInstance?.waterBathTemp == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">
                          &nbsp;&nbsp;&nbsp;&nbsp;Other water bath temp (specify):<span id="bpvslideprep.otherwaterbathtemp" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterBathTempOs', 'errors')}">
                          <g:textField name="waterBathTempOs" value="${slideSectionInstance?.waterBathTempOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. Microtome maintenance:<span id="bpvslideprep.microtomemaint" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeDailyMaint', 'errors')}">
                          <g:select name="microtomeDailyMaint" from="${['Daily', 'Other (specify)']}" value="${slideSectionInstance.microtomeDailyMaint}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop" id="microtomeDailyMaintOsRow" style="display:${slideSectionInstance?.microtomeDailyMaint == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">
                          &nbsp;&nbsp;&nbsp;&nbsp;Please record any deviations from Microtome daily maintenance SOP:<span id="bpvslideprep.devmicrotomemaintsop" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeDailyMaintOs', 'errors')}" >
                          <g:textArea name="microtomeDailyMaintOs" cols="20" rows="3" value="${slideSectionInstance?.microtomeDailyMaintOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. Waterbath maintenance:<span id="bpvslideprep.waterbathmaint" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterbathMaint', 'errors')}">
                          <g:select name="waterbathMaint" from="${['Daily', 'Other (specify)']}" value="${slideSectionInstance.waterbathMaint}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop" id="waterbathMaintOsRow" style="display:${slideSectionInstance?.waterbathMaint == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please record any deviations from the Water Bath daily maintenance SOP:<span id="bpvslideprep.devwaterbathmaintsop" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterbathMaintOs', 'errors')}">
                          <g:textArea name="waterbathMaintOs" cols="20" rows="3" value="${slideSectionInstance?.waterbathMaintOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td colspan="2" class="name ${hasErrors(bean: slideSectionInstance, field: 'FFPEComments', 'errors')}">
                          ${labelNumber++}. Any additional comments related to preparation of FFPE tissue sections:<span id="bpvslideprep.ffpetissueprepcomments" class="vocab-tooltip"></span><br />
                          <g:textArea class="textwide" name="FFPEComments" cols="20" rows="3" value="${slideSectionInstance?.FFPEComments}" />
                      </td>
                  </tr>

            </tbody>
        </table>
  </div>