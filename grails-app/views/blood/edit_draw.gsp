<%@ page import="nci.bbrb.cdr.forms.blood.Draw" %>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'draw.label', default: 'Draw')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript>
           $(document).ready(function(){
             $("#h1").click(function(){
  
             $("#issues").show()
             
             });
           
              $("#h2").click(function(){
  
              $("#issues").hide()
             
             });
           
             
              $("#c1").click(function(){
  
             $("#cids").show()
             
             });
           
              $("#c2").click(function(){
  
              $("#cids").hide()
             
             });
             
             $("#g1").click(function(){
  
             $("#gids").show()
             
             });
           
              $("#g2").click(function(){
  
              $("#gids").hide()
             
             });
           
              $("#a1").click(function(){
  
              $("#newtube").show();
              $("#button1").hide();
              return false;
             
             });

          $("#a2").click(function(){
  
              $("#newaq").show();
              $("#button2").hide();
              return false;
             
             });
           


$(".recorddate").change(function(){
   //  alert("heeee")
    var now = new Date();
    var dd= now.getDate();
    var MM= now.getMonth() + 1;
    var yyyy=now.getFullYear()
    var HH=now.getHours()
    var mm=now.getMinutes()
    
    var ph=''
    
    if(HH==0 || HH==1 || HH==2 || HH==3 || HH==4 || HH==5 || HH==6 || HH==7 || HH==8 || HH==9 ){
      ph='0'
    }
    
    var pm=''
    if(mm==0 || mm==1 || mm==2 || mm==3 || mm==4 || mm==5 || mm==6 || mm==7 || mm==8 || mm==9 ){
      pm='0'
    }

    var now_str = ''+MM+'/'+dd+'/'+yyyy+' ' +ph  +HH+":" +pm + mm
   // alert(now_str)

    var map = {"new_scan_f_id1":"time_frozen_1","new_scan_t_id1":"time_trans_1","new_scan_f_id2":"time_frozen_2","new_scan_t_id2":"time_trans_2","new_scan_f_id3":"time_frozen_3","new_scan_t_id3":"time_trans_3","new_scan_f_id4":"time_frozen_4","new_scan_t_id4":"time_trans_4","new_scan_f_id5":"time_frozen_5","new_scan_t_id5":"time_trans_5"}
  
    

    var name=this.name
   // alert(name)
    var target=map[name]
   if(target!=null && target.length > 0){
    var target_value=document.getElementById(target).value
    if(target_value == null || target_value.length ==0)
     document.getElementById(target).value=now_str
    }
    
    var index = name.indexOf("_")
    id=name.substring(index+ 1)
    var prefix = name.substring(0, index)
    if(prefix=='scanid1'){
     var target = "timef_" + id
      if(target_value == null || target_value.length ==0)
     document.getElementById(target).value=now_str
    }else if(prefix=='scanid2'){
       var target = "timet_" + id
      if(target_value == null || target_value.length ==0)
     document.getElementById(target).value=now_str
    

    }else{
    }
   


   });



           });
           
     function del_ct(id){
            
              document.getElementById("delete_ct").value=id;
              
  
                
              return confirm("Are you sure?")
           }

 function del_aq(id){
            
              document.getElementById("delete_aq").value=id;
             
              return confirm("Are you sure?")
           }
             
           </g:javascript>   
    </head>
	<body>
		<div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="edit" id="${drawInstance.blood.id}">Blood Form</g:link>
                       </div>
                       </div>

		 <div id="container" class="clearfix">
			<h1>Edit Blood Draw</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
                         <g:hasErrors bean="${drawInstance}">
                        <div class="errors">
                           <g:renderErrors bean="${drawInstance}" as="list" />
                          </div>
                         </g:hasErrors>
			
			<g:form url="[controller:'blood', action:'update_draw']" method="POST" >
                            <g:hiddenField name="id" value="${drawInstance?.id}" />
				<g:hiddenField name="version" value="${drawInstance?.version}" />
                             <g:hiddenField name="delete_ct" value="" />   
                             <g:each in="${drawInstance.collectionTubes}" status="i" var="t">
                                <g:hiddenField name="isctid_${t.id}" value="isctid" /> 
                             </g:each>
                               <g:hiddenField name="delete_aq" value="" /> 
                        <g:each in="${drawInstance.aliquots}" status="i" var="t">
                                <g:hiddenField name="isaqid_${t.id}" value="isaqid" /> 
                             </g:each>
				<fieldset class="form">
					<div class="list">
    <table>
        <tbody>

          <tr class="prop">
              <td colspan="2" class="formheader">Blood Collection Instruction</td>
           </td>
            
       
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="minimumReqMet">1. The minimum requirement was met for blood collection as per the SOP:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'minimumReqMet', 'errors')}">
                <div>
                 <g:radio name="minimumReqMet" id='m1' value="Yes" checked="${drawInstance?.minimumReqMet =='Yes'}"/>&nbsp;<label for="m1">Yes</label>&nbsp;&nbsp;&nbsp;
                 <g:radio name="minimumReqMet" id='m2' value="No" checked="${drawInstance?.minimumReqMet =='No'}"/>&nbsp;<label for="m2">No</label>
                 </div>
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="bloodDrawType"><g:message code="draw.bloodDrawType.label" default="2. Blood draw type:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'bloodDrawType', 'errors')}">
                <g:select id="bloodDrawType" name="bloodDrawType.id" from="${nci.bbrb.cdr.staticmembers.BloodDrawType.list()}" optionKey="id" value="${drawInstance?.bloodDrawType?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeDraw">3. Date and time blood was drawn:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeDraw', 'errors')}">
                 <g:jqDateTimePicker  name="dateTimeDraw" value="${drawInstance?.dateTimeDraw}" />
            </td>
        </tr>

        
         <tr class="prop">
            <td valign="top" class="name">
                <label for="bloodDrawBy"><g:message code="draw.bloodDrawBy.label" default="4. Blood draw was performed by:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'bloodDrawBy', 'errors')}">
                <g:select id="bloodDrawBy" name="bloodDrawBy.id" from="${nci.bbrb.cdr.staticmembers.BloodDrawTech.list()}" optionKey="id" value="${drawInstance?.bloodDrawBy?.id}" class="many-to-one" noSelection="['null': '']"/>

            </td>
        </tr>

         <tr class="prop">
            <td valign="top" class="name">
                <label for="personName"><g:message code="draw.personName.label" default="5. Name of person performed blood draw:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'personName', 'errors')}">
                <g:textField name="personName" value="${drawInstance?.personName}"/>

            </td>
        </tr>

         <tr class="prop">
            <td valign="top" class="name">
                <label for="hasIssue">6. Were there any issues or difficulties with the blood draw?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'hasIssue', 'errors')}">
                 <g:radio name="hasIssue" id='h1' value="Yes" checked="${drawInstance?.hasIssue =='Yes'}"/>&nbsp;<label for="h1">Yes</label>&nbsp;&nbsp;&nbsp;
                 <g:radio name="hasIssue" id='h2' value="No" checked="${drawInstance?.hasIssue =='No'}"/>&nbsp;<label for="h2">No</label>
               
            </td>
        </tr>
        
        
        
           <tr class="prop" id="issues" style="display:${drawInstance?.hasIssue =='Yes'?'display':'none'}">
            <td valign="top" >
               if Yes, please specify
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'bloodDrawIssues', 'errors')}">
                      <g:textArea name="bloodDrawIssues" cols="40" rows="5" value="${drawInstance?.bloodDrawIssues}" />
                       </td>    

            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="collectionComments"><g:message code="draw.collectionComments.label" default="7. Blood Collection Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'collectionComments', 'errors')}">
                <g:textArea name="collectionComments" cols="40" rows="5" value="${drawInstance?.collectionComments}"/>

            </td>
        </tr>

      
         <tr class="prop">
              <td colspan="2" class="formheader">Blood Processing Overview</td>
           </td>
        
      <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeReceived"><g:message code="draw.dateTimeReceived.label" default="8. Date and time blood received in the lab:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeReceived', 'errors')}">
                
                 <g:jqDateTimePicker   name="dateTimeReceived" value="${drawInstance?.dateTimeReceived}"  />
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="receivedBy"><g:message code="draw.receivedBy.label" default="9. Blood tube(s) received in lab by:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'receivedBy', 'errors')}">
                <g:textField name="receivedBy" value="${drawInstance?.receivedBy}"/>

            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="temperatureStr"><g:message code="draw.temperatureStr.label" default="10. Temperature in lab when blood was received:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'temperatureStr', 'errors')}">
                <g:textField name="temperatureStr" value="${drawInstance?.temperatureStr}" size="5"/> ˚C

            </td>
        </tr>

  
        <tr class="prop">
            <td valign="top" class="name">
                <label for="humidityStr"><g:message code="draw.humidityStr.label" default="11. Humidity in lab when tube(s) were received:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'humidityStr', 'errors')}">
                <g:textField name="humidityStr" value="${drawInstance?.humidityStr}" size="5"/> %`

            </td>
        </tr>

<tr>
<td colspan="2">
<table>
<tr>
<th colspan="5">12. Blood Collection Tube  Details</th>
</tr>
<tr>
<th>Collection Tube Specimen Barcode ID</th>
<th>Specimen Tube Type </th>
 <th>Processed for </th>
 <th>Volume Collected (ml)</th>
 <th>Action</th>
</tr>
 <g:each in="${drawInstance.collectionTubes?.sort{it.id}}" status="i" var="t">
   <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
          <td class="${errorMap.get(t.id + "_ctid")}"><g:textField name="ctid_${t.id}" value="${t.collectionTubeId}" /></td>
          <td>    <g:select  name="cttype_${t.id}" from="${nci.bbrb.cdr.staticmembers.BloodTubeType.list()}" optionKey="id" value="${t.collectionTubeType?.id}" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:select  name="ctreason_${t.id}" from="${nci.bbrb.cdr.staticmembers.BloodCollectionReason.list()}" optionKey="id" value="${t.processedFor?.id}" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" class="${errorMap.get(t.id + "_ctvol")}" >
                <g:textField name="ctvolume_${t.id}" value="${t.volumeStr}"/>
  </td>
  <td> <g:if test="${!nci.bbrb.cdr.forms.blood.Aliquot.countByCollectionTube(t)}"><g:actionSubmit class="save" action="update_draw" value="Delete"  onclick="return del_ct('${t.id}')" /></g:if></td>
   </tr>
 </g:each>
 <tr class="prop" id="button1">
            <td valign="top" class="name">
           
             <g:actionSubmit action="update_draw" value="Add"  id="a1" />

            </td>
        </tr>
</table>
</td>
</tr>
        
<tr id='newtube'  style="display:none" bgcolor="#FFFFCC">
    <td colspan="2">
<table>
<tr>
  <th>Collection Tube Specimen Barcode ID</th>
<th>Specimen Tube Type </th>
 <th>Processed for </th>
 <th>Volume Collected (ml)</th>
<tr>
 <tr>
  <td><g:textField name="new_id1" /></td>
   <td valign="top" >
                <g:select  name="new_type1" from="${nci.bbrb.cdr.staticmembers.BloodTubeType.list()}" optionKey="id" value="" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:select  name="new_reason1" from="${nci.bbrb.cdr.staticmembers.BloodCollectionReason.list()}" optionKey="id" value="" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:textField name="new_volume1" />
  </td>
</tr>
<tr>
  <td><g:textField name="new_id2" /></td>
   <td valign="top" >
                <g:select  name="new_type2" from="${nci.bbrb.cdr.staticmembers.BloodTubeType.list()}" optionKey="id" value="" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:select  name="new_reason2" from="${nci.bbrb.cdr.staticmembers.BloodCollectionReason.list()}" optionKey="id" value="" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:textField name="new_volume2" />
  </td>
</tr>
<tr>
  <td><g:textField name="new_id3" /></td>
   <td valign="top" >
                <g:select  name="new_type3" from="${nci.bbrb.cdr.staticmembers.BloodTubeType.list()}" optionKey="id" value="" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:select  name="new_reason3" from="${nci.bbrb.cdr.staticmembers.BloodCollectionReason.list()}" optionKey="id" value="" class="many-to-one" noSelection="['null': '']"/>
  </td>
  <td valign="top" >
                <g:textField name="new_volume3" />
  </td>
</tr>
<tr><td colspan="4"><g:actionSubmit class="save"  action="update_draw" value="Save" /></td></tr>
</table>

    </td>
</tr>
        
 
       
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeProcessingStart"><g:message code="draw.dateTimeProcessingStart.label" default="13. Time blood processing began:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeProcessingStart', 'errors')}">
              <g:jqDateTimePicker   name="dateTimeProcessingStart" value="${drawInstance?.dateTimeProcessingStart}"  />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateTimeProcessingEnd"><g:message code="draw.dateTimeProcessingEnd.label" default="14. Time blood processing completed:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'dateTimeProcessingEnd', 'errors')}">
              <g:jqDateTimePicker   name="dateTimeProcessingEnd" value="${drawInstance?.dateTimeProcessingEnd}"  />

            </td>
        </tr>

    <tr class="prop">
    <td valign="top" class="name">15. Blood fraction aliquot details</td><td></td>
    </tr>
        
<tr>
<td colspan="2">
<table>
<tr>
<th colspan="9">15a. Blood fraction cryovial aliquot information</th>
</tr>
<tr>
  <th>Blood Collection Tube Source, Barcode ID </th>
<th>Aliquot Barcode ID: </th>
 <th>Aliquot Type:  </th>
 <th>Aliquot Volume (ml)</th>
 <th>Scanned ID: Record when Aliquot Frozen</th> 
 <th>Time Aliquot Frozen</th> 
 <th>Scanned ID: Record when Aliquot Transferred to Freezer</th>
 <th>Time Aliquot Transferred to Freezer</th>
<th>Action</th>


</tr>

<g:each in="${drawInstance.aliquots?.sort{it.id}}" status="i" var="a">
 <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  <td><g:select name="aqctid_${a.id}" from="${drawInstance.collectionTubes}" optionKey="id" optionValue="collectionTubeId" value="${a.collectionTube?.id}"/></td>
  <td class="${errorMap.get(a.id + '_aqid')}"><g:textField name="aqid_${a.id}" value="${a.aliquotId}"/></td>
   <td valign="top" >
                <g:select  name="aqtype_${a.id}" from="${nci.bbrb.cdr.staticmembers.BloodAliquotType.list()}" optionKey="id" value="${a.aliquotType?.id}" class="many-to-one" />
  </td>
  <td valign="top" class="${errorMap.get(a.id + '_aqvol')}">
                <g:textField name="aqvolume_${a.id}" size="5" value="${a.volumeStr}"/>
  </td>
  
  <td class="${errorMap.get(a.id + '_scan1')}"><g:textField name="scanid1_${a.id}" class="recorddate" value="${a.scannedId4Frozen}"/></td>
  <td class="${errorMap.get(a.id + '_timef')}"><g:textField id="timef_${a.id}" name="timef_${a.id}" value="${a.dateTimeFrozenStr}" size="16"/></td>
  <td class="${errorMap.get(a.id + '_scan2')}"><g:textField name="scanid2_${a.id}" class="recorddate" value="${a.scannedId4Trans}"  /></td>
  <td class="${errorMap.get(a.id + '_timet')}"><g:textField id="timet_${a.id}" name="timet_${a.id}" value="${a.dateTimeTransStr}" size="16" /></td>
  
  <td><g:actionSubmit class="save" action="update_draw" value="Delete"  onclick="return del_aq('${a.id}')" /></td>

</tr>


</g:each>
<g:if test="${drawInstance. collectionTubes}">
<tr class="prop" id="button2">
            <td valign="top" class="name">
           
             <g:actionSubmit action="update_draw" value="Add"  id="a2" />

            </td>
        </tr>
</g:if>
</table>
</td>
</tr>

<tr id='newaq' style="display:none"  bgcolor="#FFFFCC">
    <td colspan="2">
<table>
<tr>
  <th>Blood Collection Tube Source, Barcode ID </th>
<th>Aliquot Barcode ID: </th>
 <th>Aliquot Type:  </th>
 <th>Aliquot Volume (ml)</th>
 <th>Scanned ID: Record when Aliquot Frozen</th> 
 <th>Time Aliquot Frozen</th> 
 <th>Scanned ID: Record when Aliquot Transferred to Freezer</th>
 <th>Time Aliquot Transferred to Freezer</th>



<tr>
      <td><g:select name="new_source1" from="${drawInstance.collectionTubes}" optionKey="id" optionValue="collectionTubeId" /></td>
  <td><g:textField name="new_aq_id1" /></td>
   
   <td valign="top" >
                <g:select  name="new_aq_type1" from="${nci.bbrb.cdr.staticmembers.BloodAliquotType.list()}" optionKey="id" value="" class="many-to-one" />
  </td>
  <td valign="top" >
                <g:textField name="new_aq_volume1" />
  </td>
  
  <td><g:textField name="new_scan_f_id1" class="recorddate" /></td>
  <td><g:textField id="time_frozen_1" name="time_frozen_1" /></td>
  <td><g:textField name="new_scan_t_id1" class="recorddate" /></td>
  <td><g:textField id="time_trans_1" name="time_trans_1" /></td>
  
  
</tr>
<tr>
      <td><g:select name="new_source2" from="${drawInstance.collectionTubes}" optionKey="id" optionValue="collectionTubeId" /></td>
  <td><g:textField name="new_aq_id2" /></td>
   
   <td valign="top" >
                <g:select  name="new_aq_type2" from="${nci.bbrb.cdr.staticmembers.BloodAliquotType.list()}" optionKey="id" value="" class="many-to-one" />
  </td>
  <td valign="top" >
                <g:textField name="new_aq_volume2" />
  </td>
  
  <td><g:textField name="new_scan_f_id2" class="recorddate" /></td>
  <td><g:textField id="time_frozen_2" name="time_frozen_2" /></td>
  <td><g:textField name="new_scan_t_id2" class="recorddate" /></td>
  <td><g:textField id="time_trans_2" name="time_trans_2" /></td>
  
  
</tr>

<tr>
      <td><g:select name="new_source3" from="${drawInstance.collectionTubes}" optionKey="id" optionValue="collectionTubeId" /></td>
  <td><g:textField name="new_aq_id3" /></td>
   
   <td valign="top" >
                <g:select  name="new_aq_type3" from="${nci.bbrb.cdr.staticmembers.BloodAliquotType.list()}" optionKey="id" value="" class="many-to-one" />
  </td>
  <td valign="top" >
                <g:textField name="new_aq_volume3" />
  </td>
  
  <td><g:textField name="new_scan_f_id3" class="recorddate" /></td>
  <td><g:textField id="time_frozen_3" name="time_frozen_3" /></td>
  <td><g:textField name="new_scan_t_id3" class="recorddate" /></td>
  <td><g:textField id="time_trans_3" name="time_trans_3" /></td>
  
  
</tr>

<tr>
      <td><g:select name="new_source4" from="${drawInstance.collectionTubes}" optionKey="id" optionValue="collectionTubeId" /></td>
  <td><g:textField name="new_aq_id4" /></td>
   
   <td valign="top" >
                <g:select  name="new_aq_type4" from="${nci.bbrb.cdr.staticmembers.BloodAliquotType.list()}" optionKey="id" value="" class="many-to-one" />
  </td>
  <td valign="top" >
                <g:textField name="new_aq_volume4" />
  </td>
  
  <td><g:textField name="new_scan_f_id4" class="recorddate" /></td>
  <td><g:textField id="time_frozen_4" name="time_frozen_4" /></td>
  <td><g:textField name="new_scan_t_id4" class="recorddate" /></td>
  <td><g:textField id="time_trans_4" name="time_trans_4" /></td>
  
  
</tr>

<tr>
      <td><g:select name="new_source5" from="${drawInstance.collectionTubes}" optionKey="id" optionValue="collectionTubeId" /></td>
  <td><g:textField name="new_aq_id5" /></td>
   
   <td valign="top" >
                <g:select  name="new_aq_type5" from="${nci.bbrb.cdr.staticmembers.BloodAliquotType.list()}" optionKey="id" value="" class="many-to-one" />
  </td>
  <td valign="top" >
                <g:textField name="new_aq_volume5" />
  </td>
  
  <td><g:textField name="new_scan_f_id5" class="recorddate" /></td>
  <td><g:textField id="time_frozen_5" name="time_frozen_5" /></td>
  <td><g:textField name="new_scan_t_id5" class="recorddate" /></td>
  <td><g:textField id="time_trans_5" name="time_trans_5" /></td>
  
  
</tr>


<tr><td colspan="4"><g:actionSubmit class="save"  action="update_draw" value="Save" /></td></tr>
</table>

    </td>
</tr>
        
        
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="aliquotsProcessedBy"><g:message code="draw.aliquotsProcessedBy.label" default="15b. Aliquots were processed by" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'aliquotsProcessedBy', 'errors')}">
                <g:textField name="aliquotsProcessedBy" value="${drawInstance?.aliquotsProcessedBy}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="aliquotTransferredBy"><g:message code="draw.aliquotTransferredBy.label" default="15c. Frozen aliquot transfer completed by:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'aliquotTransferredBy', 'errors')}">
                <g:textField name="aliquotTransferredBy" value="${drawInstance?.aliquotTransferredBy}"/>

            </td>
        </tr>

         <tr class="prop">
              <td colspan="2" class="formheader">Note Deviations from SOP, Processing or Storage Issues</td>
           </td>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="procesingAccodSop"><g:message code="draw.procesingAccodSop.label" default="16. Blood Processing was performed in accordance with specified SOP" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'procesingAccodSop', 'errors')}">
                 <g:radio name="procesingAccodSop" id='p1' value="Yes" checked="${drawInstance?.procesingAccodSop =='Yes'}"/>&nbsp;<label for="p1">Yes</label>&nbsp;&nbsp;&nbsp;
                 <g:radio name="procesingAccodSop" id='p2' value="No" checked="${drawInstance?.procesingAccodSop =='No'}"/>&nbsp;<label for="p2">No</label>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="processingComments"><g:message code="draw.processingComments.label" default="17. Blood Processing Comments:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'processingComments', 'errors')}">
                 <g:textArea name="processingComments" cols="40" rows="5" value="${drawInstance?.processingComments}"/>
            </td>
        </tr>

        
        <tr class="prop" >
            <td valign="top" class="name">
                <label for="wasClotting"><g:message code="draw.wasClotting.label" default="18. Was Clotting observed in a collection tube? " /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'wasClotting', 'errors')}">
                <g:radio name="wasClotting" id='c1' value="Yes" checked="${drawInstance?.wasClotting =='Yes'}"/>&nbsp;<label for="c1">Yes</label>&nbsp;&nbsp;&nbsp;
                 <g:radio name="wasClotting" id='c2' value="No" checked="${drawInstance?.wasClotting =='No'}"/>&nbsp;<label for="c2">No</label>
                 
            </td>
        </tr>

         <tr class="prop"  id='cids' style="display:${drawInstance?.wasClotting =='Yes'?'display':'none'}">
            <td valign="top">
             If Yes, please specify blood collection tube IDs:
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'clottingTubeIds', 'errors')}">
                     <g:textArea name="clottingTubeIds" cols="40" rows="5" value="${drawInstance?.clottingTubeIds}"/>
            </td>
        </tr>
        
        <tr class="prop" >
            <td valign="top" class="name">
                <label for="grossHemolysis"><g:message code="draw.grossHemolysis.label" default="19. Was presence of Gross Hemolysis  observed?" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'grossHemolysis', 'errors')}">
                <g:radio name="grossHemolysis" id='g1' value="Yes" checked="${drawInstance?.grossHemolysis =='Yes'}"/>&nbsp;<label for="g1">Yes</label>&nbsp;&nbsp;&nbsp;
                 <g:radio name="grossHemolysis" id='g2' value="No" checked="${drawInstance?.grossHemolysis =='No'}"/>&nbsp;<label for="g2">No</label>

            </td>
        </tr>

         <tr class="prop"  id='gids' style="display:${drawInstance?.grossHemolysis =='Yes'?'display':'none'}">
            <td valign="top">
             If Yes, please specify blood collection tube IDs:
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'hemolysisTubeIds', 'errors')}">
                   <g:textArea name="hemolysisTubeIds" cols="40" rows="5" value="${drawInstance?.hemolysisTubeIds}"/>
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="storageIssue"><g:message code="draw.storageIssue.label" default="20. Storage Issues:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: drawInstance, field: 'storageIssue', 'errors')}">
                <g:textArea name="storageIssue" cols="40" rows="5" value="${drawInstance?.storageIssue}"/>
            </td>
        </tr>

        
        
        
        

        </tbody>
    </table>
</div>  

				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save"  action="update_draw" value="Save" />
                                        <g:if test="${!drawInstance.collectionTubes}">
                                            <g:actionSubmit class="save"  action="delete_draw" value="Delete" onclick="return confirm('Are you sure?');" />
                                        </g:if>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
