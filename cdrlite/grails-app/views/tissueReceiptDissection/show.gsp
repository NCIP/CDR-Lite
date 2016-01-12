
<%@ page import="nci.bbrb.cdr.forms.TissueReceiptDissection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'tissueReceiptDissection.label', default: 'Tissue Receipt and Dissection Form')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
      
    <g:set var="canModify" value="${session.DM == true }" />
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            </div>
        </div>

        <div id="container" class="clearfix">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
              <g:render template="/caseRecord/caseDetails" bean="${tissueReceiptDissectionInstance.caseRecord}" var="caseRecord" />
            <div class="dialog">
                <table>
                    <tbody>
                        <tr id="sopGuidanceSectionTitle" >
                            <td colspan="2" class="formheader">Receipt and dissection of surgical tissue are expected to conform to the Surgical Tissue Collection and Processing SOP. <br/>
                            Please specify any deviation(s) from the SOP in the Comments fields at the bottom of each section.</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">1. SOP governing receipt and dissection of surgical tissue in the Tissue Bank</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "receiptDissectSOP")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">2. Date and time tissue specimens were received in Tissue Bank from the Pathology Gross Room</td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tissueReceiptDissectionInstance?.dateTimeTissueReceived}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">3. Tissue specimens were received in Tissue Bank from the Pathology Gross Room by: (name)</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "tissueRecipient")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">4. Comments/issues with tissue receipt or deviation(s) from SOP</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "tissueReceiptComment")}</td>
                            
                        </tr>
                    
                        <tr id="moduleOneSectionTitle" >
                            <td colspan="2" class="formheader">Tumor Tissue Specimen Dissection Information. Note any deviation(s) from Surgical Tissue Collection and Preservation SOP in the Comments field at 
                            the bottom of this section. </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">5. Dissection of gross tissue specimen was performed by</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "parentTissueDissectedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">6. Time dissection of gross tissue specimen began</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "parentTissueDissectBegan")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">7. Time dissection of gross tissue specimen ended</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "parentTissueDissectEnded")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">8. Gross appearance of gross tissue specimen as determined in Pathology Gross Room</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "grossAppearance")}</td>
                            
                        </tr>
                        
                        <g:if test="${tissueReceiptDissectionInstance.otherGrossAppearance}">
                        <tr class="prop">
                            <td valign="top" class="name">Other Gross Appearance of specimen</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "otherGrossAppearance")}</td>
                            
                        </tr>
                        </g:if>
                        
                    
                        <tr class="prop">
                            <td valign="top" class="name">9. Source of tumor tissue</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "tumorSource")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">10. Tissue collection procedure</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "collectionProcedure")}</td>
                            
                        </tr>
                    
                        <g:if test="${tissueReceiptDissectionInstance.otherCollectionProcedure}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tissueReceiptDissection.otherCollectionProcedure.label" default="Other Collection Procedure" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "otherCollectionProcedure")}</td>
                            
                        </tr>
                        </g:if>
                        
                        <tr id="fixativeSectionTitle">
                            <td colspan="2" class="formheader">Required Study Tissue</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">11.&nbsp;<g:message code="tissueReceiptDissection.fixativeType.label" default="Fixative Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativeType")}</td>
                            
                        </tr>
                    
                        <g:if test="${tissueReceiptDissectionInstance.otherFixativeType}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tissueReceiptDissection.otherFixativeType.label" default="Other Fixative Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "otherFixativeType")}</td>
                            
                        </tr>
                        </g:if>
                                            
                        <tr class="prop">
                            <td valign="top" class="name">12.&nbsp;<g:message code="tissueReceiptDissection.fixativeFormula.label" default="Fixative Formula" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativeFormula")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">13.&nbsp;<g:message code="tissueReceiptDissection.fixativePH.label" default="Fixative pH" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativePH")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">14.Manufacturer of fixative</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativeManufacturer")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">15.&nbsp;<g:message code="tissueReceiptDissection.fixativeLotNum.label" default="Fixative Lot Num" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativeLotNum")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">16.&nbsp;<g:message code="tissueReceiptDissection.dateFixativeLotNumExpired.label" default="Date Fixative Lot Num Expired" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tissueReceiptDissectionInstance?.dateFixativeLotNumExpired}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">17.&nbsp;<g:message code="tissueReceiptDissection.fixativeProductNum.label" default="Fixative Product Num" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativeProductNum")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">18. Is fixative a commercial product or prepared in-house</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "fixativeProductType")}</td>
                            
                        </tr>
                    
                        <g:if test="${tissueReceiptDissectionInstance.otherFixativeProductType}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tissueReceiptDissection.otherFixativeProductType.label" default="Other Fixative Product Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "otherFixativeProductType")}</td>
                            
                        </tr>
                        </g:if>
                        
                        <tr class="prop">
                            <td valign="top" class="name">19. Comments/issues with tissue fixation or deviation(s) from SOP</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tissueReceiptDissectionInstance, field: "parentTissueSopComment")}</td>
                            
                        </tr>
                    
 
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:tissueReceiptDissectionInstance, action:'resumeEditing']" method="POST" >
                            <g:hiddenField name="id" value="${tissueReceiptDissectionInstance?.id}" />
                             <g:if test="${canModify}">
                            <span class="button"><g:actionSubmit class="edit" action="resumeEditing"  value="${message(code: 'default.button.resumeedit.label', default: 'Resume Edit')}" /></span>
                            </g:if>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
