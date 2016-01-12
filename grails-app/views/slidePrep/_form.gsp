<%@ page import="nci.bbrb.cdr.forms.SlidePrep" %>
<g:set var="labelNumber" value="${1}"/>
<g:render template="/caseRecord/caseDetails" bean="${slidePrepInstance?.caseRecord}" var="caseRecord" />
<div class="dialog">
    <table>
        <tbody>

          <tr><td colspan="2" class="formheader">H&E Staining</td></tr>
          
            
            <g:if test="${canResume}">
                <tr class="prop">
                            <td valign="top" class="name"> ${labelNumber++}. Slide List:</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${slidePrepInstance.slideList}" var="sl">
                                    <li><g:link controller="slideRecord" action="show" id="${sl.id}">${sl?.encodeAsHTML()}</g:link></li>
                                  
                                
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                
                
                </g:if>
            <g:else>
            
            <tr class="prop">
            <td valign="top" class="name">
                 ${labelNumber++}. Slide List:
            </td>
            <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'slideList', 'errors')}">
                    
                 <g:each in="${slidesList}" status="i" var="sl">
                  
                         <g:checkBox type="checkbox" name ="sl_${sl.id}" id="sl_${sl.id}" value="${slidePrepInstance.slideList?.contains(sl)}" /><label for=sl_${sl.id}">&nbsp;&nbsp;${sl.slideId}</label> <br />
                   </g:each>

            </td>
        </tr>
        </g:else>
        
                  

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E time in oven:
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heTimeInOven', 'errors')}">
                          <g:select id="heTimeInOven" name="heTimeInOven" from="${['20 minutes', 'Other (specify)']}" value="${slidePrepInstance?.heTimeInOven}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop subentry" id="heTimeInOvenOsRow" style="display:${slidePrepInstance?.heTimeInOven == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">Other H&E time in oven (specify):<span id="slideprep.otherheoventime" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heTimeInOvenOs', 'errors')}">
                          <g:textField id="heTimeInOvenOs" name="heTimeInOvenOs" value="${slidePrepInstance?.heTimeInOvenOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E oven temp:
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heOvenTemp', 'errors')}">
                          <g:select name="heOvenTemp" from="${['60° C', 'Other (specify)']}" value="${slidePrepInstance?.heOvenTemp}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop subentry" id="heOvenTempOsRow" style="display:${slidePrepInstance?.heOvenTemp == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">Other H&E oven temp (specify):<span id="slideprep.otherheoventemp" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heOvenTempOs', 'errors')}">
                          <g:textField name="heOvenTempOs" value="${slidePrepInstance?.heOvenTempOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E de-paraffin method:
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heDeParrafinMethod', 'errors')}">
                          <g:select name="heDeParrafinMethod" from="${['Manual', 'Automated stainer', 'Other (specify)']}" value="${slidePrepInstance?.heDeParrafinMethod}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop subentry" id="heDeParrafinMethodOsRow" style="display:${slidePrepInstance?.heDeParrafinMethod == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">Other H&E de-paraffin method (specify):<span id="slideprep.otherhedeparaffinmethod" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heDeParrafinMethodOs', 'errors')}">
                          <g:textField name="heDeParrafinMethodOs" value="${slidePrepInstance?.heDeParrafinMethodOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E stain method:
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heStainMethod', 'errors')}">
                          <g:select name="heStainMethod" from="${['Manual', 'Automated stainer', 'Other (specify)']}" value="${slidePrepInstance?.heStainMethod}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop subentry" id="heStainMethodOsRow" style="display:${slidePrepInstance?.heStainMethod == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">Other H&E stain method (specify):<span id="slideprep.otherhestainmethod" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heStainMethodOs', 'errors')}">
                          <g:textField name="heStainMethodOs" value="${slidePrepInstance?.heStainMethodOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E clearing method:
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heClearingMethod', 'errors')}">
                          <g:select name="heClearingMethod" from="${['Manual', 'Automated stainer','Other (specify)']}" value="${slidePrepInstance?.heClearingMethod}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop subentry" id="heClearingMethodOsRow" style="display:${slidePrepInstance?.heClearingMethod == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">Other H&E clearing method (specify):<span id="slideprep.otherheclearingmethod" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heClearingMethodOs', 'errors')}">
                          <g:textField name="heClearingMethodOs" value="${slidePrepInstance?.heClearingMethodOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E cover slipping:</span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heCoverSlipping', 'errors')}">
                          <g:select name="heCoverSlipping" from="${['Manual', 'Other (specify)']}" value="${slidePrepInstance?.heCoverSlipping}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop subentry" id="heCoverSlippingOsRow" style="display:${slidePrepInstance.heCoverSlipping == 'Other (specify)'?'display':'none'}">
                      <td valign="top" class="name">Other H&E cover slipping (specify):<span id="slideprep.otherhecovslipmethod" class="vocab-tooltip"></span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heCoverSlippingOs', 'errors')}">
                          <g:textField name="heCoverSlippingOs" value="${slidePrepInstance?.heCoverSlippingOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td valign="top" class="name">
                          ${labelNumber++}. H&E equipment maintenance:</span>
                      </td>
                      <td valign="top" class="value ${hasErrors(bean: slidePrepInstance, field: 'heEquipMaint', 'errors')}">
                          <g:select name="heEquipMaint" from="${['Daily, Weekly, Bi-Monthly, Per SOP', 'Other (specify)']}" value="${slidePrepInstance.heEquipMaint}" noSelection="['': '']" />
                      </td>
                  </tr>

                  <tr class="prop" id="heEquipMaintOsRow" style="display:${slidePrepInstance.heEquipMaint == 'Other (specify)'?'display':'none'}">
                      <td colspan="2"class="name">Please record any deviations from the H&E equipment maintenance SOP:<span id="slideprep.otherhestainequipmaint" class="vocab-tooltip"></span><br />
                          <g:textArea class="textwide" name="heEquipMaintOs" cols="20" rows="3" value="${slidePrepInstance?.heEquipMaintOs}" />
                      </td>
                  </tr>

                  <tr class="prop">
                      <td colspan="2" class="name ${hasErrors(bean: slidePrepInstance, field: 'heComments', 'errors')}">
                          ${labelNumber++}. Additional comments related to preparation of FFPE Hematoxylin and Eosin stained slides:<span id="slideprep.ffpehestainedslideprepcomments" class="vocab-tooltip"></span><br />
                          <g:textArea class="textwide" name="heComments" cols="20" rows="3" value="${slidePrepInstance?.heComments}" />
                      </td>
                  </tr>

        
        

        </tbody>
    </table>
</div>  
