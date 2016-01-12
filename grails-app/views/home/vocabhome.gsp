<g:set var="bodyclass" value="vocabhome" scope="request"/>
<html>
    <head>
        <title><g:message code="default.page.title"/> - Vocabulary and Configuration</title>
        <meta name="layout" content="cahubTemplate" />
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">

                <g:if test="${session.authorities.contains('ROLE_ADMIN')}">
                    <span class="menuButton"><g:link controller="backoffice" class="list" action="index">Back Office</g:link></span> 
                </g:if> 


                <g:if test="${session.org.code == 'DCC' && session.DM == true}">
                    <a class="home"  href="${createLink(uri: '/home/opshome')}">DM Home</a>
                </g:if>



            </div>
        </div>
        <div id="container" class="clearfix">
            <h1>CDR-Lite Data Services Vocabulary and Configuration</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th>Controlled Vocabulary</th>
                            <th>Description </th>
                        </tr>
                    </thead>

                    <tr class="odd">                    
                        <td>
                            <span class="controller"><a href="/cdrlite/activityType/">Activity Type</a></span>
                        </td>

                        <td>
                            <span class="name">Define case related activity type codes </span>
                        </td>

                    </tr>
                    <tr class="even">                    

                        <td>
                            <span class="controller"><a href="/cdrlite/bloodDrawType/">Blood Draw Type</a></span>
                        </td>
                        <td>
                            <span class="name">Define blood draw types </span>
                        </td>

                    </tr>


                    <tr class="odd">                    

                        <td>
                            <span class="controller"><a href="/cdrlite/bloodCollectionReason/">Blood Collection Reason</a></span>
                        </td>
                        <td>
                            <span class="name">Define blood blood collection reasons </span>
                        </td>
                    </tr>

                    <tr class="even">                    

                        <td>
                            <span class="controller"><a href="/cdrlite/bloodTubeType/">Blood Tube Type</a></span>
                        </td>
                        <td>
                            <span class="name">Define blood tube types </span>
                        </td>
                    </tr>


                    <tr class="odd">                    
                        <td>
                            <span class="controller"><a href="/cdrlite/bloodAliquotType/">Blood Aliquot</a></span>
                        </td>

                        <td>
                            <span class="name">Define blood aliquots types </span>
                        </td>

                    </tr>

                    <tr class="even">                    
                        <td>
                            <span class="controller"><a href="/cdrlite/bloodDrawTech/">Blood Draw Tech</a></span>
                        </td>

                        <td>
                            <span class="name">Define  blood draw technician codes </span>
                        </td>

                    </tr>

                    <tr class="odd">

                        <td>
                            <span class="controller"><a href="/cdrlite/BSS/">BSS List</a></span>
                        </td>

                        <td>
                            <span class="name">Biospecimen source sites </span>
                        </td>

                    </tr>

                    <tr class="even">

                        <td>
                            <span class="controller"><a href="/cdrlite/caseAttachmentType/">Case Attachment Type</a></span>
                        </td>
                        <td>
                            <span class="name">Define types of case attachment used in file uploads </span>
                        </td>

                    </tr>

                    <tr class="odd">

                        <td>
                            <span class="controller"><a href="/cdrlite/caseCollectionType/">Case Collection Type</a></span>
                        </td>
                        <td>
                            <span class="name">Case collection types </span>
                        </td>
                    </tr>


                    <tr class="even">


                        <td>
                            <span class="controller"><a href="/cdrlite/caseStatus/">Case Status</a></span>
                        </td>

                        <td>
                            <span class="name">Define case status </span>
                        </td>
                    </tr>





                    <tr class="odd">

                        <td>
                            <span class="controller"><a href="/cdrlite/containerType/">Container Type</a></span>
                        </td>

                        <td>
                            <span class="name">Define containers used in tissue/Blood collections </span>
                        </td>
                    </tr>



                    <tr class="even">

                        <td>
                            <span class="controller"><a href="/cdrlite/fixative/">Fixatives</a></span>
                        </td>
                        <td>
                            <span class="name">Define fixatives used to store tissues specimens </span>
                        </td>
                    </tr>

                    <tr class="odd">                      

                        <td>
                            <span class="controller"><a href="/cdrlite/organization/">Organization</a></span>
                        </td>
                        <td>
                            <span class="name">Define Organizations using CDR-Lite </span>
                        </td>
                    </tr>
                    <tr class="even">                    
                        <td>
                            <span class="controller"><a href="/cdrlite/queryStatus/">Query Status</a></span>
                        </td>

                        <td>
                            <span class="name">Query status codes </span>
                        </td>

                    </tr>


                    <tr class="odd">                    

                        <td>
                            <span class="controller"><a href="/cdrlite/queryType/">Query Type</a></span>
                        </td>

                        <td>
                            <span class="name">Define query types </span>
                        </td>
                    </tr>


                    <tr class="even">                    
                        <td>
                            <span class="controller"><a href="/cdrlite/storageTemp/">Storage Temp</a></span>
                        </td>

                        <td>
                            <span class="name">Define various storage temparatures used  </span>
                        </td>

                    </tr>
                    <tr class="odd">                    

                        <td>
                            <span class="controller"><a href="/cdrlite/study/">Study</a></span>
                        </td>

                        <td>
                            <span class="name">Define study types </span>
                        </td>
                    </tr>

                    <tr class="even">

                        <td>
                            <span class="controller"><a href="/cdrlite/tissueType/">Tissue Type</a></span>
                        </td>

                        <td>
                            <span class="name">Define tissue type codes </span>
                        </td>
                    </tr>

                    <tr class="odd">                    
                        <td>
                            <span class="controller"><a href="/cdrlite/tissueLocation/">Tissue Location</a></span>
                        </td>

                        <td>
                            <span class="name">Define specific location for tissue types </span>
                        </td>

                    </tr>


                    <tr class="even">                    

                        <td>
                            <span class="controller"><a href="/cdrlite/tissueCategory/">Tissue Category</a></span>
                        </td>

                        <td>
                            <span class="name">Define tissue category </span>
                        </td>
                    </tr>


                </table>                  


            </div>
        </div>
    </body>
</html>

