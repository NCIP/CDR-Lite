
<%@ page import="nci.bbrb.cdr.forms.HealthHistory" %>
<g:set var="bodyclass" value="healthhistory list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'healthHistory.label', default: 'Health History')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                  
                       </div>
                       </div>
                       <div id="container" class="clearfix"> 
                       <h1>Health History</h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                        <div class="list">
                        <table>
                            <thead>
                                <tr>
                                    
                                       
                                    <th><g:message code="healthHistory.candidateRecord.label" default="Candidate ID" /></th>
                                        
                                        <g:sortableColumn property="source" title="${message(code: 'healthHistory.source.label', default: 'Source')}" />
                                        
                                        <g:sortableColumn property="historyOfCancer" title="${message(code: 'healthHistory.historyOfCancer.label', default: 'History Of Cancer')}" />
                                        
                                        <g:sortableColumn property="dateCreated" title="${message(code: 'healthHistory.dateCreated.label', default: 'Date Created')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:if test="{healthHistoryInstance}">
                                    <tr class="even">                                        
                                                                              
                                       <g:if test="${healthHistoryInstance.candidateRecord} ">
                                        <td>  <a href="/cdrlite/candidateRecord/show/${healthHistoryInstance.candidateRecord?.id}">${healthHistoryInstance.candidateRecord?.candidateId}</a></td>
                                        </g:if>
                                        <g:else>
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "candidateRecord")}</td>
                                        </g:else>
                                        
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "source")}</td>
                                        
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "historyOfCancer")}</td>
                                        
                                        <td><g:formatDate date="${healthHistoryInstance.dateCreated}" /></td>
                                        
                                    </tr>
                                </g:if>
                            </tbody>
                        </table>
                    </div>
                    
                    
          
                    
                    
                    
                   
            </div>
    </body>
</html>
