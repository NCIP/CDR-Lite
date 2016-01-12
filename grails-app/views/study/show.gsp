
<%@ page import="nci.bbrb.cdr.staticmembers.Study" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'study.label', default: 'Study')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1><g:message code="default.show.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div class="dialog">
                        <table>
                            <tbody>
                                
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="study.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: studyInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="study.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: studyInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="study.code.label" default="Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: studyInstance, field: "code")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="study.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: studyInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="study.bssList.label" default="Bss List" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${studyInstance.bssList}" var="b">
                                    <li><g:link controller="BSS" action="show" id="${b.id}">${b?.name.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="study.tissueTypeList.label" default="Tissue Type List" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${studyInstance.tissueTypeList}" var="b">
                                    <li><g:link controller="TissueType" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:studyInstance, action:'edit']" method="POST" >
                            <g:hiddenField name="id" value="${studyInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
