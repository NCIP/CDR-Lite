<%@ page import="nci.bbrb.cdr.datarecords.SlideRecord" %>

<div class="dialog">
    <table>
        <tbody>

       <%-- <tr class="prop">
            <td valign="top" class="name">
                <label for="specimenRecord"><g:message code="slideRecord.specimenRecord.label" default="Specimen Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideRecordInstance, field: 'specimenRecord', 'error')}">
                <g:select id="specimenRecord" name="specimenRecord.id" from="${nci.bbrb.cdr.datarecords.SpecimenRecord.list()}" optionKey="id" required="" value="${slideRecordInstance?.specimenRecord?.id}" class="many-to-one"/>
            </td>
        </tr> --%>
        
         <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.specimenRecord.label" default="Specimen Record" /></td>
                            
                            <td valign="top" class="value"><g:link controller="specimenRecord" action="show" id="${slideRecordInstance?.specimenRecord?.id}">${slideRecordInstance?.specimenRecord?.specimenId.encodeAsHTML()}</g:link></td>
                            
         </tr>

      <%--  <tr class="prop">
            <td valign="top" class="name">
                <label for="imageRecord"><g:message code="slideRecord.imageRecord.label" default="Image Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideRecordInstance, field: 'imageRecord', 'error')}">
                <g:select id="imageRecord" name="imageRecord.id" from="${nci.bbrb.cdr.datarecords.ImageRecord.list()}" optionKey="id" value="${slideRecordInstance?.imageRecord?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        </tr> --%>
        
      <%--  <tr class="prop">
            <td valign="top" class="name">
                <label for="prcReview"><g:message code="slideRecord.prcReview.label" default="Prc Review" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideRecordInstance, field: 'prcReview', 'error')}">
                <g:select id="prcReview" name="prcReview.id" from="${nci.bbrb.cdr.prc.PrcReview.list()}" optionKey="id" value="${slideRecordInstance?.prcReview?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        </tr> --%>
        
       <%-- <tr class="prop">
            <td valign="top" class="name">
                <label for="processEvents"><g:message code="slideRecord.processEvents.label" default="Process Events" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideRecordInstance, field: 'processEvents', 'error')}">
                <g:select name="processEvents" from="${nci.bbrb.cdr.datarecords.ProcessingEvent.list()}" multiple="multiple" optionKey="id" size="5" value="${slideRecordInstance?.processEvents*.id}" class="many-to-many"/>
            </td>
        </tr>--%>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="slideId"><g:message code="slideRecord.slideId.label" default="Slide Id" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideRecordInstance, field: 'slideId', 'error')}">
                <g:textField name="slideId" required="" value="${slideRecordInstance?.slideId}"/>
            </td>
        </tr>

        </tbody>
    </table>
</div>  
