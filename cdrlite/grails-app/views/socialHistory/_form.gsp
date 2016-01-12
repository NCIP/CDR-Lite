

<div class="list">
    
    <table class="tdwrap">
        <tbody>
            <%
                def labelNumber = 1
            %>

          

                <tr><td colspan="2" class="formheader">Alcohol History</td></tr>
                <tr class="prop">
                    <td colspan="2" class="name ${hasErrors(bean: socialHistoryInstance, field: 'alcoholConsum', 'errors')}">
                      <label for="alcoholConsum">${labelNumber++}. Alcohol consumption:</label>
                      <div class="subentry value alcoholConsum">
                        <g:radio name="alcoholConsum" id="consum5" value="Lifelong non-drinker" checked="${socialHistoryInstance?.alcoholConsum == 'Lifelong non-drinker'}" />&nbsp;<label for="consum5">Lifelong non-drinker</label><br>
                        <g:radio name="alcoholConsum" id="consum4" value="Alcohol consumption up to 2 drinks per day" checked="${socialHistoryInstance?.alcoholConsum == 'Alcohol consumption up to 2 drinks per day'}" />&nbsp;<label for="consum4">Alcohol consumption up to 2 drinks per day</label><br>
                        <g:radio name="alcoholConsum" id="consum3" value="Alcohol consumption more than 2 drinks per day" checked="${socialHistoryInstance?.alcoholConsum == 'Alcohol consumption more than 2 drinks per day'}" />&nbsp;<label for="consum3">Alcohol consumption more than 2 drinks per day</label><br>
                        <g:radio name="alcoholConsum" id="consum2" value="Consumed alcohol in the past, but currently a non-drinker" checked="${socialHistoryInstance?.alcoholConsum == 'Consumed alcohol in the past, but currently a non-drinker'}" />&nbsp;<label for="consum2">Consumed alcohol in the past, but currently a non-drinker</label><br>
                        <g:radio name="alcoholConsum" id="consum1" value="Alcohol consumption history not available" checked="${socialHistoryInstance?.alcoholConsum == 'Alcohol consumption history not available'}" />&nbsp;<label for="consum1">Alcohol consumption history not available</label>
                      </div>  
                    </td>
                </tr>
                <tr class="prop subentry depends-on" id="moreThan2DrinksRow" data-id="consum2,consum3,consum4" >
                
                    <td valign="top" class="name">
                        <label for="numYrsAlcCon">${labelNumber++}. Number of years participant has consumed more than 2 drinks per day :</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: socialHistoryInstance, field: 'numYrsAlcCon', 'errors')}">
                        <g:textField name="numYrsAlcCon" size="2" maxlength="2" value="${socialHistoryInstance?.numYrsAlcCon}" onkeyup="isNumericValidation(this)"/>
                    </td>
                </tr>



          <tr><td colspan="2" class="formheader">Tobacco smoking history</td></tr>
          <tr class="prop">
              <td colspan="2" class="name ${hasErrors(bean: socialHistoryInstance, field: 'tobaccoSmHist', 'errors')}">
                <label for="tobaccoSmHist">${labelNumber++}. Tobacco smoking history:</label>
                <div class="subentry value ">
                  <g:radio name="tobaccoSmHist" id="sm5" value="Lifelong non-smoker: Less than 100 cigarettes smoked in lifetime" checked="${socialHistoryInstance?.tobaccoSmHist == 'Lifelong non-smoker: Less than 100 cigarettes smoked in lifetime'}" />&nbsp;<label for="sm5">Lifelong non-smoker: Less than 100 cigarettes smoked in lifetime</label><br>
                  <g:radio name="tobaccoSmHist" id="sm4" value="Current smoker: Includes daily and non-daily smokers" checked="${socialHistoryInstance?.tobaccoSmHist == 'Current smoker: Includes daily and non-daily smokers'}" />&nbsp;<label for="sm4">Current smoker: Includes daily and non-daily smokers</label><br>
                  <g:radio name="tobaccoSmHist" id="sm3" value="Current reformed smoker for more than 15 years" checked="${socialHistoryInstance?.tobaccoSmHist == 'Current reformed smoker for more than 15 years'}" />&nbsp;<label for="sm3">Current reformed smoker for more than 15 years</label><br>
                  <g:radio name="tobaccoSmHist" id="sm2" value="Current reformed smoker for less than 15 years" checked="${socialHistoryInstance?.tobaccoSmHist == 'Current reformed smoker for less than 15 years'}" />&nbsp;<label for="sm2">Current reformed smoker for less than 15 years</label><br>
                  <g:radio name="tobaccoSmHist" id="sm1" value="Smoking history not available" checked="${socialHistoryInstance?.tobaccoSmHist == 'Smoking history not available'}" />&nbsp;<label for="sm1">Smoking history not available</label>
                </div> 
              </td>
          </tr>
          
          <tr class="prop subentry depends-on ${hasErrors(bean: socialHistoryInstance, field: 'tobaccoSmHist', 'errors')}" id="smkStartRow" data-id="sm4,sm3,sm2" >
              <td class="name">
                  <label for="smokeAgeStart">${labelNumber++}. Enter age at which the Participant started smoking:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: socialHistoryInstance, field: 'smokeAgeStart', 'errors')}">
                  <g:textField name="smokeAgeStart" size="2" maxlength="3" value="${socialHistoryInstance?.smokeAgeStart}"  />
               </td>
          </tr>

          <tr class="prop subentry depends-on" id="smkYrsRow"  data-id="sm4,sm3,sm2">
              <td valign="top" class="name">
                  <label for="smokeYears">${labelNumber++}. Years smoked:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: socialHistoryInstance, field: 'smokeYears', 'errors')}">
                  <g:textField name="smokeYears" size="2" maxlength="3" value="${socialHistoryInstance?.smokeYears}" />
            
              </td>
          </tr>
          
          
                   
          
          <tr class="prop subentry depends-on" id="smkPkWkRow" data-id="sm4,sm3,sm2" >
              <td valign="top" class="name">
                  <label for="smokePackWeek">${labelNumber++}. Pack per week smoked:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: socialHistoryInstance, field: 'smokePackWeek', 'errors')}">
                  <g:textField name="smokePackWeek" size="2" maxlength="3" value="${socialHistoryInstance?.smokePackWeek}" />
            
              </td>
          </tr>
          
          
          
          <tr class="prop subentry depends-on" id="smkLastYrsRow"  data-id="sm4,sm3,sm2">
              <td valign="top" class="name ${hasErrors(bean: socialHistoryInstance, field: 'yrSinceLastSmoke', 'errors')}">
                  <label for="yrSinceLastSmoke">${labelNumber++}. Years since last smoke:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: socialHistoryInstance, field: 'yrSinceLastSmoke', 'errors')}">
                  <g:textField name="yrSinceLastSmoke" size="2" maxlength="3" value="${socialHistoryInstance?.yrSinceLastSmoke}" />
            
              </td>
          </tr>

         

          <tr class="prop">
              <td colspan="2" class="name ${hasErrors(bean: socialHistoryInstance, field: 'secHandSmHist1', 'errors')}">
                <label>${labelNumber++}. Was the Participant exposed to secondhand smoke?</label>
               
                <div class="subentry value secHandSmHist">
                  <g:radio id ="secHandSmHist1" name="secHandSmHist1" value="No" checked="${socialHistoryInstance?.secHandSmHist1 == 'No'}"/>&nbsp;<label for="secHandSmHist1">No </label><br>
                  <g:radio id ="secHandSmHist2" name="secHandSmHist1" value="Yes" checked="${socialHistoryInstance?.secHandSmHist1 == 'Yes'}"/>&nbsp;<label for="secHandSmHist2">Yes</label><br>
                 <div id="secHandSmokeHistYesDiv" class="depends-on" data-id="secHandSmHist2">&nbsp;&nbsp;&nbsp;&nbsp;
                  <g:checkBox id ="secHandSmHist3" name="secHandSmHist2" value="Exposure to secondhand smoke in Participant’s childhood" checked="${socialHistoryInstance?.secHandSmHist2 == 'Exposure to secondhand smoke in Participant’s childhood'}" />&nbsp;
                  <label for="secHandSmHist3">Exposure to secondhand smoke in Participant’s childhood</label><br>
                  <g:checkBox id ="secHandSmHist4" name="secHandSmHist3" value="Exposure to secondhand smoke in Participant’s Adulthood" checked="${socialHistoryInstance?.secHandSmHist3 == 'Exposure to secondhand smoke in Participant’s Adulthood'}" />&nbsp;
                  <label for="secHandSmHist4">Exposure to secondhand smoke in Participant’s Adulthood</label><br>
                  </div>
                  
                  
                  <g:radio id ="secHandSmHist3" name="secHandSmHist1" value="Not Available" checked="${socialHistoryInstance?.secHandSmHist1 == 'Not Available'}"/>&nbsp;<label for="secHandSmHist3">Not Available</label><br>
                  
                 
                </div>
              </td>
          </tr>

          
              
      </tbody>
  </table>
</div>