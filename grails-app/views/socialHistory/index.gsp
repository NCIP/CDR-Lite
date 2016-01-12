
<%@ page import="nci.bbrb.cdr.forms.SocialHistory" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'socialHistory.label', default: 'SocialHistory')}" />
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
                                    
                                    <th><g:message code="socialHistory.candidateRecord.label" default="Candidate Record" /></th>
                                        
                                        <g:sortableColumn property="alcoholConsum" title="${message(code: 'socialHistory.alcoholConsum.label', default: 'Alcohol Consum')}" />
                                        
                                        <g:sortableColumn property="numYrsAlcCon" title="${message(code: 'socialHistory.numYrsAlcCon.label', default: 'Num Yrs Alc Con')}" />
                                        
                                        <g:sortableColumn property="tobaccoSmHist" title="${message(code: 'socialHistory.tobaccoSmHist.label', default: 'Tobacco Sm Hist')}" />
                                        
                                        <g:sortableColumn property="smokeAgeStart" title="${message(code: 'socialHistory.smokeAgeStart.label', default: 'Smoke Age Start')}" />
                                        
                                        <g:sortableColumn property="smokeAgeStop" title="${message(code: 'socialHistory.smokeAgeStop.label', default: 'Smoke Age Stop')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${socialHistoryInstanceList}" status="i" var="socialHistoryInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${socialHistoryInstance.id}">${fieldValue(bean: socialHistoryInstance, field: "candidateRecord")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: socialHistoryInstance, field: "alcoholConsum")}</td>
                                        
                                        <td>${fieldValue(bean: socialHistoryInstance, field: "numYrsAlcCon")}</td>
                                        
                                        <td>${fieldValue(bean: socialHistoryInstance, field: "tobaccoSmHist")}</td>
                                        
                                        <td>${fieldValue(bean: socialHistoryInstance, field: "smokeAgeStart")}</td>
                                        
                                        <td>${fieldValue(bean: socialHistoryInstance, field: "smokeAgeStop")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${socialHistoryInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
