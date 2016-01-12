<%@ page import="nci.bbrb.cdr.prc.PrcReport" %>
<%@ page import="nci.bbrb.cdr.util.AppSetting" %>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'prcReport.label', default: 'PrcReport')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
         
    </head>
	<body>
		<div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                       </div>
                       </div>

		 <div id="container" class="clearfix">
			<h1>View PRC Report</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			 
                        <g:hasErrors bean="${prcReportInstance}">
                        <div class="errors">
                           <g:renderErrors bean="${prcReportInstance}" as="list" />
                          </div>
                         </g:hasErrors>
                        
                 <g:render template="/caseRecord/caseDetails" bean="${prcReportInstance.slideRecord.specimenRecord.caseRecord}" var="caseRecord" /> 
                 <g:form url="[resource:prcReportInstance, action:'startnew']" method="POST" >
                  <fieldset class="form">
                   <div class="list">        
		 <table class="tdwrap">
                    <tbody>

                         <g:if test="${prcReportInstance.submittedBy}">
                        <tr>
                             <td valign="top" class="name">Date report submitted</td>
                             <td class="value"><g:formatDate format="MM/dd/yyyy" date="${prcReportInstance.dateSubmitted}"/></td>
                         </tr>    
                         <tr>
                            <td valign="top" class="name">Report submitted by</td> 
                            <td class="value">${prcReportInstance.submittedBy}</td>
                          </tr>
                    
                     </g:if>
                        
                      <tr class="prop">
                        <td valign="top" class="name">
                            <label for="slideRecord"><g:message code="prcReport.slideRecord.label" default="Slide record" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'slideRecord', 'errors')}">
                         <g:link controller="slideRecord" action="show" id="${prcReportInstance?.slideRecord?.id}">   ${prcReportInstance?.slideRecord?.slideId}</g:link>

                        </td>
                    </tr>
                    
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="slideRecord">Block ID</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'slideRecord', 'errors')}">
                         <g:link controller="specimenRecord" action="show" id="${prcReportInstance?.slideRecord?.specimenRecord.id}">   ${prcReportInstance?.slideRecord?.specimenRecord.specimenId}</g:link>

                        </td>
                    </tr>

                    
                    
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="organOrigin"><g:message code="prcReport.organOrigin.label" default="Organ origin" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'organOrigin', 'errors')}">
                            ${prcReportInstance?.organOrigin?.name}
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="tissueCategory"><g:message code="prcReport.tissueCategory.label" default="Tissue category" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'tissueCategory', 'errors')}">
                           ${prcReportInstance?.tissueCategory?.name} 

                        </td>
                    </tr>
                    
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="diagnosis">Diagnosis/Morphology </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'diagnosis', 'errors')}">
                           ${prcReportInstance?.diagnosis}

                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="autolysis">Autolysis rating</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'autolysis', 'errors')}">
                            <div>
                                ${prcReportInstance.autolysis}
                          </div>    

                        </td>
                    </tr>


                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="comments"><g:message code="prcReport.comments.label" default="Comments" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'comments', 'errors')}">
                            ${prcReportInstance?.comments}
                        </td>
                    </tr>

          
                   <g:if test="${prcReportInstance?.tissueCategory?.code=='TUMOR'}">
                    <tr class="prop tumor" >
                        <td valign="top" class="name">
                            <label for="tumorDimension">Greatest tumor dimension on slide</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'tumorDimension', 'errors')}">
                            ${fieldValue(bean: prcReportInstance, field: 'tumorDimension')} (mm)

                        </td>
                    </tr>


                    <tr class="prop tumor">
                        <td valign="top" class="name">
                            <label for="pctTumorArea">Percent of cross-sectional surface area of entire slide composed of tumor focus</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'pctTumorArea', 'errors')}">
                            ${fieldValue(bean: prcReportInstance, field: 'pctTumorArea')} %

                        </td>
                    </tr>


                    <tr class="prop tumor" >
                        <td valign="top" class="name">
                            <label for="pctTumorCellularity">Percent of tumor nuclei by cell count of the entire slide </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'pctTumorCellularity', 'errors')}">
                            ${fieldValue(bean: prcReportInstance, field: 'pctTumorCellularity')} %

                        </td>
                    </tr>

                   
                    <tr class="prop tumor" >
                        <td valign="top" class="name">
                            <label for="pctNecroticTissue">Percent of cross-sectional surface area of entire slide composed of necrotic tissue</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'pctNecroticTissue', 'errors')}">
                           ${fieldValue(bean: prcReportInstance, field: 'pctNecroticTissue')} %

                        </td>
                    </tr>

                     <tr class="tumor" ><td class="name formheader" colspan="2">Histologic profile quantitative assessment</td></tr>
                     <tr class="tumor"><td colspan="2">
                     <table class="formvaluediv">
                                                <tr>
                                                    <td >Percent viable tumor by surface area (not including stroma)</td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctViablTumor', 'errors')}" style=" width:25%">${fieldValue(bean: prcReportInstance, field: 'pctViablTumor')} %</td>
                                                </tr>
                                                <tr>
                                                    <td >Percent necrotic tumor by surface area</td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctNecroticTumor', 'errors')}" >${fieldValue(bean: prcReportInstance, field: 'pctNecroticTumor')} %</td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                        Percent tumor stroma by surface area
                                                    </td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctViableNonTumor', 'errors')}" >${fieldValue(bean: prcReportInstance, field: 'pctViableNonTumor')} %</td>
                                                </tr>
                                                <tr>
                                                    <td>Percent Non-Cellular component by surface area (i.e., mucin, hemorrhage, blood clot, etc.)</td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctNonCellular', 'errors')}">${fieldValue(bean: prcReportInstance, field: 'pctNonCellular')} %</td>
                                                </tr>
                                                <tr>
                                                    <td class="formheader">Histologic profile total % (should equal 100%)</td>
                                                    <td class="formheader ${hasErrors(bean: prcReportInstance, field: 'hisTotal', 'errors')}">${fieldValue(bean: prcReportInstance, field: 'hisTotal')} %</td>
                                                </tr> 
                                            </table>
                                        </td> 
                                   </tr>
                          </g:if>
                    </tbody>
                </table>
                     
                  </div>  
		</fieldset> 
                  
                  
                  
                   <g:if test="${prcReportInstance.status == 'Submitted'}">
                   <g:if test="${session.authorities.contains('ROLE_PRC') || session.getAttribute('PRC')}">
                      <div class="buttons">
                       
                        <span class="button"><g:actionSubmit class="save" action="startnew" value="Start Next Version"  onclick="return confirm('Are you sure you want to create a new version of the PRC Report?')" /></span>
                            

                      </div>
                     
                   </g:if>
                  </g:if>
                  
                   
                  
			</g:form>
		</div>
	</body>
</html>
