
<%@ page import="nci.bbrb.cdr.forms.TherapyRecord" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'therapyRecord.label', default: 'TherapyRecord')}" />
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
                                    
                                        <g:sortableColumn property="typeOfTherapy" title="${message(code: 'therapyRecord.typeOfTherapy.label', default: 'Type Of Therapy')}" />
                                        
                                        <g:sortableColumn property="descTherapy" title="${message(code: 'therapyRecord.descTherapy.label', default: 'Desc Therapy')}" />
                                        
                                        <g:sortableColumn property="therapyDate" title="${message(code: 'therapyRecord.therapyDate.label', default: 'Therapy Date')}" />
                                        
                                        <g:sortableColumn property="howLongAgo" title="${message(code: 'therapyRecord.howLongAgo.label', default: 'How Long Ago')}" />
                                        
                                        <g:sortableColumn property="hbcForm" title="${message(code: 'therapyRecord.hbcForm.label', default: 'Hbc Form')}" />
                                        
                                        <g:sortableColumn property="specOtherHBCForm" title="${message(code: 'therapyRecord.specOtherHBCForm.label', default: 'Spec Other HBCF orm')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${therapyRecordInstanceList}" status="i" var="therapyRecordInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${therapyRecordInstance.id}">${fieldValue(bean: therapyRecordInstance, field: "typeOfTherapy")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: therapyRecordInstance, field: "descTherapy")}</td>
                                        
                                        <td><g:formatDate date="${therapyRecordInstance.therapyDate}" /></td>
                                        
                                        <td>${fieldValue(bean: therapyRecordInstance, field: "howLongAgo")}</td>
                                        
                                        <td>${fieldValue(bean: therapyRecordInstance, field: "hbcForm")}</td>
                                        
                                        <td>${fieldValue(bean: therapyRecordInstance, field: "specOtherHBCForm")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${therapyRecordInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
