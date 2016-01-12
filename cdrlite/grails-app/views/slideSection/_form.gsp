<%@ page import="nci.bbrb.cdr.forms.SlideSection" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="internalComments"><g:message code="slideSection.internalComments.label" default="Internal Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'internalComments', 'error')}">
                <g:textArea name="internalComments" cols="40" rows="5" maxlength="4000" value="${slideSectionInstance?.internalComments}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="publicComments"><g:message code="slideSection.publicComments.label" default="Public Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'publicComments', 'error')}">
                <g:textArea name="publicComments" cols="40" rows="5" maxlength="4000" value="${slideSectionInstance?.publicComments}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="slideSectionTech"><g:message code="slideSection.slideSectionTech.label" default="Slide Prep Tech" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'slideSectionTech', 'error')}">
                <g:textField name="slideSectionTech" value="${slideSectionInstance?.slideSectionTech}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="siteSOPSlideSection"><g:message code="slideSection.siteSOPSlideSection.label" default="Site SOPS lide Prep" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'siteSOPSlideSection', 'error')}">
                <g:textField name="siteSOPSlideSection" value="${slideSectionInstance?.siteSOPSlideSection}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtome"><g:message code="slideSection.microtome.label" default="Microtome" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtome', 'error')}">
                <g:textField name="microtome" value="${slideSectionInstance?.microtome}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeOs"><g:message code="slideSection.microtomeOs.label" default="Microtome Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeOs', 'error')}">
                <g:textField name="microtomeOs" value="${slideSectionInstance?.microtomeOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeBladeType"><g:message code="slideSection.microtomeBladeType.label" default="Microtome Blade Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeType', 'error')}">
                <g:textField name="microtomeBladeType" value="${slideSectionInstance?.microtomeBladeType}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeBladeTypeOs"><g:message code="slideSection.microtomeBladeTypeOs.label" default="Microtome Blade Type Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeTypeOs', 'error')}">
                <g:textField name="microtomeBladeTypeOs" value="${slideSectionInstance?.microtomeBladeTypeOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeBladeAge"><g:message code="slideSection.microtomeBladeAge.label" default="Microtome Blade Age" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeAge', 'error')}">
                <g:textField name="microtomeBladeAge" value="${slideSectionInstance?.microtomeBladeAge}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeBladeAgeOs"><g:message code="slideSection.microtomeBladeAgeOs.label" default="Microtome Blade Age Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeBladeAgeOs', 'error')}">
                <g:textField name="microtomeBladeAgeOs" value="${slideSectionInstance?.microtomeBladeAgeOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="facedBlockPrep"><g:message code="slideSection.facedBlockPrep.label" default="Faced Block Prep" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'facedBlockPrep', 'error')}">
                <g:textField name="facedBlockPrep" value="${slideSectionInstance?.facedBlockPrep}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="facedBlockPrepOs"><g:message code="slideSection.facedBlockPrepOs.label" default="Faced Block Prep Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'facedBlockPrepOs', 'error')}">
                <g:textField name="facedBlockPrepOs" value="${slideSectionInstance?.facedBlockPrepOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="sectionThickness"><g:message code="slideSection.sectionThickness.label" default="Section Thickness" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'sectionThickness', 'error')}">
                <g:textField name="sectionThickness" value="${slideSectionInstance?.sectionThickness}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="sectionThicknessOs"><g:message code="slideSection.sectionThicknessOs.label" default="Section Thickness Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'sectionThicknessOs', 'error')}">
                <g:textField name="sectionThicknessOs" value="${slideSectionInstance?.sectionThicknessOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="slideCharge"><g:message code="slideSection.slideCharge.label" default="Slide Charge" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'slideCharge', 'error')}">
                <g:textField name="slideCharge" value="${slideSectionInstance?.slideCharge}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="slideChargeOs"><g:message code="slideSection.slideChargeOs.label" default="Slide Charge Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'slideChargeOs', 'error')}">
                <g:textField name="slideChargeOs" value="${slideSectionInstance?.slideChargeOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="waterBathTemp"><g:message code="slideSection.waterBathTemp.label" default="Water Bath Temp" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterBathTemp', 'error')}">
                <g:textField name="waterBathTemp" value="${slideSectionInstance?.waterBathTemp}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="waterBathTempOs"><g:message code="slideSection.waterBathTempOs.label" default="Water Bath Temp Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterBathTempOs', 'error')}">
                <g:textField name="waterBathTempOs" value="${slideSectionInstance?.waterBathTempOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeDailyMaint"><g:message code="slideSection.microtomeDailyMaint.label" default="Microtome Daily Maint" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeDailyMaint', 'error')}">
                <g:textField name="microtomeDailyMaint" value="${slideSectionInstance?.microtomeDailyMaint}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="microtomeDailyMaintOs"><g:message code="slideSection.microtomeDailyMaintOs.label" default="Microtome Daily Maint Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'microtomeDailyMaintOs', 'error')}">
                <g:textArea name="microtomeDailyMaintOs" cols="40" rows="5" maxlength="4000" value="${slideSectionInstance?.microtomeDailyMaintOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="waterbathMaint"><g:message code="slideSection.waterbathMaint.label" default="Waterbath Maint" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterbathMaint', 'error')}">
                <g:textField name="waterbathMaint" value="${slideSectionInstance?.waterbathMaint}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="waterbathMaintOs"><g:message code="slideSection.waterbathMaintOs.label" default="Waterbath Maint Os" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'waterbathMaintOs', 'error')}">
                <g:textArea name="waterbathMaintOs" cols="40" rows="5" maxlength="4000" value="${slideSectionInstance?.waterbathMaintOs}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="FFPEComments"><g:message code="slideSection.FFPEComments.label" default="FFPEC omments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'FFPEComments', 'error')}">
                <g:textArea name="FFPEComments" cols="40" rows="5" maxlength="4000" value="${slideSectionInstance?.FFPEComments}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="caseRecord"><g:message code="slideSection.caseRecord.label" default="Case Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'caseRecord', 'error')}">
                <g:select id="caseRecord" name="caseRecord.id" from="${nci.bbrb.cdr.datarecords.CaseRecord.list()}" optionKey="id" required="" value="${slideSectionInstance?.caseRecord?.id}" class="many-to-one"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="internalGUID"><g:message code="slideSection.internalGUID.label" default="Internal GUID" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'internalGUID', 'error')}">
                <g:textField name="internalGUID" required="" value="${slideSectionInstance?.internalGUID}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="publicVersion"><g:message code="slideSection.publicVersion.label" default="Public Version" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'publicVersion', 'error')}">
                <g:field name="publicVersion" value="${fieldValue(bean: slideSectionInstance, field: 'publicVersion')}" required=""/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="specimenRecord"><g:message code="slideSection.specimenRecord.label" default="Specimen Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: slideSectionInstance, field: 'specimenRecord', 'error')}">
                <g:select id="specimenRecord" name="specimenRecord.id" from="${nci.bbrb.cdr.datarecords.SpecimenRecord.list()}" optionKey="id" required="" value="${slideSectionInstance?.specimenRecord?.id}" class="many-to-one"/>

            </td>
        </tr>

        
        

        </tbody>
    </table>
</div>  
