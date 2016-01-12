<%@ page import="nci.bbrb.cdr.prc.PrcReport" %>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'prcReport.label', default: 'PrcReport')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <g:javascript>
           $(document).ready(function(){
           showTumorSection()
           $(":input").change(function(){
                  document.getElementById("changed").value = "Y"
                  //alert("Changed!")
                });
                
            $("#tissueCategory").change(function(){
             
               showTumorSection()
            
             });  
             
             
             $("#verify").click(function() {
                    var val = document.getElementById("tumorDimension").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The greatest tumor dimension on slidet must be a number")
                        document.getElementById("tumorDimension").focus()
                        return false
                    }

                    val = document.getElementById("pctTumorArea").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The percent of cross-sectional surface area composed of tumor focus must be a number")
                        document.getElementById("pctTumorArea").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("The percent of cross-sectional surface area composed of tumor focus must be between 0 and 100")
                        document.getElementById("pctTumorArea").focus()
                        return false
                    }

                    val = document.getElementById("pctTumorCellularity").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The percent of tumor cellularity by cell count of the entire slide must be a number")
                        document.getElementById("pctTumorCellularity").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("The percent of tumor cellularity by cell count of the entire slide must be between 0 and 100")
                        document.getElementById("pctTumorCellularity").focus()
                        return false
                    }
                    
                    
                     val = document.getElementById("pctNecroticTissue").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("Percent of cross-sectional surface area of entire slide composed of necrotic tissue must be a number")
                        document.getElementById("pctNecroticTissue").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("Percent of cross-sectional surface area of entire slide composed of necrotic tissue must be between 0 and 100")
                        document.getElementById("pctNecroticTissue").focus()
                        return false
                    }

                    val = document.getElementById("p1").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The percent viable tumor by surface area must be a number")
                        document.getElementById("p1").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("The percent viable tumor by surface area must be between 0 and 100")
                        document.getElementById("p1").focus()
                        return false
                    }

                    val = document.getElementById("p2").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The percent necrotic tumor by surface area must be a number")
                        document.getElementById("p2").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("The percent necrotic tumor by surface area must be between 0 and 100")
                        document.getElementById("p2").focus()
                        return false
                    }

                    val = document.getElementById("p3").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The percent viable non-tumor tissue by surface area must be a number")
                        document.getElementById("p3").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("The percent viable non-tumor tissue by surface area must be between 0 and 100")
                        document.getElementById("p3").focus()
                        return false
                    }

                    val = document.getElementById("p4").value
                    val = val.replace(/,/g, '')
                    if (val != null && isNaN(val)) {
                        alert("The percent viable non-tumor tissue by surface area must be a number")
                        document.getElementById("p4").focus()
                        return false
                    }
                    if (val < 0 || val > 100) {
                        alert("The percent viable non-tumor tissue by surface area must be between 0 and 100")
                        document.getElementById("p4").focus()
                        return false
                    }
                });    
             
                
                
                $("#p1").change(function() {
                    calculateTotal()
                });

                $("#p2").change(function() {
                    calculateTotal()
                });

                $("#p3").change(function() {
                    calculateTotal()
                });

                $("#p4").change(function() {
                    calculateTotal()
                   // var pct = document.getElementById("p4").value
                });
        
            });
            
           function sub(){
            var changed = document.getElementById("changed").value
            if(changed == "Y"){
               alert("Please save the change!")
               return false
               }
            
          }
          
          
            function calculateTotal() {
                var pct1 = document.getElementById("p1").value
                var pct2 = document.getElementById("p2").value
                var pct3 = document.getElementById("p3").value
                var pct4 = document.getElementById("p4").value

                if (pct1 == '')
                    pct1=0
                if (pct2 == '')
                    pct2 = 0
                if (pct3 == '')
                    pct3 = 0
                if(pct4 == '')
                    pct4 = 0

                var hisTotal
                if (!isNaN(pct1) && !isNaN(pct2) && !isNaN(pct3) && !isNaN(pct4)) {
                    hisTotal = pct1*1 + pct2*1 + pct3*1 + pct4*1
                    document.getElementById("t").value = hisTotal    
                }
            }
          
         function showTumorSection(){
            var cat=$("#tissueCategory option:selected").text();
              // alert("cat: " + cat)
               if(cat=='Tumor'){
                 $(".tumor").each(function(){
                        $(this).show()
                     });
                 }else{
                      $(".tumor").each(function(){
                          $(this).hide()
                        });
                 }
            
         }
          
          
          
            
        </g:javascript>
    </head>
	<body>
		<div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                       </div>
                       </div>

		 <div id="container" class="clearfix">
			<h1>Edit PRC Report</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
                         <g:hasErrors bean="${prcReportInstance}">
                          <div class="errors">
                           <g:renderErrors bean="${prcReportInstance}" as="list" />
                           </div>
                      </g:hasErrors>
			 <g:render template="/caseRecord/caseDetails" bean="${prcReportInstance.slideRecord.specimenRecord.caseRecord}" var="caseRecord" /> 
			<g:form url="[resource:prcReportInstance, action:'update']" method="POST" >
				<g:hiddenField name="version" value="${prcReportInstance?.version}" />
                                  <input type="hidden" name="changed" value="N" id="changed"/>

				<fieldset class="form">
					<div class="list">
                <table class="tdwrap">
                    <tbody>

                      <tr class="prop">
                        <td valign="top" class="name">
                            <label for="slideRecord"><g:message code="prcReport.slideRecord.label" default="Slide record" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'slideRecord', 'errors')}">
                         <g:link controller="slideRecord" action="show" id="${prcReportInstance?.slideRecord?.id}">   ${prcReportInstance?.slideRecord?.slideId}</g:link>

                        </td>
                    </tr>
                    
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="slideRecord">Block ID</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'slideRecord', 'errors')}">
                         <g:link controller="specimenRecord" action="show" id="${prcReportInstance?.slideRecord?.specimenRecord.id}">   ${prcReportInstance?.slideRecord?.specimenRecord.specimenId}</g:link>

                        </td>
                    </tr>

                    
                    
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="organOrigin"><g:message code="prcReport.organOrigin.label" default="Organ origin" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'organOrigin', 'errors')}">
                              <g:select id="organOrigin" name="organOrigin.id" from="${nci.bbrb.cdr.staticmembers.TissueType.list()}" optionKey="id" value="${prcReportInstance?.organOrigin?.id}" class="many-to-one" />
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="tissueCategory"><g:message code="prcReport.tissueCategory.label" default="Tissue category" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'tissueCategory', 'errors')}">
                            <g:select id="tissueCategory" name="tissueCategory.id" from="${nci.bbrb.cdr.staticmembers.TissueCategory.list()}" optionKey="id" value="${prcReportInstance?.tissueCategory?.id}" class="many-to-one" />

                        </td>
                    </tr>
                    
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="diagnosis">Diagnosis/Morphology </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'diagnosis', 'errors')}">
                            <g:textArea name="diagnosis" cols="40" rows="5" maxlength="4000" value="${prcReportInstance?.diagnosis}"/>

                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="autolysis">Autolysis rating</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'autolysis', 'errors')}">
                            <div>
                            <g:radio name="autolysis" id="a0"  value="0" checked="${prcReportInstance.autolysis =='0'}"/><label for="a0">0</label>&nbsp;&nbsp;&nbsp;
                            <g:radio name="autolysis" id="a1"  value="1" checked="${prcReportInstance.autolysis =='1'}"/><label for="a1">1</label>&nbsp;&nbsp;&nbsp;
                            <g:radio name="autolysis" id="a2"  value="2" checked="${prcReportInstance.autolysis =='2'}"/><label for="a2">2</label>&nbsp;&nbsp;&nbsp;
                            <g:radio name="autolysis" id="a3"  value="3" checked="${prcReportInstance.autolysis =='3'}"/><label for="a3">3</label>
                          </div>    

                        </td>
                    </tr>


                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="comments"><g:message code="prcReport.comments.label" default="Comments" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'comments', 'errors')}">
                            <g:textArea name="comments" cols="40" rows="5" maxlength="4000" value="${prcReportInstance?.comments}"/>

                        </td>
                    </tr>

          

                    <tr class="prop tumor" style="display:none">
                        <td valign="top" class="name">
                            <label for="tumorDimension">Greatest tumor dimension on slide</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'tumorDimension', 'errors')}">
                            <g:field name="tumorDimension" value="${fieldValue(bean: prcReportInstance, field: 'tumorDimension')}"/> (mm)

                        </td>
                    </tr>


                    <tr class="prop tumor" style="display:none">
                        <td valign="top" class="name">
                            <label for="pctTumorArea">Percent of cross-sectional surface area of entire slide composed of tumor focus</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'pctTumorArea', 'errors')}">
                            <g:field name="pctTumorArea" value="${fieldValue(bean: prcReportInstance, field: 'pctTumorArea')}"/> %

                        </td>
                    </tr>


                    <tr class="prop tumor" style="display:none">
                        <td valign="top" class="name">
                            <label for="pctTumorCellularity">Percent of tumor nuclei by cell count of the entire slide </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'pctTumorCellularity', 'errors')}">
                            <g:field name="pctTumorCellularity" value="${fieldValue(bean: prcReportInstance, field: 'pctTumorCellularity')}"/> %

                        </td>
                    </tr>

                   
                    <tr class="prop tumor" style="display:none">
                        <td valign="top" class="name">
                            <label for="pctNecroticTissue">Percent of cross-sectional surface area of entire slide composed of necrotic tissue</label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'pctNecroticTissue', 'errors')}">
                            <g:field name="pctNecroticTissue" value="${fieldValue(bean: prcReportInstance, field: 'pctNecroticTissue')}"/> %

                        </td>
                    </tr>

                     <tr class="tumor" style="display:none"><td class="name" colspan="2">Histologic profile quantitative assessment</td></tr>
                     <tr class="tumor" style="display:none"><td colspan="2">
                     <table class="formvaluediv">
                                                <tr>
                                                    <td >Percent viable tumor by surface area (not including stroma)</td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctViablTumor', 'errors')}" style=" width:25%"><input type="text" id="p1" name="pctViablTumor" value="${fieldValue(bean: prcReportInstance, field: 'pctViablTumor')}" SIZE="10" /> %</td>
                                                </tr>
                                                <tr>
                                                    <td >Percent necrotic tumor by surface area</td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctNecroticTumor', 'errors')}" ><input type="text" id="p2" name="pctNecroticTumor" value="${fieldValue(bean: prcReportInstance, field: 'pctNecroticTumor')}" SIZE="10" /> %</td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                        Percent tumor stroma by surface area
                                                    </td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctViableNonTumor', 'errors')}" ><input type="text" id="p3" name="pctViableNonTumor" value="${fieldValue(bean: prcReportInstance, field: 'pctViableNonTumor')}" SIZE="10" /> %</td>
                                                </tr>
                                                <tr>
                                                    <td>Percent Non-Cellular component by surface area (i.e., mucin, hemorrhage, blood clot, etc.)</td>
                                                    <td class="value ${hasErrors(bean: prcReportInstance, field: 'pctNonCellular', 'errors')}"><input type="text" id="p4" name="pctNonCellular" value="${fieldValue(bean: prcReportInstance, field: 'pctNonCellular')}" SIZE="10" /> %</td>
                                                </tr>
                                                <tr>
                                                    <td class="formheader">Histologic profile total % (should equal 100%)</td>
                                                    <td class="formheader ${hasErrors(bean: prcReportInstance, field: 'hisTotal', 'errors')}"><input type="text" id="t" name="hisTotal" value="${fieldValue(bean: prcReportInstance, field: 'hisTotal')}" SIZE="10" /> %</td>
                                                </tr> 
                                            </table>
                                        </td> 
                                   </tr>
     
                    </tbody>
                </table>
            </div>  

				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" id="verify" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                         <g:if test="${canSub}">
                                             <span class="button"><g:actionSubmit class="save" action="submit" value="Submit" onclick="return sub()" /></span>
                                       </g:if>  
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
