package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CandidateRecord


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SocialHistoryController {
    def accessPrivilegeService
    // static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SocialHistory.list(params), model:[socialHistoryInstanceCount: SocialHistory.count()]
    }

    def show(SocialHistory socialHistoryInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(socialHistoryInstance?.candidateRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        respond socialHistoryInstance
    }

    def create() {
        respond new SocialHistory(params)
    }
    
    
   
    @Transactional
    def save(SocialHistory socialHistoryInstance) {
        if (socialHistoryInstance == null) {
            notFound()
            return
        }
        
        if(params.candidateRecord.id){
            socialHistoryInstance.candidateRecord=CandidateRecord.get(params.candidateRecord.id)
                
        }

        if (socialHistoryInstance.hasErrors()) {
            render(view: "create", model: [socialHistoryInstance: socialHistoryInstance])
        }

        //socialHistoryInstance.save flush:true
        boolean successSaved = false
        try
        {
            successSaved = socialHistoryInstance.save(flush: true)
        }catch(java.sql.BatchUpdateException se)
        {
            socialHistoryInstance.errors.rejectValue("version",  "Another user has updated this form while you were editing")
            render(view: "edit", model: [socialHistoryInstance: socialHistoryInstance])
            return
        }
        
       
        request.withFormat {
            if(successSaved) {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'socialHistory.label', default: 'SocialHistory'), socialHistoryInstance.id])
                    //redirect socialHistoryInstance
                    redirect(action: "editWithValidation", id: socialHistoryInstance.id)
                }
            '*' { respond socialHistoryInstance, [status: CREATED] }
                
            }
            else {
                render(view: "create", model: [socialHistoryInstance: socialHistoryInstance])
            }
            
        }
    }


    def edit(SocialHistory socialHistoryInstance) {
        respond socialHistoryInstance
        
        if(!socialHistoryInstance) {
            flash.message = "socialHistoryInstance not found"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilegeCandi(socialHistoryInstance?.candidateRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            socialHistoryInstance.submittedBy=null
            socialHistoryInstance.dateSubmitted=null
            
            def errorMap = checkError(socialHistoryInstance)
            errorMap.each() {key, value ->
                socialHistoryInstance.errors.rejectValue(key, value)
            }
            def canSubmit=true
            if (errorMap.size() > 0) {
                canSubmit=false
            }
            socialHistoryInstance.clearErrors()
            return [socialHistoryInstance: socialHistoryInstance, canSubmit: canSubmit]
        }
    }
    
   
    
    def editWithValidation = {
        def socialHistoryInstance = SocialHistory.get(params.id)
        if(!socialHistoryInstance) {
            flash.message = "socialHistoryInstance not found"
            redirect(action: "list")
        } else {
            
            def errorMap = checkError(socialHistoryInstance)
            errorMap.each() {key, value ->
                socialHistoryInstance.errors.rejectValue(key, value)
            }
            def canSubmit=true
            if (errorMap.size() > 0) {
                canSubmit=false
                //println errorMap.size()
            }
            render(view: "edit", model: [socialHistoryInstance: socialHistoryInstance, canSubmit: canSubmit])
        }
    }

    @Transactional
    def update(SocialHistory socialHistoryInstance) {
      
        if (socialHistoryInstance == null) {
            notFound()
            return
        }
        
        // params.each{k,v->
        //   println k+"-> "+v
          
        //  }
        
        socialHistoryInstance.properties = params
        socialHistoryInstance.secHandSmHist2=params.secHandSmHist2
        socialHistoryInstance.secHandSmHist3=params.secHandSmHist3

        if (socialHistoryInstance.hasErrors()) {
            respond socialHistoryInstance.errors, view:'edit'
            return
        }
        socialHistoryInstance.lastUpdated = new Date()
        socialHistoryInstance.dateSubmitted = null
        socialHistoryInstance.submittedBy = null
        boolean successSaved = false
        try
        {
            successSaved = socialHistoryInstance.save(flush: true)
        }catch(java.sql.BatchUpdateException se)
        {
            socialHistoryInstance.errors.rejectValue("version",  "Another user has updated this form while you were editing")
            render(view: "edit", model: [socialHistoryInstance: socialHistoryInstance])
            return
        }
        
        request.withFormat {
            if(!socialHistoryInstance.hasErrors() && successSaved) {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'socialHistory.label', default: 'SocialHistory'), socialHistoryInstance.id])
                    //redirect socialHistoryInstance
                    redirect(action: "editWithValidation", id: socialHistoryInstance.id)
                }            
            }
            else {
                render(view: "edit", model: [socialHistoryInstance: socialHistoryInstance])
            }
        }
    }
    
    @Transactional
    def submit(SocialHistory socialHistoryInstance) {
        if (socialHistoryInstance == null) {
            notFound()
            return
        }

        if (socialHistoryInstance.hasErrors()) {
            respond socialHistoryInstance.errors, view:'edit'
            return
        }
        socialHistoryInstance.dateSubmitted = new Date()
        socialHistoryInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        socialHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.submitted.message', args: [message(code: 'SocialHistory.label', default: 'SocialHistory for candidate'), socialHistoryInstance?.candidateRecord.id])
                //redirect socialHistoryInstance
                redirect(controller: "candidateRecord", action: "show", id: socialHistoryInstance.candidateRecord.id)
            }
            '*'{ respond socialHistoryInstance, [status: OK] }
        }
    }
      

    @Transactional
    def delete(SocialHistory socialHistoryInstance) {

        if (socialHistoryInstance == null) {
            notFound()
            return
        }
        def candId=socialHistoryInstance?.candidateRecord.id
        def candidateRecordInstance=CandidateRecord.get(candId)
        candidateRecordInstance.socialHistory=null
        candidateRecordInstance.save flush:true
        //println "delete"+socialHistoryInstance?.candidateRecord.id

        socialHistoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SocialHistory.label', default: 'SocialHistory'), socialHistoryInstance.id])
                //redirect action:"index"
                redirect(controller: 'candidateRecord', action: "show", params: [id:candId])
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialHistory.label', default: 'SocialHistory'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
        
    
    Map checkError(socialHistoryInstance) {
        def errorMap = [:]
              
        if (!socialHistoryInstance.alcoholConsum) {           
            errorMap.put('alcoholConsum', 'socialhistory.alcoholConsum.blank')
        }
        if (socialHistoryInstance.alcoholConsum && (socialHistoryInstance.alcoholConsum.contains('Lifelong non-drinker') || socialHistoryInstance.alcoholConsum.contains('Alcohol consumption history not available'))){
        }
        else{
            if (!socialHistoryInstance.numYrsAlcCon) {           
                errorMap.put('numYrsAlcCon', 'socialhistory.numYrsAlcCon.blank')
            }
        }
        
        if (!socialHistoryInstance.tobaccoSmHist) {           
            errorMap.put('tobaccoSmHist', 'socialhistory.tobaccoSmHist.blank')
        }
        
        if (socialHistoryInstance.tobaccoSmHist && (socialHistoryInstance.tobaccoSmHist.contains('Current smoker') || socialHistoryInstance.tobaccoSmHist.contains('Current reformed'))) {           
            
            if (!socialHistoryInstance.smokeAgeStart) {           
                errorMap.put('smokeAgeStart', 'socialhistory.smokeAgeStart.blank')
            } 
            if (!socialHistoryInstance.smokeYears) {           
                errorMap.put('smokeYears', 'socialhistory.smokeYears.blank')
            }
            if (!socialHistoryInstance.smokePackWeek) {           
                errorMap.put('smokePackWeek', 'socialhistory.smokePackWeek.blank')
            }
            if (!socialHistoryInstance.secHandSmHist1) {           
                errorMap.put('secHandSmHist1', 'socialhistory.secHandSmHist1.blank')
            }
        }
            
        if (socialHistoryInstance.secHandSmHist1== 'Yes' && (!socialHistoryInstance.secHandSmHist2 && !socialHistoryInstance.secHandSmHist3)) {           
            errorMap.put('secHandSmHist1', 'socialhistory.secHandSmHist1.blank')
        }
        
        return errorMap
    }
}

