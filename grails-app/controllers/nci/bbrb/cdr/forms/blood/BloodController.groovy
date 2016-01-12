package nci.bbrb.cdr.forms.blood



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.text.SimpleDateFormat
import nci.bbrb.cdr.datarecords.*


@Transactional(readOnly = true)
class BloodController {
    def bloodService
    def accessPrivilegeService

    static allowedMethods = [saveDraw:"POST", submit: "POST", resume: "POST", update: "POST", update_draw: "POST", delete_draw: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Blood.list(params), model:[bloodInstanceCount: Blood.count()]
    }

    def show(Blood bloodInstance) {
        def caseRecordInstance=bloodInstance.caseRecord
        if(!accessPrivilegeService.hasPrivilegeCase(caseRecordInstance, session, "show")){
             redirect(controller: "login", action: "denied")
            return
        }
        
        def canModify=false
        if(session.DM && ((caseRecordInstance?.caseStatus?.code == 'INIT' || caseRecordInstance?.caseStatus?.code == 'DATA'  || caseRecordInstance?.caseStatus?.code == 'REMED') ||(caseRecordInstance?.caseStatus?.code == 'QA' && session.org?.code=='DCC'))){
            canModify=true
        }
        respond bloodInstance, model:[canModify:canModify]
    }

    def create() {
        respond new Blood(params)
    }

    @Transactional
    def save() {
        def blood = new Blood(params)  
        def caseRecordInstance=blood.caseRecord
        if(!accessPrivilegeService.hasPrivilegeCase(caseRecordInstance, session, "edit")){
             redirect(controller: "login", action: "denied")
            return
        }
        blood.save flush:true
        redirect (action: "edit", params:[id:blood.id])

       
    }

    
     def saveDraw= {
      
          def draw = new Draw(params)
        
         def caseRecordInstance=draw.blood.caseRecord
        if(!accessPrivilegeService.hasPrivilegeCase(caseRecordInstance, session, "edit")){
             redirect(controller: "login", action: "denied")
            return
        }
        
        
          bloodService.saveDraw(draw)
         // draw.save flush:true
       
        
        redirect (action: "edit_draw", params:[id:draw.id])

       
    }

    def edit(Blood bloodInstance) {
        
          def caseRecordInstance=bloodInstance.caseRecord
        if(!accessPrivilegeService.hasPrivilegeCase(caseRecordInstance, session, "edit")){
             redirect(controller: "login", action: "denied")
            return
        }
        if(bloodInstance.dateSubmitted){
             redirect(controller: "login", action: "denied")
            return
        }
        def errorMap=[:]
        def canSubmit=true
        def draws = bloodInstance.draws
        
        
        
        draws.each(){
            if(!drawStated(it)){
                errorMap.put("${it.id}_draw".trim(), "errors")
                bloodInstance.errors.reject("no data in blood draw  ${it.id} form", "no data in blood draw  ${it.id} form")
                canSubmit=false
            }else{
            def result=checkErrorDraw(it)
            if(result){
                errorMap.put("${it.id}_draw".trim(), "errors")
                bloodInstance.errors.reject("data entry error with blood draw ${it.id}", "data entry error with blood draw ${it.id}")
                canSubmit=false
            }
            }
        }
        if(!draws && !bloodInstance.comments){
            canSubmit=false
        }
      
        respond bloodInstance, model:[errorMap:errorMap, canSubmit:canSubmit]
    }
    
    def edit_draw(Draw drawInstance){
        
          def caseRecordInstance=drawInstance.blood.caseRecord
        if(!accessPrivilegeService.hasPrivilegeCase(caseRecordInstance, session, "edit")){
             redirect(controller: "login", action: "denied")
            return
        }
        if(drawInstance.blood.dateSubmitted){
             redirect(controller: "login", action: "denied")
            return
        }
        
        
        def inObj=["minimumReqMet", "dateTimeDraw", "dateTimeReceived", "temperatureStr","humidityStr", "dateTimeProcessingStart", "dateTimeProcessingEnd"]
       
        def errorMap=[:]
        if(drawStated(drawInstance)){
         def result= checkErrorDraw(drawInstance)
              

                if(result){
                 
                    result.each(){key,value->
                        if(inObj.contains(key)){
                       drawInstance.errors.rejectValue(key, null, value)
                        }else{
                               drawInstance.errors.reject(value, value)
                             
                              errorMap.put(key, "errors")
                        }

                    }//each
                }
        }
        respond  drawInstance,  model:[errorMap:errorMap]
    }

