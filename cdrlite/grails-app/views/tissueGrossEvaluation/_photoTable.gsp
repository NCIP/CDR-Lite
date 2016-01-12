<div id="photoTableDiv">
    <g:if test="${tissueGrossEvaluationInstance.photos}">
        <table>
            <g:each in="${tissueGrossEvaluationInstance.photos}" status="i" var="photo">
                <g:if test="${photo?.rmFlg == null}">
                <tr>
                    <td><g:link controller="tissueGrossEvaluation" action="download" id="${tissueGrossEvaluationInstance.id}" params="[photoId:photo.id]">${photo.fileName}</g:link></td>
                    <td class="photoLink"><g:remoteLink class="deleteOnly button ui-button  ui-state-default ui-corner-all removepadding" controller="tissueGrossEvaluation" update="photoTableDiv" action="remove" id="${tissueGrossEvaluationInstance.id}" params="[photoId:photo.id]" before="if(!confirm('Are you sure to remove the file?')) return false"><span class="ui-icon ui-icon-trash">Delete</span></g:remoteLink></td>
                </tr>
                </g:if>
            </g:each>
        </table>
    </g:if>
</div>

