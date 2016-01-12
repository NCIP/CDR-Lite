package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.SlideRecord


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SlidePrepController {

     def accessPrivilegeService
    

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SlidePrep.list(params), model:[slidePrepInstanceCount: SlidePrep.count()]
    }

    def show(SlidePrep slidePrepInstance) {
        //respond slidePrepInstance
        def canResume
        if(!accessPrivilegeService.hasPrivilege(slidePrepInstance?.caseRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        canResume=true
        
        
        
        [slidePrepInstance: slidePrepInstance, canResume: canResume]
    }

    def create() {
        
        //respond new SlidePrep(params)
        def slidePrepInstance=new SlidePrep(params)
        def caseid=CaseRecord.get(params.caseRecord.id)?.id
        
        def slidesList= SlideRecord.executeQuery("select sl from SlideRecord sl inner join sl.specimenRecord sp  where sl.specimenRecord.caseRecord.id=?  order by sl.specimenRecord.specimenId", [caseid])
           
        return [slidePrepInstance: slidePrepInstance,slidesList:slidesList]
    }

    
    
    @Transactional
    def save(SlidePrep slidePrepInstance) {
        if (slidePrepInstance == null) {
            notFound()
            return
        }
       
        if(params.caseRecord.id){
          
            slidePrepInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
                
        }
        
        def slideList=[]
        params.each{key,value->
                        
            if(key.startsWith('sl_') && value=='on'){
                def sid= key.substring(3)
                slideList.add(SlideRecord.findById(sid))
            }
            
        }
        
        
        
         def existingListSl =slidePrepInstance.slideList
        def removeListSl=[]
        existingListSl.each(){
            if(!slideList?.contains(it)){
                removeListSl.add(it)
            }
        }
        
        def addListSl=[]
        slideList.each(){
            if(!existingListSl?.contains(it)){
                addListSl.add(it)
            }
        }
        
        removeListSl.each(){
            slidePrepInstance.removeFromSlideList(it)
        }
        
        addListSl.each(){
            slidePrepInstance.addToSlideList(it)
        }
        if (slidePrepInstance.hasErrors()) {
         
            render(view: "create", model: [slidePrepInstance: slidePrepInstance])
        }

        //slidePrepInstance.save flush:true
        boolean successSaved = false
        try
        {
            successSaved = slidePrepInstance.save(flush: true)
        }catch(java.sql.BatchUpdateException se)
        {
            slidePrepInstance.errors.rejectValue("version",  "Another user has updated this form while you were editing")
            render(view: "edit", model: [slidePrepInstance: slidePrepInstance])
            return
        }
        
       
        request.withFormat {
            
            if(successSaved) {
               
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'slidePrep.label', default: 'Slide Prep Form for '), slidePrepInstance.caseRecord.caseId])
                    //redirect slidePrepInstance
                    redirect(action: "editWithValidation", id: slidePrepInstance.id)
                }
            '*' { respond slidePrepInstance, [status: CREATED] }
                
            }
            else {
              
                render(view: "create", model: [slidePrepInstance: slidePrepInstance])
            }
            
        }
    }
   
        
    
    
    def edit(SlidePrep slidePrepInstance) {
        // respond slidePrepInstance
        
        if(!slidePrepInstance) {
            flash.message = "slidePrepInstance not found"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(slidePrepInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            slidePrepInstance.submittedBy=null
            slidePrepInstance.dateSubmitted=null
            
            validateFields(slidePrepInstance)
            def canSubmit = !slidePrepInstance.errors.hasErrors()
            slidePrepInstance.clearErrors()
            
            def slidesList= SlideRecord.executeQuery("select sl from SlideRecord sl inner join sl.specimenRecord sp  where sl.specimenRecord.caseRecord.id=?  order by sl.specimenRecord.specimenId", [slidePrepInstance.caseRecord.id])
            
                       
            return [slidePrepInstance: slidePrepInstance, canSubmit: canSubmit,slidesList:slidesList]
        }
    }  
    
    
    def editWithValidation = {
        def slidePrepInstance = SlidePrep.get(params.id)
        if(!slidePrepInstance) {
           
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'slidePrep.label', default: 'Slide Prep Form for '), slidePrepInstance.caseRecord.caseId])
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(slidePrepInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            if (slidePrepInstance.submittedBy != null) {
                slidePrepInstance.submittedBy=null
                slidePrepInstance.dateSubmitted=null
            }            
            validateFields(slidePrepInstance)
            
            def slidesList= SlideRecord.executeQuery("select sl from SlideRecord sl inner join sl.specimenRecord sp  where sl.specimenRecord.caseRecord.id=?  order by sl.specimenRecord.specimenId", [slidePrepInstance.caseRecord.id])
            
            
            render(view: "edit", model: [slidePrepInstance: slidePrepInstance, canSubmit: !slidePrepInstance.errors.hasErrors(),slidesList:slidesList])
        }
    }

    @Transactional
    def update(SlidePrep slidePrepInstance) {
      
        if (slidePrepInstance == null) {
            notFound()
            return
        }
        
        
        slidePrepInstance.properties = params
        
        if (slidePrepInstance.hasErrors()) {
            respond slidePrepInstance.errors, view:'edit'
            return
        }
        
        
        def slideList=[]
        params.each{key,value->
                        
            if(key.startsWith('sl_') && value=='on'){
                def sid= key.substring(3)
                slideList.add(SlideRecord.findById(sid))
            }
            
        }
        
        
        
         def existingListSl =slidePrepInstance.slideList
        def removeListSl=[]
        existingListSl.each(){
            if(!slideList?.contains(it)){
                removeListSl.add(it)
            }
        }
        
        def addListSl=[]
        slideList.each(){
            if(!existingListSl?.contains(it)){
                addListSl.add(it)
            }
        }
        
        removeListSl.each(){
            slidePrepInstance.removeFromSlideList(it)
        }
        
        addListSl.each(){
            slidePrepInstance.addToSlideList(it)
        }

        boolean successSaved = false
        try
        {
            successSaved = slidePrepInstance.save(flush: true)
        }catch(java.sql.BatchUpdateException se)
        {
            slidePrepInstance.errors.rejectValue("version", null, "Another user has updated this form while you were editing")
            render(view: "edit", model: [slidePrepInstance: slidePrepInstance])
            return
        }
        
        request.withFormat {
            if(!slidePrepInstance.hasErrors() && successSaved) {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'slidePrep.label', default: 'Slide Prep Form for '), slidePrepInstance.caseRecord.caseId])
                    //redirect slidePrepInstance
                    redirect(action: "editWithValidation", id: slidePrepInstance.id)
                }            
            }
            else {
                render(view: "edit", model: [slidePrepInstance: slidePrepInstance])
            }
        }
    }
    
    
    
    
    @Transactional
    def submit(SlidePrep slidePrepInstance) {
        if (slidePrepInstance == null) {
            notFound()
            return
        }
        
    
        if(params.version) {
            def version = params.version.toLong()
            if(slidePrepInstance.version > version) {
                    
                slidePrepInstance.errors.rejectValue("version",  null, "Another user has updated this SlidePrep while you were editing")
                //render(view: "edit", model: [slidePrepInstance: slidePrepInstance])
                respond slidePrepInstance.errors, view:'edit'
                return
            }
        }

        if (slidePrepInstance.hasErrors()) {
            respond slidePrepInstance.errors, view:'edit'
            return
        }
        slidePrepInstance.dateSubmitted = new Date()
        slidePrepInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        slidePrepInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.submitted.message', args: [message(code: 'SlidePrep.label', default: 'Slide Prep Form for '), slidePrepInstance.caseRecord.caseId])
                redirect slidePrepInstance
            }
            '*'{ respond slidePrepInstance, [status: OK] }
        }
    }
    
    
    def resumeEditing = {
        def slidePrepInstance = SlidePrep.get(params.id)
        slidePrepInstance.dateSubmitted = null
        slidePrepInstance.submittedBy = null

        if(slidePrepInstance.save(flush: true)) {
            redirect(action: "edit", id: slidePrepInstance.id)
        } else {
            render(view: "show", model: [slidePrepInstance: slidePrepInstance])
        }
    }
    


    @Transactional
    def delete(SlidePrep slidePrepInstance) {

        if (slidePrepInstance == null) {
            notFound()
            return
        }

        slidePrepInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SlidePrep.label', default: 'SlidePrep'), slidePrepInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'slidePrep.label', default: 'SlidePrep'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def validateFields(slidePrepInstance) {
        
        
        if(!slidePrepInstance.slideList) {
            slidePrepInstance.errors.rejectValue('slideList', null, "Please select slides that are applicable")
        } 
        
        if(!slidePrepInstance.heTimeInOven) {
            slidePrepInstance.errors.rejectValue('heTimeInOven', null, "H&E Time In Oven is a required field.")
        } else if(slidePrepInstance.heTimeInOven.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heTimeInOvenOs) {
            slidePrepInstance.errors.rejectValue('heTimeInOvenOs', null, "Other H&E Time In Oven (specify) is a required field.")
        }

        if(!slidePrepInstance.heOvenTemp) {
            slidePrepInstance.errors.rejectValue('heOvenTemp', null, "H&E Oven Temp is a required field.")
        } else if(slidePrepInstance.heOvenTemp.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heOvenTempOs) {
            slidePrepInstance.errors.rejectValue('heOvenTempOs', null, "Other H&E Oven Temp (specify) is a required field.")
        }

        if(!slidePrepInstance.heDeParrafinMethod) {
            slidePrepInstance.errors.rejectValue('heDeParrafinMethod',null, "H&E De-paraffin Method is a required field.")
        } else if(slidePrepInstance.heDeParrafinMethod.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heDeParrafinMethodOs) {
            slidePrepInstance.errors.rejectValue('heDeParrafinMethodOs', null, "Other H&E De-paraffin Method (specify) is a required field.")
        }

        if(!slidePrepInstance.heStainMethod) {
            slidePrepInstance.errors.rejectValue('heStainMethod', null, "H&E Stain Method is a required field.")
        } else if(slidePrepInstance.heStainMethod.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heStainMethodOs) {
            slidePrepInstance.errors.rejectValue('heStainMethodOs', null, "Other H&E Stain Method (specify) is a required field.")
        }

        if(!slidePrepInstance.heClearingMethod) {
            slidePrepInstance.errors.rejectValue('heClearingMethod',null,  "H&E Clearing Method is a required field.")
        } else if(slidePrepInstance.heClearingMethod.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heClearingMethodOs) {
            slidePrepInstance.errors.rejectValue('heClearingMethodOs', null, "Other H&E Clearing Method (specify) is a required field.")
        }

        if(!slidePrepInstance.heCoverSlipping) {
            slidePrepInstance.errors.rejectValue('heCoverSlipping', null, "H&E Cover Slipping is a required field.")
        } else if(slidePrepInstance.heCoverSlipping.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heCoverSlippingOs) {
            slidePrepInstance.errors.rejectValue('heCoverSlippingOs', null, "Other H&E Cover Slipping (specify) is a required field.")
        }

        if(!slidePrepInstance.heEquipMaint) {
            slidePrepInstance.errors.rejectValue('heEquipMaint', null, "H&E equipment maintenance is a required field.")
        } else if(slidePrepInstance.heEquipMaint.equalsIgnoreCase('Other (specify)') && !slidePrepInstance.heEquipMaintOs) {
            slidePrepInstance.errors.rejectValue('heEquipMaintOs', null, "Please record any deviations from the H&E Equipment Maintenance SOP.")
        }
        
    }
   
    
    
    
}