    @Transactional
    def submit(Blood bloodInstance) {
        
         def canSubmit=true
        def draws = bloodInstance.draws
        draws.each(){
            if(!drawStated(it)){
                canSubmit=false
            }else{
                def result=checkErrorDraw(it)
                if(result){
                    canSubmit=false
                }
            }
        }
       
        if(canSubmit){
            
             def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
                
              bloodService.submitForm(bloodInstance, username)
             redirect(action:"show", params:[id:bloodInstance.id])
        }else{
            redirect(action:"edit", params:[id:bloodInstance.id])
            return
        }
        
       
    }

    
   
    @Transactional
    def update(Blood bloodInstance) {
        
        bloodInstance.save flush:true
        redirect(action:"edit", params:[id:bloodInstance.id])
        
    }

    
    
     @Transactional
    def update_draw() {
       def drawInstance = Draw.get(params.id)
         if (drawInstance == null) {
                 notFound()
                 return
             }

             if (drawInstance.hasErrors()) {
                 respond drawInstance.errors, view:'edit_draw'
                 return
             }

        bloodService.updateDraw(params)
        
        flash.message = message(code: 'default.updated.message', args: [message(code: 'Draw.label', default: 'Draw'), drawInstance.id])
        redirect (action:"edit_draw", params:[id:drawInstance.id])

       
    }
    
    
      @Transactional
    def delete_draw() {
       def drawInstance = Draw.get(params.id)
       def drawid = drawInstance.id
         if (drawInstance == null) {
                 notFound()
                 return
             }

             if (drawInstance.hasErrors()) {
                 respond drawInstance.errors, view:'edit_draw'
                 return
             }

        if(drawInstance.collectionTubes){
            flash.message = 'can not delete blood draw '+  drawInstance.id
           redirect (action:"edit_draw", params:[id:drawInstance.id])
          return
            
        }
        def blood = drawInstance.blood
        blood.removeFromDraws(drawInstance)
        drawInstance.delete flush:true
        blood.save flush:true
        
        flash.message = "blood draw " + drawid + " has been deleted"
        redirect (action:"edit", params:[id:blood.id])

       
    }
    
