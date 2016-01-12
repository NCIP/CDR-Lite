
<%@ page import="nci.bbrb.cdr.forms.blood.Blood" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'blood.label', default: 'Blood')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                       </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1>Blood Processing Form</h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:render template="/caseRecord/caseDetails" bean="${bloodInstance.caseRecord}" var="caseRecord" /> 
                    <g:if test="${!bloodInstance.draws}">
                        <table>
                            <tr><td>Comments:</td><td>${bloodInstance.comments}</td> </tr>
                        </table>    
                    </g:if> 
                  <g:form url="[resource:bloodInstance, action:'resume']" method="POST" >
                   <g:each in="${bloodInstance.draws?.sort({it.id})}" status="j" var="drawInstance">
       <h3>Blood Draw --
              <g:if test="${(session.DM || session.LDS) && drawInstance?.dateTimeDraw }">
                  <g:formatDate format="MM/dd/yyyy HH:mm" date="${drawInstance?.dateTimeDraw}"/>
                </g:if>
                <g:elseif test="${(session.DM || session.LDS) && !drawInstance?.dateTimeDraw }">
                </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
          </h3>
       <div class="list">
       <table >
        <tbody>

          <tr class="prop">
              <td colspan="2" class="formheader">Blood Collection Instruction</td>
           </td>
            
       
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="minimumReqMet">1. The minimum requirement was met for blood collection as per the SOP:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'minimumReqMet', 'errors')}">
                <div>
                    ${drawInstance?.minimumReqMet}
                 </div>
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="bloodDrawType"><g:message code="draw.bloodDrawType.label" default="2. Blood draw type:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'bloodDrawType', 'errors')}">
                ${drawInstance?.bloodDrawType?.name}
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeDraw">3. Date and time blood was drawn:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeDraw', 'errors')}">
                <g:if test="${(session.DM || session.LDS) && drawInstance?.dateTimeDraw}">
                <g:formatDate format="MM/dd/yyyy HH:mm" date="${drawInstance?.dateTimeDraw}"/>
                </g:if>
                <g:elseif test="${(session.DM || session.LDS) && !drawInstance?.dateTimeDraw }">
                </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
            </td>
        </tr>

        
         <tr class="prop">
            <td valign="top" class="name">
                <label for="bloodDrawBy"><g:message code="draw.bloodDrawBy.label" default="4. Blood draw was performed by:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'bloodDrawBy', 'errors')}">
                ${drawInstance?.bloodDrawBy?.name}

            </td>
        </tr>

         <tr class="prop">
            <td valign="top" class="name">
                <label for="personName"><g:message code="draw.personName.label" default="5. Name of person performed blood draw:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'personName', 'errors')}">
               ${drawInstance?.personName}

            </td>
        </tr>

         <tr class="prop">
            <td valign="top" class="name">
                <label for="hasIssue">6. Were there any issues or difficulties with the blood draw?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'hasIssue', 'errors')}">
                ${drawInstance?.hasIssue}
            </td>
        </tr>
        
        
        
           <tr class="prop" id="issues" style="display:${drawInstance?.hasIssue =='Yes'?'display':'none'}">
            <td valign="top" >
               if Yes, please specify
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'bloodDrawIssues', 'errors')}">
                ${drawInstance?.bloodDrawIssues}
                       </td>    

            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="collectionComments"><g:message code="draw.collectionComments.label" default="7. Blood Collection Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'collectionComments', 'errors')}">
                ${drawInstance?.collectionComments}
               
            </td>
        </tr>

      
         <tr class="prop">
              <td colspan="2" class="formheader">Blood Processing Overview</td>
           </td>
        
      <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeReceived"><g:message code="draw.dateTimeReceived.label" default="8. Date and time blood received in the lab:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeReceived', 'errors')}">
                
                 <g:if test="${(session.DM || session.LDS) && drawInstance?.dateTimeReceived }">
                   <g:formatDate format="MM/dd/yyyy HH:mm" date="${drawInstance?.dateTimeReceived}"/>
                </g:if>
                <g:elseif test="${(session.DM || session.LDS) && !drawInstance?.dateTimeReceived }">
                </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
                
                
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="receivedBy"><g:message code="draw.receivedBy.label" default="9. Blood tube(s) received in lab by:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'receivedBy', 'errors')}">
                ${drawInstance?.receivedBy}
               
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="temperatureStr"><g:message code="draw.temperatureStr.label" default="10. Temperature in lab when blood was received:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'temperatureStr', 'errors')}">
                ${drawInstance?.temperatureStr} ˚C

            </td>
        </tr>

  
        <tr class="prop">
            <td valign="top" class="name">
                <label for="humidityStr"><g:message code="draw.humidityStr.label" default="11. Humidity in lab when tube(s) were received:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'humidityStr', 'errors')}">
                ${drawInstance?.humidityStr} %

            </td>
        </tr>

