%{-- <%@ page import="nci.bbrb.cdr.datarecords.ctc.*" %> --}%
<table>
    <tbody>
        <tr class="prop"><td colspan="8"><h2>Case Details</h2></td></tr>
        <tr class="prop">
            <td valign="top">
              <div class="clearfix">
                   <dl class="formdetails left">
                     <dt>Case ID:</dt>
                     <dd>
                       <g:displayCaseRecordLink caseRecord="${caseRecord}" session="${session}" />
                       %{--<g:link controller="caseRecord" action="display" id="${caseRecord.id}">${caseRecord.caseId}</g:link> --}%
                     </dd>
                   </dl>
                 
                    <dl class="formdetails left"><dt>Primary Organ:</dt><dd>${caseRecord.primaryTissueType}</dd></dl>
                
                    <dl class="formdetails left"><dt>BSS:</dt><dd>${caseRecord.bss.name}</dd></dl>
                
                </div>
            </td>
        </tr>      
    </tbody>
</table>