    @Transactional
    def delete(Blood bloodInstance) {

        if (bloodInstance == null) {
            notFound()
            return
        }

        bloodInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Blood.label', default: 'Blood'), bloodInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'blood.label', default: 'Blood'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }

 
    def resume={
         def bloodInstance = Blood.get(params.id)
             
        try{
           
            bloodInstance.dateSubmitted=null
            bloodInstance.submittedBy=null
          
            bloodInstance.save flush:true
          
            redirect(action:"edit", params:[id:bloodInstance.id])
           
            // redirect(action:"edit", params:[id:prcReportInstance.id])
        }catch(Exception e){
            flash.message="Failed: " + e.toString() 
           
            redirect(action:"view", params:[id:bloodInstance.id])
         
        }
        
        
    }
    
     Map checkErrorDraw(drawInstance){
      
        def result = [:]
         def ctList = bloodService.getCollectionTubes(drawInstance.blood)
         def aqList = bloodService.getAliquots(drawInstance.blood)
        
        if(!drawInstance.minimumReqMet){
            result.put("minimumReqMet", "The minimum requirement was met for blood collection as per the SOP is a required field.")
        }
        
        if(!drawInstance.dateTimeDraw){
            result.put("dateTimeDraw", "The Date and time blood was drawn is a required field.")
        }
        if(drawInstance.collectionTubes){
         if(!drawInstance.dateTimeReceived){
            result.put("dateTimeReceived", "The Date and time blood received in the lab is a required field.")
        }
       
         if(!drawInstance.temperatureStr){
            result.put("temperatureStr", "The Temperature in lab when blood was received is a required field.")
        }
        
         if(drawInstance.temperatureStr && !bloodService.isFloat(drawInstance.temperatureStr)){
            result.put("temperatureStr", "The Temperature in lab when blood was received must be a number.")
        }
        
         if(!drawInstance.humidityStr ){
            result.put("humidityStr", "The Humidity in lab when tube(s) were received is a required field.")
        }
        
        if(drawInstance.humidityStr && !bloodService.isFloat(drawInstance.humidityStr)){
            result.put("humidityStr", "The Humidity in lab when tube(s) were received must be a number.")
        }
        }
        if(drawInstance.aliquots){
         if(!drawInstance.dateTimeProcessingStart){
            result.put("dateTimeProcessingStart", "The Date and time blood was drawn is a required field.")
        }
        
          if(!drawInstance.dateTimeProcessingEnd){
            result.put("dateTimeProcessingEnd", "The Time blood processing completed is a required field.")
        }
        }
        def collectionTubes=drawInstance.collectionTubes
        collectionTubes.each(){
            
            def collectionTubeId = it.collectionTubeId
            if(!collectionTubeId){
                 result.put("${it.id}_ctid".trim(), "The Collection tube ID is a required field")
            }
            def volumeStr = it.volumeStr
            if(!volumeStr){
                result.put("${it.id}_ctvol".trim(), "The Volume Collected ${collectionTubeId} is a required field.")
            }else{
                if(!bloodService.isFloat(volumeStr)){
                    result.put("${it.id}_ctvol".trim(), "The Volume Collected ${collectionTubeId} must be a number.")
                }
            }
            
            if(tubeIdExists(ctList, it)){
                result.put("${it.id}_ctid".trim(), "The Collection tube ID ${collectionTubeId} exits in this or other draw.")
            }
            
        }
        
        
         def aliquots=drawInstance.aliquots
         
          aliquots.each(){
             def aliquotId = it.aliquotId
             
             def volumeStr = it.volumeStr
            if(!volumeStr){
                result.put("${it.id}_aqvol".trim(), "The Volume Collected for ${aliquotId} is a required field.")
            }else{
                if(!bloodService.isFloat(volumeStr)){
                    result.put("${it.id}_aqvol".trim(), "The Volume Collected for ${aliquotId} must be a number.")
                }
            }
             
            if(!aliquotId){
                 result.put("${it.id}_aqid".trim(), "The Aliquort ID is a required field")
            }
            
              if(aliquotId && aliquotIdExists(aqList, it)){
                result.put("${it.id}_aqid".trim(), "The Aliquort ID ${aliquotId} exits in this or other draw.")
            }
            
             def caseId=  speciemenExists(it)
             if(caseId){
                 result.put("${it.id}_aqid".trim(), "The Aliquort ID ${aliquotId} is same as a specimen ID of case ${caseId}.")
             }
             
             def scannedId4Frozen=it.scannedId4Frozen
             
              if(scannedId4Frozen && scannedId4Frozen != aliquotId){
                  result.put("${it.id}_scan1".trim(), "The Scanned ID ${scannedId4Frozen} is not same as aliquotId  ${aliquotId}.")
              }
              
              def dateTimeFrozenStr=it.dateTimeFrozenStr  
              if(!dateTimeFrozenStr){
                  result.put("${it.id}_timef".trim(), "The Time Aliquot Frozen for ${aliquotId} is a required field")
              }else {
                  if(!bloodService.isDate(dateTimeFrozenStr)){
                       result.put("${it.id}_timef".trim(), "Wrong date format for ${aliquotId}")
                  }
                    
              }
             
                
               def scannedId4Trans=it.scannedId4Trans
             
              if(scannedId4Trans && scannedId4Trans != aliquotId){
                  result.put("${it.id}_scan2".trim(), "The Scanned ID ${scannedId4Trans} is not same as aliquotId  ${aliquotId}.")
              }
              
              def dateTimeTransStr=it.dateTimeTransStr  
              if(!dateTimeTransStr){
                  result.put("${it.id}_timet".trim(), "The Time Aliquot Transferred to Freezer for ${aliquotId} is a required field")
              }else {
                  if(!bloodService.isDate(dateTimeTransStr)){
                       result.put("${it.id}_timet".trim(), "Wrong date format for ${aliquotId}")
                  }
                    
              }
            
          }
         
    
      
     
        return result
    }

    
    boolean tubeIdExists(list, tube){
        def result = false
        list.each(){
            if(it.collectionTubeId ==tube.collectionTubeId && it.id != tube.id){
                result=true
            }
        }
       return result 
    }
    
    boolean aliquotIdExists(list, aliquot){
        def result = false
        list.each(){
            if(it.aliquotId ==aliquot.aliquotId && it.id != aliquot.id){
                result=true
            }
        }
       return result 
    }
    
        
    String speciemenExists(aliquot){
        
        def caseId=""
        def aliquotId = aliquot.aliquotId
        def thisCase = aliquot.draw.blood.caseRecord
        def specimenRecord= SpecimenRecord.findBySpecimenId(aliquotId)
        if(specimenRecord){
            if(specimenRecord.id != aliquot.specimenRecord?.id && specimenRecord.tissueType?.code != 'BLOOD' && specimenRecord.caseRecord.id ==thisCase.id ){
                caseId=thisCase.caseId
            }else if(specimenRecord.id != aliquot.specimenRecord?.id && specimenRecord.caseRecord.id !=thisCase.id ){
                caseId=specimenRecord.caseRecord.caseId
            }else{
            }
                
        }
        
            return caseId
    }
    
    boolean drawStated(drawInstance){
        if(drawInstance.version > 0 || drawInstance.collectionTubes ){
            return true
        }else{
            return false
        }
    }
}