<tr>
<td colspan="2">
<table>
<tr>
<th colspan="5">12. Blood Collection Tube  Details</th>
</tr>
<tr>
<th>Collection Tube Specimen Barcode ID</th>
<th>Specimen Tube Type </th>
 <th>Processed for </th>
 <th>Volume Collected (ml)</th>
</tr>
 <g:each in="${drawInstance.collectionTubes?.sort{it.id}}" status="i" var="t">
   <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
          <td >${t.collectionTubeId}</td>
          <td> ${t.collectionTubeType?.name}</td>
  <td valign="top" > ${t.processedFor?.name}</td>
  <td valign="top" >${t.volume}  </td>
 </g:each>
</table>
</td>
</tr>
        

        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeProcessingStart"><g:message code="draw.dateTimeProcessingStart.label" default="13. Time blood processing began:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeProcessingStart', 'errors')}">
                
                 <g:if test="${(session.DM || session.LDS) && drawInstance?.dateTimeProcessingStart}">
                   <g:formatDate format="MM/dd/yyyy HH:mm" date="${drawInstance?.dateTimeProcessingStart}"/>
                </g:if>
                <g:elseif test="${(session.DM || session.LDS) && !drawInstance?.dateTimeProcessingStart }">
                </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
                
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeProcessingEnd"><g:message code="draw.dateTimeProcessingEnd.label" default="14. Time blood processing completed:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeProcessingEnd', 'errors')}">
                
                  <g:if test="${(session.DM || session.LDS) && drawInstance?.dateTimeProcessingEnd}">
                   <g:formatDate format="MM/dd/yyyy HH:mm" date="${drawInstance?.dateTimeProcessingEnd}"/>
                </g:if>
                <g:elseif test="${(session.DM || session.LDS) && !drawInstance?.dateTimeProcessingEnd }">
                </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
                
          
            </td>
        </tr>

    <tr class="prop">
    <td valign="top" class="name">15. Blood fraction aliquot details</td><td></td>
    </tr>
        
<tr>
<td colspan="2">
<table>
<tr>
<th colspan="9">15a. Blood fraction cryovial aliquot information</th>
</tr>
<tr>
  <th>Blood Collection Tube Source, Barcode ID </th>
<th>Aliquot Barcode ID: </th>
 <th>Aliquot Type:  </th>
 <th>Aliquot Volume (ml)</th>
 <th>Scanned ID: Record when Aliquot Frozen</th> 
 <th>Time Aliquot Frozen</th> 
 <th>Scanned ID: Record when Aliquot Transferred to Freezer</th>
 <th>Time Aliquot Transferred to Freezer</th>

</tr>

