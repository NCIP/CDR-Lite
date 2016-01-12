<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<%@ page import="nci.bbrb.cdr.util.FileUpload" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'caseRecord.label', default: 'Case Record')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            </div>
        </div>

        <div id="container" class="clearfix">
            <h1>Show Case Record Details for ${caseRecordInstance.caseId} </h1>
            <g:if test="${flash.message}">
                <g:if test="${flash.message.toLowerCase().startsWith('sorry')|| flash.message.toLowerCase().startsWith('error')}">
                    <div id="pageErrs" class="errors"><font color="red"><b>${flash.message}</b></font></div>
                </g:if>
                <g:else>
                    <div class="message" role="status">${flash.message}</div>
                </g:else>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.caseId.label" default="Case Id" /></td>
                            <td valign="top" class="value">${fieldValue(bean: caseRecordInstance, field: "caseId")}
                                <g:if test="${showEdit}">
                                    <g:link controller="caseRecord" action="edit" params="['id': caseRecordInstance.id]" >(Edit)</g:link>
                                </g:if>
                            </td>
                        </tr>       

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.caseCollectionType.label" default="Collection Type" /></td>
                            <td valign="top" class="value">${caseRecordInstance?.caseCollectionType?.encodeAsHTML()}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.caseStatus.label" default="Case Status" /></td>
                            <td valign="top" class="value">${caseRecordInstance?.caseStatus?.encodeAsHTML()}
                                <g:if test="${showChangeStatus}">
                                    <g:link controller="caseRecord" action="changeCaseStatus" id="${caseRecordInstance?.id}">(Change)</g:link>
                                </g:if>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.study.label" default="Study" /></td>
                            <td valign="top" class="value">${caseRecordInstance?.study?.encodeAsHTML()}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.bss.label" default="BSS" /></td>
                            <td valign="top" class="value"><g:link controller="BSS" action="show" id="${caseRecordInstance?.bss?.id}">${caseRecordInstance?.bss?.encodeAsHTML()}</g:link></td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.primaryTissueType.label" default="Primary Organ" /></td>
                            <td valign="top" class="value">${caseRecordInstance?.primaryTissueType?.encodeAsHTML()}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.candidateRecord.label" default="Candidate Record ID" /></td>
                            <td valign="top" class="value"><g:link controller="candidateRecord" action="show" id="${caseRecordInstance?.candidateRecord?.id}">${caseRecordInstance?.candidateRecord?.candidateId}</g:link></td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.dateCreated.label" default="Date Created" /></td>
                            <td valign="top" class="value"><g:formatDate date="${caseRecordInstance?.dateCreated}" /></td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caseRecord.lastUpdated.label" default="Last Updated" /></td>
                            <td valign="top" class="value"><g:formatDate date="${caseRecordInstance?.lastUpdated}" /></td>
                        </tr>

                        <tr class="prop"><td valign="top" class="name formheader" colspan="3">Uploaded Files:</td></tr>
                        <tr>
                            <td valign="top" class="value" colspan="3">
                                <g:if test="${FileUpload.findAll('from FileUpload as f where f.caseId=?', [caseRecordInstance?.caseId])}">
                                    <div class="list">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>File Name</th>
                                                    <th>Date Uploaded</th>
                                                    <th>Category</th>
                                                   
                                            <th>Comments</th>
                                                <g:if test="${session.DM}">
                                                <th>Action</th>
                                                </g:if>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <g:each in="${FileUpload.findAll('from FileUpload as f where f.caseId=?', [caseRecordInstance?.caseId])}" status="i" var="fileUploadInstance">
                                                  
                                                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                                            <td><g:link controller="fileUpload" action="download" id="${fileUploadInstance.id}">${fileUploadInstance.fileName}</g:link></td>
                                                            <td><nobr>${fileUploadInstance.uploadTime}</nobr></td>
                                                            <td><nobr>${fileUploadInstance.category}</nobr></td>
                                                           
                                                            <td class="unlimitedstr"><div>${fieldValue(bean: fileUploadInstance, field: "comments")}</div></td>
                                                            <g:if test="${session.DM}">
                                                              <td nowrap>
                                                        <!--  <g:link controller="fileUpload" action="remove" id="${fileUploadInstance.id}" onclick="return confirm('Are you sure to remove the file?')">Remove</g:link> -->

                                                             <%-- <g:if test="${(fileUploadInstance?.bss?.code?.equals(session.org.code) || session.org.code == 'DCC' ) }"> --%>
                                                                  <g:if test="${session.DM && ((caseRecordInstance?.caseStatus?.code == 'INIT' || caseRecordInstance?.caseStatus?.code == 'DATA'  || caseRecordInstance?.caseStatus?.code == 'REMED') ||(caseRecordInstance?.caseStatus?.code == 'QA' && session.org?.code=='DCC'))}">
                                                                <g:link class="ui-button ui-state-default ui-corner-all removepadding" title="edit" controller="fileUpload" action="edit" id="${fileUploadInstance.id}" ><span class="ui-icon ui-icon-pencil">Edit</span></g:link>
                                                                <g:link class="ui-button ui-state-default ui-corner-all removepadding" title="delete" controller="fileUpload" action="delete" id="${fileUploadInstance.id}" onclick="return confirm('Are you sure to remove the file?')"><span class="ui-icon ui-icon-trash">Remove</span></g:link>
                                                              </g:if>
                                                              </td>
                                                            </g:if>
                                                        </tr>
                                                   
                                                </g:each>
                                            </tbody>
                                        </table>
                                    </div>
                                </g:if>
                                <g:if test="${session.DM}">
                                    <a class="uibutton" href="/cdrlite/fileUpload/create?caseRecord.id=${caseRecordInstance.id}" title="Upload case documents" />
                                    <span class="ui-icon ui-icon-circle-arrow-n left"></span>Upload
                                    </a>
                                </g:if>
                            </td>
                        </tr>

                        <g:render template="/caseRecord/showcrfstatus" bean="${caseRecordInstance}" />
                        <g:if test="${caseRecordInstance.specimens.size() != 0  }">
                            <tr class="prop">
                                <td valign="top" class="name formheader" colspan="3">Specimens (${caseRecordInstance.specimens.size()}):  
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="value" colspan="3"> 
                                    <div class="list">
                                        <table class="nowrap">
                                            <thead>
                                                <tr>
                                                    <th>Specimen Id</th>              
                                                    <th>Tissue Type</th>        
                                                    <th>Fixative</th>
                                                    <th>Slides</th>
                                                    <th>PRC Report</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <g:each in="${caseRecordInstance.specimens.sort{it.specimenId}}" status="i" var="s">
                                                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="${s.specimenId.toUpperCase()}">
                                                        <td class="itemid"><g:link action="show" controller="specimenRecord" id="${s.id}">${s.specimenId}</g:link></td>
                                                        <td>${s.tissueType}</td>
                                                        <td>${s.fixative}</td>
                                                        <td nowrap="nowrap">
                                                <g:each in="${s.slides?.sort{it.id}}" var="sl" status="l">
                                                    <g:link controller="slideRecord" action="show" id="${sl.id}">${sl.slideId}</g:link>
                                                        <br />
                                                </g:each>
                                                </td>
                                                   <td nowrap="nowrap">
                                                         <g:each in="${s.slides?.sort{it.id}}" var="sl" status="l">
                                                          
                                                                <span style="line-height:20px;">
                                                                    <g:if test="${!sl.prcReport}">
                                                                        <span class="no"></span>
                                                                    </g:if>
                                                                    <g:elseif test="${sl.prcReport.status == 'Editing'}">
                                                                        <span class="incomplete">In Progress</span>
                                                                    </g:elseif>
                                                                    <g:else>
                                                                        <span class="yes">Completed</span>
                                                                        <g:link controller="prcReport" action="view" id="${sl.prcReport.id}">(View)</g:link>
                                                                    </g:else>
                                                                    <br />
                                                                </span>
                                                           
                                                        </g:each>
                                                    </td>
                                                    </tr>
                                                </g:each>
                                            </g:if>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <%--
                <g:form url="[resource:caseRecordInstance, action:'edit']" method="POST" >
                    <fieldset class="buttons">
                        <g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
                    </fieldset>
                </g:form>--%>
            </div>
        </div>
    </div>
</body>
</html>
