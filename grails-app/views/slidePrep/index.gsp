
<%@ page import="nci.bbrb.cdr.forms.SlidePrep" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'slidePrep.label', default: 'SlidePrep')}" />
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
                                    
                                        <g:sortableColumn property="heTimeInOven" title="${message(code: 'slidePrep.heTimeInOven.label', default: 'He Time In Oven')}" />
                                        
                                        <g:sortableColumn property="heTimeInOvenOs" title="${message(code: 'slidePrep.heTimeInOvenOs.label', default: 'He Time In Oven Os')}" />
                                        
                                        <g:sortableColumn property="heOvenTemp" title="${message(code: 'slidePrep.heOvenTemp.label', default: 'He Oven Temp')}" />
                                        
                                        <g:sortableColumn property="heOvenTempOs" title="${message(code: 'slidePrep.heOvenTempOs.label', default: 'He Oven Temp Os')}" />
                                        
                                        <g:sortableColumn property="heDeParrafinMethod" title="${message(code: 'slidePrep.heDeParrafinMethod.label', default: 'He De Parrafin Method')}" />
                                        
                                        <g:sortableColumn property="heDeParrafinMethodOs" title="${message(code: 'slidePrep.heDeParrafinMethodOs.label', default: 'He De Parrafin Method Os')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${slidePrepInstanceList}" status="i" var="slidePrepInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${slidePrepInstance.id}">${fieldValue(bean: slidePrepInstance, field: "heTimeInOven")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: slidePrepInstance, field: "heTimeInOvenOs")}</td>
                                        
                                        <td>${fieldValue(bean: slidePrepInstance, field: "heOvenTemp")}</td>
                                        
                                        <td>${fieldValue(bean: slidePrepInstance, field: "heOvenTempOs")}</td>
                                        
                                        <td>${fieldValue(bean: slidePrepInstance, field: "heDeParrafinMethod")}</td>
                                        
                                        <td>${fieldValue(bean: slidePrepInstance, field: "heDeParrafinMethodOs")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${slidePrepInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
