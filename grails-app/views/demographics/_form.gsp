<%@ page import="nci.bbrb.cdr.forms.Demographics" %>
<script type="text/javascript" src="/cdrlite/js/demographic.js"></script>
 <g:render template="/candidateRecord/candidateDetails" bean="${demographicsInstance.candidateRecord}" var="candidateRecord"/>
<div class="dialog">
    <table>
        <tbody>
            
        <tr class="prop"><td></td></tr>
        <tr class="prop"><td></td></tr>
        <input type='hidden' name="candidateRecord.id" value="${ demographicsInstance?.candidateRecord?.id}" />
        <g:hiddenField name="BMI" value="${demographicsInstance?.BMI}" />
        <g:hiddenField name="id" value="${demographicsInstance?.id}" />  

        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateOfBirth">1.&nbsp;<g:message code="demographics.dateOfBirth.label" default="Date Of Birth" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'dateOfBirth', 'error')}">
            <g:jqDatePicker LDSOverlay="${bodyclass ?: ''}" name="dateOfBirth" precision="day" value="${demographicsInstance?.dateOfBirth}"/>     
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="gender">2.&nbsp;<g:message code="demographics.gender.label" default="Gender" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'gender', 'errors')}">
                <div>
                <g:radio name="gender" id='g1' value="Male" checked="${demographicsInstance.gender?.toString() =='Male'}"/>&nbsp;<label for="g1">Male</label>&nbsp;&nbsp;&nbsp;
                <g:radio name="gender" id='g2' value="Female" checked="${demographicsInstance.gender?.toString() =='Female'}"/>&nbsp;<label for="g2">Female</label>&nbsp;&nbsp;&nbsp;
                <g:radio name="gender" id="g4" value="Other" checked="${demographicsInstance.gender?.toString() =='Other'}"/>&nbsp;<label for="g4">Other</label>&nbsp;&nbsp;&nbsp;
                </div>
               
            </td>
        </tr>
        <g:if test="${demographicsInstance?.gender?.name()=='Other'}">
            <tr class="prop" id="other" >
                <td class="name">
                    <label for="gender"><g:message code="demographics.otherGender.lael" default="Specify Other Gender" /></label>
                </td>
                <td class="value ${hasErrors(bean: demographicsInstance, field: 'otherGender', 'errors')}">
                    <g:textField name="otherGender" value="${fieldValue(bean: demographicsInstance, field: 'otherGender')}" /> 
                </td>
            </tr>
        </g:if>
        <g:else>
            <tr class="prop" id="other" style="display:none">
                <td class="name">
                    <label for="gender"><g:message code="demographics.otherGender.label" default="Specify Other Gender" /></label>
                </td>
                <td class="value ${hasErrors(bean: demographicsInstance, field: 'otherGender', 'errors')}">
                    <g:textField name="otherGender" value="${fieldValue(bean: demographicsInstance, field: 'otherGender')}" /> 
                </td>
            </tr>
        </g:else>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="height">3.&nbsp;<g:message code="demographics.height.label" default="Height(in)" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'height', 'errors')}">
                <g:textField name="height" value="${fieldValue(bean: demographicsInstance, field: 'height')}" required=""/>&nbsp;(inches)

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="weight">4. &nbsp;<g:message code="demographics.weight.label" default=" Weight(lbs)" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'weight', 'errors')}">
                <g:textField name="weight" value="${fieldValue(bean: demographicsInstance, field: 'weight')}" required=""/>&nbsp;(lbs)

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="BMI">5.&nbsp;<g:message code="demographics.BMI.label" default="BMI" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'BMI', 'errors')}">
                <span id="bmi" >${fieldValue(bean: demographicsInstance, field: 'BMI')}</span>
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="race">6.&nbsp;<g:message code="demographics.race.label" default="Race" />(choose all that apply)</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'race', 'errors')}">
                <div>
                <g:checkBox name="raceIndian" id="r4" value="${demographicsInstance?.raceIndian}" />&nbsp;<label for="r4">American Indian or Alaska Native </label> <br />
                <g:checkBox name="raceAsian" id="r2" value="${demographicsInstance?.raceAsian}" />&nbsp;<label for="r2">Asian</label> <br />
                <g:checkBox name="raceBlackAmerican" id="r3" value="${demographicsInstance?.raceBlackAmerican}" />&nbsp;<label for="r3">Black or African American</label> <br />                                    
                <g:checkBox name="raceHawaiian" id="r5" value="${demographicsInstance?.raceHawaiian}" />&nbsp;<label for="r5">Native Hawaiian or other Pacific Islander</label> <br />
                <g:checkBox name="raceWhite" id="r1" value="${demographicsInstance?.raceWhite}"/>&nbsp;<label for="r1">White</label> <br />                                    
                <g:checkBox name="raceUnknown" id="r6" value="${demographicsInstance?.raceUnknown}" />&nbsp;<label for="r6">Unknown</label> <br />
              </div> 

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="ethnicity">7.&nbsp;<g:message code="demographics.ethnicity.label" default="Ethnicity" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: demographicsInstance, field: 'ethnicity', 'errors')}">
              <div>
                <g:radio name="ethnicity" id="e1" value="Hispanic or Latino" checked="${demographicsInstance?.ethnicity =='Hispanic or Latino'}"/>&nbsp;<label for="e1">Hispanic or Latino</label> <br />
                <g:radio name="ethnicity" id="e2" value="Not-Hispanic or Latino" checked="${demographicsInstance?.ethnicity =='Not-Hispanic or Latino'}"/>&nbsp;<label for="e2">Not-Hispanic or Latino</label><br />
                <g:radio name="ethnicity" id="e3" value="Not reported" checked="${demographicsInstance?.ethnicity =='Not reported'}"/>&nbsp;<label for="e3">Not reported</label> <br />
                <g:radio name="ethnicity" id="e4" value="Unknown" checked="${demographicsInstance?.ethnicity =='Unknown'}"/>&nbsp;<label for="e4">Unknown</label>  <br />
              </div>
          </td>
        </tr>

        </tbody>
    </table>
</div> 