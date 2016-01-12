
<%@ page import="nci.bbrb.cdr.forms.Demographics" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'demographics.label', default: 'Demographics')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>
                       <div id="container" class="clearfix"> 
                       <h1><g:message code="default.list.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                        <div class="list">
                        <table>
                            <thead>
                                <tr>
                                    
                                        <g:sortableColumn property="dateOfBirth" title="${message(code: 'demographics.dateOfBirth.label', default: 'Date Of Birth')}" />
                                        
                                        <g:sortableColumn property="gender" title="${message(code: 'demographics.gender.label', default: 'Gender')}" />
                                        
                                        <g:sortableColumn property="height" title="${message(code: 'demographics.height.label', default: 'Height')}" />
                                        
                                        <g:sortableColumn property="weight" title="${message(code: 'demographics.weight.label', default: 'Weight')}" />
                                        
                                        <g:sortableColumn property="BMI" title="${message(code: 'demographics.BMI.label', default: 'BMI')}" />
                                        
                                        <g:sortableColumn property="race" title="${message(code: 'demographics.race.label', default: 'Race')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${demographicsInstanceList}" status="i" var="demographicsInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${demographicsInstance.id}">${fieldValue(bean: demographicsInstance, field: "dateOfBirth")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: demographicsInstance, field: "gender")}</td>
                                        
                                        <td>${fieldValue(bean: demographicsInstance, field: "height")}</td>
                                        
                                        <td>${fieldValue(bean: demographicsInstance, field: "weight")}</td>
                                        
                                        <td>${fieldValue(bean: demographicsInstance, field: "BMI")}</td>
                                        
                                        <td>${fieldValue(bean: demographicsInstance, field: "race")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${demographicsInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
