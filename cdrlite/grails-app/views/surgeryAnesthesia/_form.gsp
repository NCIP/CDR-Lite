<g:render template="/caseRecord/caseDetails" bean="${surgeryAnesthesiaInstance.caseRecord}" var="caseRecord"/> 

<g:set var="labelNumber" value="${1}"/>
<g:set var="primaryTissueType" value="${surgeryAnesthesiaInstance.caseRecord?.primaryTissueType?.toString()}"/>
<g:set var="isPrimaryTissueTypeLung" value="${'Lung'.equalsIgnoreCase(primaryTissueType)}"/>
<g:set var="isPrimaryTissueTypeOvary" value="${'Ovary'.equalsIgnoreCase(primaryTissueType)}"/>
<g:set var="isPrimaryTissueTypeColon" value="${'Colon'.equalsIgnoreCase(primaryTissueType)}"/>
<g:set var="isPrimaryTissueTypeKidney" value="${'Kidney'.equalsIgnoreCase(primaryTissueType)}"/>
<g:set var="isPrimaryTissueTypeUterus" value="${'Uterus'.equalsIgnoreCase(primaryTissueType)}"/>

<div class="list">
    <table id="surgeryanest" class="tdwrap tdtop">
        <tbody>
            <tr class="prop">
                <td valign="top" colspan="2" class="formheader">Pre-operative medications administration: Record medications administered in the holding area prior to participant entering the operating room.<br />If additional space is required record any additional pre-operative medications administered in #6 below.
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="surgeryDate">${labelNumber++}. Date of surgery:</label>   
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'surgeryDate', 'errors')}">
		<%--    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="surgeryDate" value="${surgeryAnesthesiaInstance?.surgeryDate}"/> --%>
                   <g:jqDatePicker LDSOverlay="${bodyclass ?: ''}" name="surgeryDate" value="${surgeryAnesthesiaInstance?.surgeryDate}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Pre-operative IV Sedation administered:</label>
                    <span id="surgeryanesthesiaform.preopivsedation" class="vocab-tooltip"></span>    
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSedDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.poSedDiv)}"  name="poSedDiv"/>
                </td>
            </tr>
            <tr class="prop" id="poSedDivRow" style="display:${surgeryAnesthesiaInstance?.poSedDiv == 'Yes'?'display':'none'}">
              <td></td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="poSed1" dlist="Diazepam" namevalue="${surgeryAnesthesiaInstance?.poSed1Name}" dosevalue="${surgeryAnesthesiaInstance?.poSed1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poSed1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poSed1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed1Time', 'errors')}"/>
                            <g:medAdmin name="poSed2" dlist="Lorazepam" namevalue="${surgeryAnesthesiaInstance?.poSed2Name}" dosevalue="${surgeryAnesthesiaInstance?.poSed2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poSed2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poSed2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed2Time', 'errors')}"/>
                            <g:medAdmin name="poSed3" dlist="Midazolam" namevalue="${surgeryAnesthesiaInstance?.poSed3Name}" dosevalue="${surgeryAnesthesiaInstance?.poSed3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poSed3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poSed3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed3Time', 'errors')}"/>
                            <g:medAdmin name="poSed4" id="otherpreopivsedation" dlist="Other IV Sedation (specify)" namevalue="${surgeryAnesthesiaInstance?.poSed4Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed4Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poSed4Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed4Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poSed4Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed4Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poSed4Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poSed4Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Pre-operative IV Opiates administered:</label>
                    <span id="surgeryanesthesiaform.preopivopiates" class="vocab-tooltip"></span>       
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOpDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.poOpDiv)}"  name="poOpDiv"/>
                </td>
            </tr>
            <tr class="prop" id="poOpDivRow" style="display:${surgeryAnesthesiaInstance?.poOpDiv == 'Yes'?'display':'none'}">
              <td></td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="poOp1" dlist="Fentanyl" namevalue="${surgeryAnesthesiaInstance?.poOp1Name}" dosevalue="${surgeryAnesthesiaInstance?.poOp1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poOp1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poOp1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp1Time', 'errors')}"/>
                            <g:medAdmin name="poOp2" dlist="Hydromorphone" namevalue="${surgeryAnesthesiaInstance?.poOp2Name}" dosevalue="${surgeryAnesthesiaInstance?.poOp2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poOp2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poOp2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp2Time', 'errors')}"/>
                            <g:medAdmin name="poOp3" dlist="Meperidine" namevalue="${surgeryAnesthesiaInstance?.poOp3Name}" dosevalue="${surgeryAnesthesiaInstance?.poOp3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poOp3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poOp3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp3Time', 'errors')}"/>
                            <g:medAdmin name="poOp4" dlist="Morphine" namevalue="${surgeryAnesthesiaInstance?.poOp4Name}" dosevalue="${surgeryAnesthesiaInstance?.poOp4Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp4Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poOp4Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp4Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poOp4Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp4Time', 'errors')}"/>
                            <g:medAdmin name="poOp5" id="otherpreopivopiates" dlist="Other IV Opiates (specify)" namevalue="${surgeryAnesthesiaInstance?.poOp5Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp5Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poOp5Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp5Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poOp5Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp5Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poOp5Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poOp5Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Pre-operative IV Antiemetics administered:</label>
                    <span id="surgeryanesthesiaform.preopivantiemetics" class="vocab-tooltip"></span>                       
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiemDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.poAntiemDiv)}"  name="poAntiemDiv"/>
                </td>
            </tr>
            <tr class="prop" id="poAntiemDivRow" style="display:${surgeryAnesthesiaInstance?.poAntiemDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="poAntiem1" dlist="Droperidol" namevalue="${surgeryAnesthesiaInstance?.poAntiem1Name}" dosevalue="${surgeryAnesthesiaInstance?.poAntiem1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poAntiem1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poAntiem1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem1Time', 'errors')}"/>
                            <g:medAdmin name="poAntiem2" dlist="Ondansetron" namevalue="${surgeryAnesthesiaInstance?.poAntiem2Name}" dosevalue="${surgeryAnesthesiaInstance?.poAntiem2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poAntiem2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poAntiem2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem2Time', 'errors')}"/>
                            <g:medAdmin name="poAntiem3" id="otherpreopivantiemetics" dlist="Other IV Antiemetic (specify)" namevalue="${surgeryAnesthesiaInstance?.poAntiem3Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem3Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poAntiem3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poAntiem3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poAntiem3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiem3Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Pre-operative IV Antacid administered:</label>
                    <span id="surgeryanesthesiaform.preopivantacids" class="vocab-tooltip"></span>              
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAcDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.poAntiAcDiv)}"  name="poAntiAcDiv"/>
                </td>
            </tr>
            <tr class="prop" id="poAntiAcDivRow" style="display:${surgeryAnesthesiaInstance?.poAntiAcDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="poAntiAc1" dlist="Ranitidine" namevalue="${surgeryAnesthesiaInstance?.poAntiAc1Name}" dosevalue="${surgeryAnesthesiaInstance?.poAntiAc1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poAntiAc1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poAntiAc1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc1Time', 'errors')}"/>
                            <g:medAdmin name="poAntiAc2" id="otherpreopivantacids" dlist="Other IV Anti-acids (specify)" namevalue="${surgeryAnesthesiaInstance?.poAntiAc2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poAntiAc2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poAntiAc2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poAntiAc2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poAntiAc2Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop"> 
                <td valign="top" class="name">
                    <label>${labelNumber++}. Other Pre-operative IV Medications administered:</label>
                    <span id="surgeryanesthesiaform.otherpreopivmeds" class="vocab-tooltip"></span>          
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMedDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.poMedDiv)}"  name="poMedDiv"/>
                </td>
            </tr>
            <tr class="prop" id="poMedDivRow" style="display:${surgeryAnesthesiaInstance?.poMedDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value">
                    <div>
                        <table>
                            <g:medAdmin name="poMed1" dlist="Other Pre-operative IV medications (specify)" namevalue="${surgeryAnesthesiaInstance?.poMed1Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed1Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poMed1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poMed1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poMed1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed1Time', 'errors')}"/>
                            <g:medAdmin name="poMed2" dlist="Other Pre-operative IV medications (specify)" namevalue="${surgeryAnesthesiaInstance?.poMed2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poMed2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poMed2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poMed2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed2Time', 'errors')}"/>
                            <g:medAdmin name="poMed3" dlist="Other Pre-operative IV medications (specify)" namevalue="${surgeryAnesthesiaInstance?.poMed3Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed3Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.poMed3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.poMed3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.poMed3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'poMed3Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" colspan="2" class="formheader">
                    Type of anesthesia administered: Please record ONLY ANESTHESIA agents administered PRIOR TO REMOVAL OF ORGAN.<br />If additional space is required record any additional anesthesia agents administered in #13 below.
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Local anesthesia agents administered:</label>
                    <span id="surgeryanesthesiaform.localanesthesiapriororganremove" class="vocab-tooltip"></span> 
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnesDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.localAnesDiv)}"  name="localAnesDiv"/>
                </td>
            </tr>
            <tr class="prop" id="localAnesDivRow" style="display:${surgeryAnesthesiaInstance?.localAnesDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="localAnes1" dlist="Lidocaine" namevalue="${surgeryAnesthesiaInstance?.localAnes1Name}" dosevalue="${surgeryAnesthesiaInstance?.localAnes1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.localAnes1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.localAnes1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes1Time', 'errors')}"/>
                            <g:medAdmin name="localAnes2" dlist="Procaine" namevalue="${surgeryAnesthesiaInstance?.localAnes2Name}" dosevalue="${surgeryAnesthesiaInstance?.localAnes2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.localAnes2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.localAnes2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes2Time', 'errors')}"/>
                            <g:medAdmin name="localAnes3" id="otherlocalanesthesiapriororganremove" dlist="Other IV Local anesthesia agents (specify)" namevalue="${surgeryAnesthesiaInstance?.localAnes3Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes3Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.localAnes3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.localAnes3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.localAnes3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'localAnes3Time', 'errors')}"/>
                        </table>
                    </div> 
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Regional (Spinal/Epidural) anesthesia agents administered:</label>
                    <span id="surgeryanesthesiaform.regionalanesthesiapriororganremove" class="vocab-tooltip"></span> 
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnesDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.regAnesDiv)}"  name="regAnesDiv"/>
                </td>
            </tr>
            <tr class="prop" id="regAnesDivRow" style="display:${surgeryAnesthesiaInstance?.regAnesDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="regAnes1" dlist="Bupivacaine" namevalue="${surgeryAnesthesiaInstance?.regAnes1Name}" dosevalue="${surgeryAnesthesiaInstance?.regAnes1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.regAnes1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.regAnes1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes1Time', 'errors')}"/>
                            <g:medAdmin name="regAnes2" dlist="Lidocaine" namevalue="${surgeryAnesthesiaInstance?.regAnes2Name}" dosevalue="${surgeryAnesthesiaInstance?.regAnes2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.regAnes2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.regAnes2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes2Time', 'errors')}"/>
                            <g:medAdmin name="regAnes3" id="otherregionalanesthesiapriororganremove" dlist="Other Spinal/Regional Anesthetic (specify)" namevalue="${surgeryAnesthesiaInstance?.regAnes3Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes3Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.regAnes3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.regAnes3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.regAnes3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'regAnes3Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. IV anesthesia agents administered:</label>
                    <span id="surgeryanesthesiaform.ivanesthesiapriororganremove" class="vocab-tooltip"></span> 
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anesDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.anesDiv)}"  name="anesDiv"/>
                </td>
            </tr>
            <tr class="prop" id="anesDivRow" style="display:${surgeryAnesthesiaInstance?.anesDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="anes1" dlist="Brevital" namevalue="${surgeryAnesthesiaInstance?.anes1Name}" dosevalue="${surgeryAnesthesiaInstance?.anes1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.anes1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.anes1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes1Time', 'errors')}"/>
                            <g:medAdmin name="anes2" dlist="Etomidate" namevalue="${surgeryAnesthesiaInstance?.anes2Name}" dosevalue="${surgeryAnesthesiaInstance?.anes2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.anes2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.anes2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes2Time', 'errors')}"/>
                            <g:medAdmin name="anes3" dlist="Ketamine" namevalue="${surgeryAnesthesiaInstance?.anes3Name}" dosevalue="${surgeryAnesthesiaInstance?.anes3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.anes3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.anes3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes3Time', 'errors')}"/>
                            <g:medAdmin name="anes4" dlist="Propofol" namevalue="${surgeryAnesthesiaInstance?.anes4Name}" dosevalue="${surgeryAnesthesiaInstance?.anes4Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes4Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.anes4Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes4Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.anes4Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes4Time', 'errors')}"/>
                            <g:medAdmin name="anes5" dlist="Sodium Thiopental" namevalue="${surgeryAnesthesiaInstance?.anes5Name}" dosevalue="${surgeryAnesthesiaInstance?.anes5Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes5Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.anes5Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes5Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.anes5Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes5Time', 'errors')}"/>
                            <g:medAdmin name="anes6" id="otherivanesthesiapriororganremove" dlist="Other IV anesthesia Agents (specify)" namevalue="${surgeryAnesthesiaInstance?.anes6Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes6Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.anes6Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes6Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.anes6Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes6Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.anes6Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'anes6Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. IV Narcotic/Opiate agents administered:</label>
                    <span id="surgeryanesthesiaform.ivnarcoticpriororganremove" class="vocab-tooltip"></span> 
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOpDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.narcOpDiv)}"  name="narcOpDiv"/>
                </td>
            </tr>
            <tr class="prop" id="narcOpDivRow" style="display:${surgeryAnesthesiaInstance?.narcOpDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td  class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="narcOp1" dlist="Fentanyl" namevalue="${surgeryAnesthesiaInstance?.narcOp1Name}" dosevalue="${surgeryAnesthesiaInstance?.narcOp1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.narcOp1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.narcOp1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp1Time', 'errors')}"/>
                            <g:medAdmin name="narcOp2" dlist="Hydromorphone" namevalue="${surgeryAnesthesiaInstance?.narcOp2Name}" dosevalue="${surgeryAnesthesiaInstance?.narcOp2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.narcOp2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.narcOp2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp2Time', 'errors')}"/>
                            <g:medAdmin name="narcOp3" dlist="Meperidine" namevalue="${surgeryAnesthesiaInstance?.narcOp3Name}" dosevalue="${surgeryAnesthesiaInstance?.narcOp3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.narcOp3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.narcOp3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp3Time', 'errors')}"/>
                            <g:medAdmin name="narcOp4" dlist="Morphine" namevalue="${surgeryAnesthesiaInstance?.narcOp4Name}" dosevalue="${surgeryAnesthesiaInstance?.narcOp4Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp4Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.narcOp4Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp4Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.narcOp4Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp4Time', 'errors')}"/>
                            <g:medAdmin name="narcOp5" id="otherivnarcoticpriororganremove" dlist="Other Narcotics/Opiates (specify)" namevalue="${surgeryAnesthesiaInstance?.narcOp5Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp5Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.narcOp5Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp5Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.narcOp5Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp5Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.narcOp5Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'narcOp5Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. IV Muscle Relaxants administered:</label>
                    <span id="surgeryanesthesiaform.ivmusclerelaxpriororganremove" class="vocab-tooltip"></span> 
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelaxDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.musRelaxDiv)}"  name="musRelaxDiv"/>
                </td>
            </tr>
            <tr class="prop" id="musRelaxDivRow" style="display:${surgeryAnesthesiaInstance?.musRelaxDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="musRelax1" dlist="Pancuronium" namevalue="${surgeryAnesthesiaInstance?.musRelax1Name}" dosevalue="${surgeryAnesthesiaInstance?.musRelax1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.musRelax1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.musRelax1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax1Time', 'errors')}"/>
                            <g:medAdmin name="musRelax2" dlist="Suxamethonium Chloride" namevalue="${surgeryAnesthesiaInstance?.musRelax2Name}" dosevalue="${surgeryAnesthesiaInstance?.musRelax2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.musRelax2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.musRelax2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax2Time', 'errors')}"/>
                            <g:medAdmin name="musRelax3" dlist="Vercuronium" namevalue="${surgeryAnesthesiaInstance?.musRelax3Name}" dosevalue="${surgeryAnesthesiaInstance?.musRelax3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.musRelax3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.musRelax3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax3Time', 'errors')}"/>
                            <g:medAdmin name="musRelax4" id="otherivmusclerelaxpriororganremove" dlist="Other Muscle Relaxants (specify)" namevalue="${surgeryAnesthesiaInstance?.musRelax4Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax4Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.musRelax4Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax4Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.musRelax4Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax4Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.musRelax4Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'musRelax4Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Inhalation anesthesia agents administered:</label>
                    <span id="surgeryanesthesiaform.inhalationanestheticpriororganremove" class="vocab-tooltip"></span>           
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnesDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.inhalAnesDiv)}"  name="inhalAnesDiv"/>
                </td>
            </tr>
            <tr class="prop" id="inhalAnesDivRow" style="display:${surgeryAnesthesiaInstance?.inhalAnesDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes1Name', 'errors')}">
                    <div>
                        <table>
                            <g:medAdmin name="inhalAnes1" dlist="Isoflurane" namevalue="${surgeryAnesthesiaInstance?.inhalAnes1Name}" dosevalue="${surgeryAnesthesiaInstance?.inhalAnes1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.inhalAnes1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.inhalAnes1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes1Time', 'errors')}"/>
                            <g:medAdmin name="inhalAnes2" dlist="Nitrous Oxide" namevalue="${surgeryAnesthesiaInstance?.inhalAnes2Name}" dosevalue="${surgeryAnesthesiaInstance?.inhalAnes2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.inhalAnes2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.inhalAnes2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes2Time', 'errors')}"/>
                            <g:medAdmin name="inhalAnes3" id="otherinhalationanestheticpriororganremove" dlist="Other Inhalation anesthesia Agents (specify)" namevalue="${surgeryAnesthesiaInstance?.inhalAnes3Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes3Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.inhalAnes3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.inhalAnes3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.inhalAnes3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inhalAnes3Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Additional anesthesia agents used:</label>
                    <span id="surgeryanesthesiaform.anestheticpriororganremove" class="vocab-tooltip"></span>                       
                </td>
                <td class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnesDiv', 'errors')}">
                  <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.addtlAnesDiv)}"  name="addtlAnesDiv"/>
                </td>
            </tr>
            <tr class="prop" id="addtlAnesDivRow" style="display:${surgeryAnesthesiaInstance?.addtlAnesDiv == 'Yes'?'display':'none'}">
              <td></td>                
                <td class="value">
                    <div>
                        <table>
                            <g:medAdmin name="addtlAnes1" dlist="" namevalue="${surgeryAnesthesiaInstance?.addtlAnes1Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes1Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.addtlAnes1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.addtlAnes1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.addtlAnes1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes1Time', 'errors')}"/>
                            <g:medAdmin name="addtlAnes2" dlist="" namevalue="${surgeryAnesthesiaInstance?.addtlAnes2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.addtlAnes2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.addtlAnes2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.addtlAnes2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes2Time', 'errors')}"/>
                            <g:medAdmin name="addtlAnes3" id="otheranestheticpriororganremove" dlist="" namevalue="${surgeryAnesthesiaInstance?.addtlAnes3Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes3Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.addtlAnes3Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes3Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.addtlAnes3Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes3Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.addtlAnes3Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'addtlAnes3Time', 'errors')}"/>
                        </table>
                    </div>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" colspan="2" class="formheader">
                    Surgery information: Indicate whether any of the following medications were administered during surgery.
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name" colspan="2">
                    <label>${labelNumber++}. Other medications administered during surgery prior to removal of the organ:</label>
                    <span id="surgeryanesthesiaform.othermedication" class="vocab-tooltip"></span>                     
                </td>
            </tr>
            <tr class="prop subentry">
                <td valign="top" class="name"><label for="insulinAdmin">Was Insulin administered during surgery?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insulinAdmin', 'errors')}">
                    <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.insulinAdmin)}"  name="insulinAdmin"/>
                </td>
            </tr>

            <tr id="InsulinRow1" style="display:${surgeryAnesthesiaInstance?.insulinAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="insul1" dlist="Insulin" namevalue="${surgeryAnesthesiaInstance?.insul1Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul1Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.insul1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.insul1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.insul1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul1Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr id="InsulinRow2" style="display:${surgeryAnesthesiaInstance?.insulinAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="insul2" dlist="Insulin" namevalue="${surgeryAnesthesiaInstance?.insul2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.insul2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.insul2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.insul2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'insul2Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name"><label for="steroidAdmin">Were Steroids administered during surgery?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroidAdmin', 'errors')}">
                    <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.steroidAdmin)}"  name="steroidAdmin"/>
                </td>
            </tr>

            <tr id="SteroidRow1" style="display:${surgeryAnesthesiaInstance?.steroidAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="steroid1" dlist="Steroid" namevalue="${surgeryAnesthesiaInstance?.steroid1Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid1Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.steroid1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.steroid1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.steroid1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid1Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr id="SteroidRow2" style="display:${surgeryAnesthesiaInstance?.steroidAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="steroid2" dlist="Steroid" namevalue="${surgeryAnesthesiaInstance?.steroid2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.steroid2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.steroid2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.steroid2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'steroid2Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name"><label for="antibioAdmin">Were antibiotics administered during surgery?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibioAdmin', 'errors')}">
                    <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.antibioAdmin)}"  name="antibioAdmin"/>
                </td>
            </tr>

            <tr id="AntibioRow1" style="display:${surgeryAnesthesiaInstance?.antibioAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="antibio1" dlist="Antibiotic" namevalue="${surgeryAnesthesiaInstance?.antibio1Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio1Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.antibio1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.antibio1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.antibio1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio1Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr id="AntibioRow2" style="display:${surgeryAnesthesiaInstance?.antibioAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="antibio2" dlist="Antibiotic" namevalue="${surgeryAnesthesiaInstance?.antibio2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.antibio2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.antibio2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.antibio2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'antibio2Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name"><label for="othMedAdmin">Were other medications administered during surgery?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'othMedAdmin', 'errors')}">
                    <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.othMedAdmin)}"  name="othMedAdmin"/>
                </td>
            </tr>

            <tr id="OthMedRow1" style="display:${surgeryAnesthesiaInstance?.othMedAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="med1" dlist="Other Medication" namevalue="${surgeryAnesthesiaInstance?.med1Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med1Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.med1Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med1Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.med1Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med1Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.med1Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med1Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr id="OthMedRow2" style="display:${surgeryAnesthesiaInstance?.othMedAdmin == 'Yes'?'display':'none'}">
                <td></td>
                <td>
                    <table>
                        <g:medAdmin name="med2" dlist="Other Medication" namevalue="${surgeryAnesthesiaInstance?.med2Name}" nameerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med2Name', 'errors')}" dosevalue="${surgeryAnesthesiaInstance?.med2Dose}" doseerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med2Dose', 'errors')}" unitvalue="${surgeryAnesthesiaInstance?.med2Unit}" uniterror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med2Unit', 'errors')}" timevalue="${surgeryAnesthesiaInstance?.med2Time}" timeerror="${hasErrors(bean: surgeryAnesthesiaInstance, field: 'med2Time', 'errors')}"/>
                    </table>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" colspan="2" class="formheader">
                    <label>Surgical procedure details</label>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="firstIncisTime">${labelNumber++}. Time of first incision:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'firstIncisTime', 'errors')}">
                    <g:textField name="firstIncisTime" value="${surgeryAnesthesiaInstance?.firstIncisTime}" class="timeEntry"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="surgicalProc">${labelNumber++}. Surgical procedure:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'surgicalProc', 'errors')}">
                    <g:if test="${isPrimaryTissueTypeColon}">
                        <g:select name="surgicalProc" from="${['Abdominoperineal resection','Colectomy','Colectomy, left','Colectomy, right','Colectomy, sigmoid','Colectomy, subtotal','Colectomy, total','Colectomy, transverse','Low anterior resection','Proctectomy','Proctocolectomy','Rectosigmoidectomy','Other-specify']}" value="${surgeryAnesthesiaInstance?.surgicalProc}" noSelection="['': '']"/>
                    </g:if>
                    <g:elseif test="${isPrimaryTissueTypeLung}">
                        <g:select name="surgicalProc" from="${['Lung biopsy, left','Lung biopsy, right','Lung lobectory, left','Lung lobectomy, right','Lung mass excision, left','Lung mass excision, right','Pneumonectomy, left','Pneumonectomy, right','Wedge resection, left','Wedge resection, right','Other-specify']}" value="${surgeryAnesthesiaInstance?.surgicalProc}" noSelection="['': '']"/>
                    </g:elseif>
                    <g:elseif test="${isPrimaryTissueTypeKidney}">
                        <g:select name="surgicalProc" from="${['Kidney biopsy (left)','Kidney biopsy (right)','Kidney mass excision (left)','Kidney mass excision (right)','Nephrectomy (partial left)','Nephrectomy (partial right)','Nephrectomy (radical left)','Nephrectomy (radical right)','Nephroureterectomy (left)','Nephroureterectomy (right)','Other-specify']}" value="${surgeryAnesthesiaInstance?.surgicalProc}" noSelection="['': '']"/>
                    </g:elseif>
                    <g:elseif test="${isPrimaryTissueTypeOvary}">
                        <g:select name="surgicalProc" from="${['Hysterectomy with bilateral salpingo-oophorectomy','Hysterectomy with left salpingo-oophorectomy','Hysterectomy with right salpingo-oophorectomy','Oophorectomy, bilateral','Oophorectomy, left','Oophorectomy, right','Pelvic exenteration','Pelvic mass excision','Salpingo-oophorectomy, bilateral','Salpingo-oophorectomy, left','Salpingo-oophorectomy, right','Other-specify']}" value="${surgeryAnesthesiaInstance?.surgicalProc}" noSelection="['': '']"/>
                    </g:elseif>
                </td>
            </tr>

            <tr class="prop" id="otherSurgicalProcRow" style="display:${surgeryAnesthesiaInstance?.surgicalProc == 'Other-specify'?'display':'none'}">
                <td valign="top" class="name"></td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'otherSurgicalProc', 'errors')}">
                    <g:textField name="otherSurgicalProc" value="${surgeryAnesthesiaInstance?.otherSurgicalProc}"/>
                </td>
            </tr>

            <g:if test="${isPrimaryTissueTypeKidney || isPrimaryTissueTypeOvary}">
                <tr class="prop subentry">
                    <td valign="top" class="name">
                        <label for="surgicalMethod">Surgical method:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'surgicalMethod', 'errors')}">
                        <g:if test="${isPrimaryTissueTypeKidney}">
                            <g:select name="surgicalMethod" from="${['Laparoscopic','Open','Robotic','Other-specify']}" value="${surgeryAnesthesiaInstance?.surgicalMethod}" noSelection="['': '']"/>
                        </g:if>
                        <g:elseif test="${isPrimaryTissueTypeOvary}">
                            <g:select name="surgicalMethod" from="${['Abdominal','Vaginal','Laparoscopic','Laparoscopically Assisted Vaginal Hysterectomy (LAVH)','Supracervical','Robotic','Other-specify']}" value="${surgeryAnesthesiaInstance?.surgicalMethod}" noSelection="['': '']"/>
                        </g:elseif>
                    </td>
                </tr>
                <tr class="prop" id="otherSurgicalMethodRow" style="display:${surgeryAnesthesiaInstance?.surgicalMethod == 'Other-specify'?'display':'none'}">
                    <td valign="top" class="name"></td>
                    <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'otherSurgicalMethod', 'errors')}">
                        <g:textField name="otherSurgicalMethod" value="${surgeryAnesthesiaInstance?.otherSurgicalMethod}"/>
                    </td>
                </tr>
            </g:if>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Time of first clamp:</label>
                    <span id="surgeryanesthesiaform.firstclamptime" class="vocab-tooltip"></span>
                </td>
                <td valign="top" >
                  <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'firstClampTimeLeft', 'errors')}">
                    <span class="labelFieldCombo">
                      <g:if test="${isPrimaryTissueTypeOvary}">
                        <label for="firstClampTimeLeft">Left:</label>
                      </g:if>
                      <g:textField name="firstClampTimeLeft" value="${surgeryAnesthesiaInstance?.firstClampTimeLeft}" class="timeEntry ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'firstClampTimeLeft', 'errors')}" onBlur="getTimeDifference('Left', '')"/>
                    </span>
                  </span>
                  <g:if test="${isPrimaryTissueTypeOvary}">
                    <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'firstClampTimeRight', 'errors')}">
                      <span class="labelFieldCombo" >
                        <label for="firstClampTimeRight">Right:</label>
                          <g:textField name="firstClampTimeRight" value="${surgeryAnesthesiaInstance?.firstClampTimeRight}" class="timeEntry ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'firstClampTimeRight', 'errors')}" onBlur="getTimeDifference('Right', '')"/>
                      </span>
                    </span>
                  </g:if> 
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Time of second clamp:</label>
                    <span id="surgeryanesthesiaform.secondclamptime" class="vocab-tooltip"></span>
                </td>
                <td valign="top" >
                  <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'secondClampTimeLeft', 'errors')}">
                    <span class="labelFieldCombo">
                      <g:if test="${isPrimaryTissueTypeOvary}">
                        <label for="secondClampTimeLeft">Left:</label>
                      </g:if>
                      <g:textField name="secondClampTimeLeft" value="${surgeryAnesthesiaInstance?.secondClampTimeLeft}" class="timeEntry ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'secondClampTimeLeft', 'errors')}" size="4" maxlength="5" onBlur="getSecondClampTimeEntry('Left')"/>
                    </span>
                  </span>
                  <g:if test="${isPrimaryTissueTypeOvary}">
                    <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'secondClampTimeRight', 'errors')}">
                      <span class="labelFieldCombo">
                        <label for="secondClampTimeRight">Right:</label>
                        <g:textField name="secondClampTimeRight" value="${surgeryAnesthesiaInstance?.secondClampTimeRight}" class="timeEntry ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'secondClampTimeRight', 'errors')}" size="4" maxlength="5" onBlur="getSecondClampTimeEntry('Right')"/>
                      </span>
                    </span>
                  </g:if>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Time of organ resection:</label>
                    <span id="surgeryanesthesiaform.organresectiontime" class="vocab-tooltip"></span>
                </td>
                <td valign="top" >
                  <span class="labelFieldCombo" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'organResecTimeLeft', 'errors')}">
                    <g:if test="${isPrimaryTissueTypeOvary}">
                        <label for="organResecTimeLeft">Left:</label>
                    </g:if>
                    <g:textField name="organResecTimeLeft" value="${surgeryAnesthesiaInstance?.organResecTimeLeft}" class="timeEntry ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'organResecTimeLeft', 'errors')}" onBlur="getTimeDifference('Left', '')"/>
                  </span>
                  <g:if test="${isPrimaryTissueTypeOvary}">
                    <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'organResecTimeRight', 'errors')}">
                      <span class="labelFieldCombo">
                        <label for="organResecTimeRight">Right:</label>
                          <g:textField name="organResecTimeRight" value="${surgeryAnesthesiaInstance?.organResecTimeRight}" class="timeEntry ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'organResecTimeRight', 'errors')}" onBlur="getTimeDifference('Right', '')"/>
                      </span>
                    </span>
                  </g:if>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label>${labelNumber++}. In Vivo Intra-operative Ischemic Period (minutes):</label>
                    <span id="surgeryanesthesiaform.intraopischemicperiodmin" class="vocab-tooltip"></span>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'inVivoIntOpIschemPdLeft', 'errors')}">
                  <span class="labelFieldCombo">
                    <g:if test="${isPrimaryTissueTypeOvary}">
                        <label for="inVivoIntOpIschemPdLeft">Left:</label>
                    </g:if>
                    <g:textField readonly="readonly" size="4" name="inVivoIntOpIschemPdLeft" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'inVivoIntOpIschemPdLeft')}" onBlur="getTimeDifference('Left', 'InVivo')" />
                  </span>
                  <span class="labelFieldCombo">
                    <g:if test="${isPrimaryTissueTypeOvary}">
                      <label for="inVivoIntOpIschemPdRight">Right:</label>
                        <g:textField readonly="readonly" size="4" name="inVivoIntOpIschemPdRight" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'inVivoIntOpIschemPdRight')}" onBlur="getTimeDifference('Right', 'InVivo')" />
                    </g:if>
                  </span>
                </td>
            </tr>

            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'excFirst15PostAnesInd', 'errors')}">
                    <label for="excFirst15PostAnesInd">${labelNumber++}. Describe Blood Pressure excursions from time of anesthesia induction to 15 minutes post induction</label><br />
                    <g:textArea class="textwide" name="excFirst15PostAnesInd" cols="40" rows="5" value="${surgeryAnesthesiaInstance?.excFirst15PostAnesInd}"/>
                </td>
            </tr>

            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'excAnesInd2OrganExc', 'errors')}">
                    <label for="excAnesInd2OrganExc">${labelNumber++}. Describe Blood Pressure excursions from 15 minutes post anesthesia induction to organ excision:</label><br />
                    <g:textArea class="textwide" name="excAnesInd2OrganExc" cols="40" rows="5" value="${surgeryAnesthesiaInstance?.excAnesInd2OrganExc}"/>
                </td>
            </tr>

            <tr class="prop clearborder">
                <td valign="top" class="name">
                    <label>${labelNumber++}. Temperature:</label>
                </td>
                <td></td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name">
                    <label for="temperature1">First Participant temperature recorded in OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'temperature1', 'errors')}">
                    <g:textField size="4" name="temperature1" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'temperature1')}" onkeyup="isNumericValidation(this)"/>&nbsp;&nbsp;
                    <g:select name="temperature1Unit" value="${surgeryAnesthesiaInstance?.temperature1Unit}" keys="${['Fahrenheit']}" from="${['°F']}" noSelection="['Celsius':'°C']"/>
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name">
                    <label for="timeTemp1">Time of first temperature:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'timeTemp1', 'errors')}">
                    <g:textField name="timeTemp1" value="${surgeryAnesthesiaInstance?.timeTemp1}" class="timeEntry"/>
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name">
                    <label for="temperature2">Second Participant temperature recorded in OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'temperature2', 'errors')}">
                    <g:textField size="4" name="temperature2" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'temperature2')}" onkeyup="isNumericValidation(this)"/>&nbsp;&nbsp;
                    <g:select name="temperature2Unit" value="${surgeryAnesthesiaInstance?.temperature2Unit}" keys="${['Fahrenheit']}" from="${['°F']}" noSelection="['Celsius':'°C']"/>
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name">
                    <label for="timeTemp2">Time of second temperature:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'timeTemp2', 'errors')}">
                    <g:textField name="timeTemp2" value="${surgeryAnesthesiaInstance?.timeTemp2}" class="timeEntry"/>
                </td>
            </tr>

            <tr class="prop">
                <td colspan="2" class="name">
                    <label for="epochsO2">${labelNumber++}. Describe Epochs of Oxygen (O2) desaturation of <92% for >5 minutes prior to organ excision:</label><br />
                    <g:textArea class="textwide" name="epochsO2" cols="40" rows="5" value="${surgeryAnesthesiaInstance?.epochsO2}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="co2Level">${labelNumber++}. Carbon Dioxide level (CO2) recorded at time closest and prior to organ excision:</label>
                </td>
                <td valign="top">
                    <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'co2LevelValue', 'errors')}">
                        <g:textField size="6" name="co2LevelValue" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'co2LevelValue')}" onkeyup="isNumericValidation(this)"/>&nbsp;
                    </span>
                    <span class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'co2LevelUnit', 'errors')}">
                        <g:select name="co2LevelUnit" from="${nci.bbrb.cdr.forms.SurgeryAnesthesia$CO2Unit?.values()}" keys="${nci.bbrb.cdr.forms.SurgeryAnesthesia$CO2Unit?.values()*.name()}" value="${surgeryAnesthesiaInstance?.co2LevelUnit?.name()}"/> 
                    </span>
                    <g:if test="${(surgeryAnesthesiaInstance?.co2LevelUnit.toString() == 'Other, Specify') || (surgeryAnesthesiaInstance?.co2LevelUnit.toString() == 'OTH')}">
                        <span class="prop" id="co2LevelUnitOtherRow" style="display:display" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'co2LevelUnitOther', 'errors')}">
                            &nbsp;&nbsp;<g:textField size="10" name="co2LevelUnitOther" value="${surgeryAnesthesiaInstance?.co2LevelUnitOther}" />
                        </span>
                    </g:if>
                    <g:else>
                        <span class="prop" id="co2LevelUnitOtherRow" style="display:none" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'co2LevelUnitOther', 'errors')}">
                            &nbsp;&nbsp;<g:textField size="10" name="co2LevelUnitOther" value="${surgeryAnesthesiaInstance?.co2LevelUnitOther}" />
                        </span>
                    </g:else>
                    
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" colspan="2" class="formheader">Intraoperative blood product administration.</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="albuminCount">${labelNumber}a. Albumin Units:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'albuminCount', 'errors')}">
                    <g:textField size="4" name="albuminCount" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'albuminCount')}" onkeyup="isNumericValidation(this)"/> ml
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="rbcCount">${labelNumber}b. Packed Red Blood Cells:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'rbcCount', 'errors')}">
                    <g:textField size="4" name="rbcCount" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'rbcCount')}" onkeyup="isNumericValidation(this)"/> #units
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="plateletCount">${labelNumber}c. Platelets:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'plateletCount', 'errors')}">
                    <g:textField size="4" name="plateletCount" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'plateletCount')}" onkeyup="isNumericValidation(this)"/> ml
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="frozPlasma">${labelNumber++}d. Fresh Frozen Plasma:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'frozPlasma', 'errors')}">
                    <g:textField size="4" name="frozPlasma" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'frozPlasma')}" onkeyup="isNumericValidation(this)"/> #units
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" colspan="2" class="formheader">Participant Fluid output.</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="bloodLossb4OrganExc">${labelNumber++}. Blood loss:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'bloodLossb4OrganExc', 'errors')}">
                    <g:textField size="4" name="bloodLossb4OrganExc" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'bloodLossb4OrganExc')}" onkeyup="isNumericValidation(this)"/> ml
                </td>
            </tr>

            <tr class="prop subentry">
                <td valign="top" class="name"><label for="bloodLossRecPt">At what point was blood loss recorded? Select one:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'bloodLossRecPt', 'errors')}">
                    <g:select name="bloodLossRecPt" value="${surgeryAnesthesiaInstance?.bloodLossRecPt}" from="${['Prior to organ excision', 'End of surgery']}" noSelection="['': '']"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="urineVolb4Exc">${labelNumber++}. Urine volume collected:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'urineVolb4Exc', 'errors')}">
                    <g:textField size="4" name="urineVolb4Exc" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'urineVolb4Exc')}" onkeyup="isNumericValidation(this)"/> ml
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><label for="urineVolRecPt">At what point was urine output recorded? Select one:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'urineVolRecPt', 'errors')}">
                    <g:select name="urineVolRecPt" value="${surgeryAnesthesiaInstance?.urineVolRecPt}" from="${['Prior to organ excision', 'End of surgery']}" noSelection="['': '']"/>
                </td>
            </tr>

            <g:if test="${isPrimaryTissueTypeOvary || isPrimaryTissueTypeUterus}">
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="isPelvicWashColl">${labelNumber++}. Record Pelvic washing collection?</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'isPelvicWashColl', 'errors')}">
                        <g:bpvYesNoRadioPicker checked="${(surgeryAnesthesiaInstance?.isPelvicWashColl)}"  name="isPelvicWashColl"/>
                    </td>
                </tr>

                <tr class="prop" id="collPelvicWashRow" style="display:${surgeryAnesthesiaInstance?.isPelvicWashColl == 'Yes'?'display':'none'}">
                    <td valign="top" class="name">
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'collPelvicWash', 'errors')}">
                        <g:textField size="4" name="collPelvicWash" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'collPelvicWash')}"/> ml
                    </td>
                </tr>
          </g:if>

          

          <tr class="prop">
              <td valign="top" colspan="2" class="formheader">Additional information</td>
          </tr>

          <tr class="prop">
              <td valign="top" class="name">
                  <label for="durFastingb4Surg">${labelNumber++}. Duration of fasting prior to surgery:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'durFastingb4Surg', 'errors')}">
                  <g:textField size="4" name="durFastingb4Surg" value="${fieldValue(bean: surgeryAnesthesiaInstance, field: 'durFastingb4Surg')}" onkeyup="isNumericValidation(this)"/> hours
              </td>
          </tr>

          <tr class="prop">
              <td colspan="2" class="name ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'bowelPrepb4Surg', 'errors')}">
                  <label for="bowelPrepb4Surg">${labelNumber++}. Describe pre-operative bowel preparation prior to surgery:</label><br />
                  <g:textArea class="textwide" name="bowelPrepb4Surg" cols="40" rows="5" value="${surgeryAnesthesiaInstance?.bowelPrepb4Surg}"/>
              </td>
          </tr>

          <tr class="prop">
              <td colspan="2" class="name ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'notableEvtsSurg', 'errors')}">
                  <label for="notableEvtsSurg">${labelNumber++}. Other notable events during surgery:</label><br />
                  <g:textArea class="textwide" name="notableEvtsSurg" cols="40" rows="5" value="${surgeryAnesthesiaInstance?.notableEvtsSurg}"/>
              </td>
          </tr>

          <tr class="prop">
              <td valign="top" class="name">
                  <label for="specOrLeavingTime">${labelNumber++}. Time Specimen left OR:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: surgeryAnesthesiaInstance, field: 'specOrLeavingTime', 'errors')}">
                  <g:textField name="specOrLeavingTime" value="${surgeryAnesthesiaInstance?.specOrLeavingTime}" class="timeEntry"/>
              </td>
          </tr>
        </tbody>
    </table>
</div>