<g:each in="${drawInstance.aliquots?.sort{it.id}}" status="i" var="a">
 <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  <td style="white-space:nowrap">${a.collectionTube?.collectionTubeId}</td>
  <td style="white-space:nowrap">${a.aliquotId}</td>
   <td valign="top" >${a.aliquotType?.name}</td>
  <td valign="top"> ${a.volume}</td>
  
  <td style="white-space:nowrap">${a.scannedId4Frozen}</td>
  <td style="white-space:nowrap">
    <g:if test="${(session.DM || session.LDS) && a.dateTimeFrozen }">
      <g:formatDate format="MM/dd/yyyy HH:mm" date="${a.dateTimeFrozen}"/>
     </g:if>
     <g:elseif test="${(session.DM || session.LDS) && !a.dateTimeFrozen }">
     </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
  
  
  </td>
  <td style="white-space:nowrap">${a.scannedId4Trans}</td>
  <td >
   <g:if test="${(session.DM || session.LDS) && a.dateTimeTrans }">
     <g:formatDate format="MM/dd/yyyy HH:mm" date="${a.dateTimeTrans}"/>
                </g:if>
   <g:elseif test="${(session.DM || session.LDS) && !a.dateTimeTrans }">
     </g:elseif>
                <g:else>
                  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                </g:else>
  
  
  </td>
  
  
  </td>
  
</tr>


</g:each>

</table>
</td>
</tr>


        <tr class="prop">
            <td valign="top" class="name">
                <label for="aliquotsProcessedBy"><g:message code="draw.aliquotsProcessedBy.label" default="15b. Aliquots were processed by" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'aliquotsProcessedBy', 'errors')}">
             ${drawInstance?.aliquotsProcessedBy}  
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="aliquotTransferredBy"><g:message code="draw.aliquotTransferredBy.label" default="15c. Frozen aliquot transfer completed by:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'aliquotTransferredBy', 'errors')}">
             ${drawInstance?.aliquotTransferredBy}  
            </td>
        </tr>

         <tr class="prop">
              <td colspan="2" class="formheader">Note Deviations from SOP, Processing or Storage Issues</td>
           </td>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="procesingAccodSop"><g:message code="draw.procesingAccodSop.label" default="16. Blood Processing was performed in accordance with specified SOP" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'procesingAccodSop', 'errors')}">
                ${drawInstance?.procesingAccodSop}
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="processingComments"><g:message code="draw.processingComments.label" default="17. Blood Processing Comments:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'processingComments', 'errors')}">
                ${drawInstance?.processingComments}
            </td>
        </tr>

        
        <tr class="prop" >
            <td valign="top" class="name">
                <label for="wasClotting"><g:message code="draw.wasClotting.label" default="18. Was Clotting observed in a collection tube? " /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'wasClotting', 'errors')}">
                ${drawInstance?.wasClotting}   
            </td>
        </tr>

         <tr class="prop"  id='cids' style="display:${drawInstance?.wasClotting =='Yes'?'display':'none'}">
            <td valign="top">
             If Yes, please specify blood collection tube IDs:
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'clottingTubeIds', 'errors')}">
                ${drawInstance?.clottingTubeIds}
            </td>
        </tr>
        
        <tr class="prop" >
            <td valign="top" class="name">
                <label for="grossHemolysis"><g:message code="draw.grossHemolysis.label" default="19. Was presence of Gross Hemolysis  observed?" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'grossHemolysis', 'errors')}">
                ${drawInstance?.grossHemolysis}
              
            </td>
        </tr>

         <tr class="prop"  id='gids' style="display:${drawInstance?.grossHemolysis =='Yes'?'display':'none'}">
            <td valign="top">
             If Yes, please specify blood collection tube IDs:
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'hemolysisTubeIds', 'errors')}">
                ${drawInstance?.hemolysisTubeIds}
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="storageIssue"><g:message code="draw.storageIssue.label" default="20. Storage Issues:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'storageIssue', 'errors')}">
              ${drawInstance?.storageIssue}
            </td>
        </tr>

        
        
        
        

        </tbody>
    </table>
         </div>              
                   </g:each>
                    
                    
                    
                    </div>
                    <div class="buttons">
                        
                            <g:hiddenField name="id" value="${bloodInstance?.id}" />
                            <g:if test="${canModify && bloodInstance.dateSubmitted}">
                            <span class="button"><g:actionSubmit class="edit" action="resume" value="Resume Editing" /></span>
                            </g:if>
                          
                       
                    </div>
                     </g:form>
            </div>
    </body>
</html>
