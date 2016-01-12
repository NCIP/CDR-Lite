<%@ page import="nci.bbrb.cdr.util.AppSetting" %>

<table>
   <thead>
      <tr><th colspan="6">${session.study?.code} Case List</th></tr>
      <tr>
          <th>Case ID</th> 
          <th>Primary Organ</th>  
          <th>Case Status</th>
           <th>Specimen ID</th>
          <th>Slide Id</th>
          <th>PRC Report</th>
      </tr>
  </thead><tbody>
   <g:if test="${caseList}">
     <g:each in="${caseList}" status="i" var="c">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" >
        <td rowspan="${c.slides?.size() == 0 ? 1 : c.slides?.size()}"><g:link controller="caseRecord" action="display" id="${c.id}">${c.caseId}</g:link></td>
        <td rowspan="${c.slides?.size() == 0 ? 1 : c.slides?.size()}">${c.primaryOrgan}</td>
        <td rowspan="${c.slides?.size() == 0 ? 1 : c.slides?.size()}"><span class="ca-tooltip-nobg home-case-status" data-msg="<b>${c.status}</b>. ${c.statusdesc}">${c.status}</span></td>
    <g:if test="${c.slides?.size() > 0}">
     <g:each in="${c.slides}" var="sl" status="j">
       <g:if test="${j==0}">
         <td>${sl.specimenRecord?.specimenId}</td>
        <td>${sl.slideId}</td>
        
       <g:if test="${(session.authorities.contains('ROLE_PRC') || session.getAttribute('PRC'))}">
              <g:if test ="${sl.prcReport!= null && sl.prcReport.status=='Editing'}">
                 <td><g:link controller="prcReport" action="edit" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_edit1.png" title="Edit PRC report"/></g:link>&nbsp;<g:link controller="prcReport" action="view" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_view1.png" title="View PRC report" /></g:link></td>
              </g:if>
             
               
              <g:elseif test ="${sl.prcReport!= null && sl.prcReport.status=='Submitted'}">
                  <td><g:link controller="prcReport" action="view" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_view1.png" title="View PRC report" /></g:link></td> 
              </g:elseif>
              
              <g:elseif test="${sl.prcReport== null}">
                 <td><a href="/cdrlite/prcReport/save?slideRecord.id=${sl.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_add2.png" title="Create PRC report" /></a></td>
               </g:elseif>
              
              <g:else>
                <td>report</td>
              </g:else>
              
              </g:if>
             <g:else>
               <g:if test ="${sl.prcReport!= null}">
                  <td><g:link controller="prcReport" action="view" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_view1.png" title="View PRC report" /></g:link></td>
               </g:if>
               
               <g:else>
               <td>&nbsp;</td>
               </g:else>
               
             </g:else>
        </g:if>
    </g:each>
      </g:if><g:else><td>&nbsp;</td><td>&nbsp</td><td>&nbsp</td></g:else>
   </tr>
   <g:each in="${c.slides}" var="sl" status="j">
      <g:if test="${j > 0}">
         <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td>${sl.specimenRecord?.specimenId}</td>
           <td>${sl.slideId}</td>
            
           <g:if test="${(session.authorities.contains('ROLE_PRC') || session.getAttribute('PRC'))}">
              <g:if test ="${sl.prcReport!= null && sl.prcReport.status=='Editing'}">
                 <td><g:link controller="prcReport" action="edit" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_edit1.png" title="Edit PRC report"/></g:link>&nbsp;<g:link controller="prcReport" action="view" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_view1.png" title="View PRC report" /></g:link></td>
              </g:if>
             
               
              <g:elseif test ="${sl.prcReport!= null && sl.prcReport.status=='Submitted'}">
                  <td><g:link controller="prcReport" action="view" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_view1.png" title="View PRC report" /></g:link></td> 
              </g:elseif>
              
              <g:elseif test="${sl.prcReport== null}">
                 <td><a href="/cdrlite/prcReport/save?slideRecord.id=${sl.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_add2.png" title="Create PRC report" /></a></td>
               </g:elseif>
               <g:elseif test="${sl.prcReport== null}">
                 <td><img height="13" width="13" border="0" src="/cdrlite/images/prc_add1.png" title="Create PRC report" /></td>
               </g:elseif>
              <g:else>
                <td>report</td>
              </g:else>
              
              </g:if>
             <g:else>
               <g:if test ="${sl.prcReport!= null}">
                  <td><g:link controller="prcReport" action="view" id="${sl.prcReport.id}"><img height="13" width="13" border="0" src="/cdrlite/images/prc_view1.png" title="View PRC report" /></g:link></td>
               </g:if>
               
               <g:else>
               <td>&nbsp;</td>
               </g:else>
               
             </g:else>
        
         </tr>
       </g:if>
     </g:each>
    </g:each>
   </g:if>
  </tbody>
</table>

 


