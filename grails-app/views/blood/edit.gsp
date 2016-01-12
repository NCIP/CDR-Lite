<%@ page import="nci.bbrb.cdr.forms.blood.Blood" %>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'blood.label', default: 'Blood')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
	<body>
		<div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                       </div>
                       </div>

		 <div id="container" class="clearfix">
			<h1>Edit Blood Form</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
                          <g:hasErrors bean="${bloodInstance}">
                        <div class="errors">
                           <g:renderErrors bean="${bloodInstance}" as="list" />
                          </div>
                         </g:hasErrors>
			 <g:render template="/caseRecord/caseDetails" bean="${bloodInstance.caseRecord}" var="caseRecord" /> 
                         <g:form url="[resource:bloodInstance, action:'saveDraw']" method="POST" >  
				<g:hiddenField name="version" value="${bloodInstance?.version}" />
                                <g:hiddenField name="blood.id" value="${bloodInstance?.id}" />
			
                    <div class="dialog">
     <table>
          <tbody>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="caseRecord"><g:message code="blood.caseRecord.label" default="Case Record" /></label>
                </td>
                <td valign="top" class="value errors">
                    ${bloodInstance?.caseRecord?.caseId}


                </td>
            </tr>

        
       
         <g:each in="${bloodInstance?.draws.sort({it.id})}" status="i" var="d">
                    <tr class="prop" >
                        <g:if test="${i==0}">
                        <td valign="top" class="name" rowspan="${bloodInstance?.draws?.size()}">
                            <label for="draws"><g:message code="blood.draws.label" default="Blood draw list" /></label>
                        </td>
                        </g:if>
                       <g:if test="${errorMap.get(d.id +'_draw')=='errors'}">
                        <td valign="top" style='border: 1px solid red;'>
                        </g:if>
                        <g:else>
                             <td valign="top">
                        </g:else>
                          <g:link controller="blood" action="edit_draw" id="${d.id}">Blood Draw (ID: ${d.id})</g:link></li>
 
                        </td>
                    </tr>
        </g:each>

         <tr class="prop">
            <td valign="top" class="name">
                <label for="comments"><g:message code="draw.collectionComments.label" default="Comments" /></label>
            </td>
            <td valign="top" class="value ">
                <g:textArea name="comments" cols="40" rows="5" value="${bloodInstance?.comments}"/>

            </td>
        </tr>
        
   </tbody>
   
    </table>
</div>  

                      
				
				<fieldset class="buttons">
                                    <g:if test="${bloodInstance.draws}">
                                    <g:actionSubmit class="save"  action="saveDraw" value="Add Blood Draw" onclick="return confirm('There is blood draw for this case, are you sure that you want to add another draw?');"/>
                                    </g:if>
                                    <g:else>
                                        <g:actionSubmit class="save"  action="saveDraw" value="Add Blood Draw" />
                                    </g:else>
                                    <g:actionSubmit class="save" action="update" value="Update" />
                                    <g:if test="${canSubmit}">
					<g:actionSubmit class="save" action="submit" value="Submit" />
                                    </g:if>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
