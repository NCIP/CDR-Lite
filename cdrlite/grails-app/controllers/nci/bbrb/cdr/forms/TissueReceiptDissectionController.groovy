package nci.bbrb.cdr.forms


import java.text.SimpleDateFormat
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Transactional(readOnly = true)
class TissueReceiptDissectionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", convertDate:"POST"]
    def accessPrivilegeService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueReceiptDissection.list(params), model:[tissueReceiptDissectionInstanceCount: TissueReceiptDissection.count()]
    }

    def show(TissueReceiptDissection tissueReceiptDissectionInstance) {
        if(!accessPrivilegeService.hasPrivilege(tissueReceiptDissectionInstance.caseRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        respond tissueReceiptDissectionInstance
    }

    def create() {
       
        def tissueReceiptDissection = new TissueReceiptDissection(params)
        respond tissueReceiptDissection
    }

    @Transactional
    def save(TissueReceiptDissection tissueReceiptDissectionInstance) {
        if (tissueReceiptDissectionInstance == null) {
            notFound()
            return
        }
        tissueReceiptDissectionInstance = convertDate(params)
        if(tissueReceiptDissectionInstance.save(flush:true))
        {
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueReceiptDissection.label', default: 'Tissue Receipt and Dissection form for Case'), tissueReceiptDissectionInstance.caseRecord.caseId])
                 redirect(action: "edit",   id: tissueReceiptDissectionInstance.id)
            }
            '*' { respond tissueReceiptDissectionInstance, [status: CREATED] }
        }
        } else
        {
            def warningMap = getWarningMap(tissueReceiptDissectionInstance)
            render(view: "create", model: [tissueReceiptDissectionInstance: tissueReceiptDissectionInstance])
        }
    }

    def edit(TissueReceiptDissection tissueReceiptDissectionInstance) {
        def canSubmit = 'No'
        if(!accessPrivilegeService.hasPrivilege(tissueReceiptDissectionInstance.caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        
        def errorMap= checkError(tissueReceiptDissectionInstance)
        errorMap.each() {key, value ->
            tissueReceiptDissectionInstance.errors.rejectValue(key, value)
        }
        if (errorMap.size() == 0) {
            canSubmit = 'Yes'
        }
        render(view: "edit", model: [tissueReceiptDissectionInstance: tissueReceiptDissectionInstance, canSubmit: canSubmit]) 
    }

    @Transactional
    def update(TissueReceiptDissection tissueReceiptDissectionInstance) {
        if (tissueReceiptDissectionInstance == null) {
            notFound()
            return
        }
        if(!accessPrivilegeService.hasPrivilege(tissueReceiptDissectionInstance.caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        
        if(params.version) {
            def version = params.version.toLong()
            if(tissueReceiptDissectionInstance.version > version) {
                tissueReceiptDissectionInstance.errors.rejectValue("version", null, "Another user has updated this Tissue Receipt and Dissection form while you were editing")
                render(view: "edit", model: [tissueReceiptDissectionInstance: tissueReceiptDissectionInstance])
                return
            }
        }
        
        tissueReceiptDissectionInstance = convertDate(params)
        if (tissueReceiptDissectionInstance.hasErrors()) {
            respond tissueReceiptDissectionInstance.errors, view:'edit'
            return
        }

        tissueReceiptDissectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TissueReceiptDissection.label',  default: 'Tissue Receipt and Dissection form for Case'), tissueReceiptDissectionInstance.caseRecord.caseId])
                redirect (action: 'edit', id:tissueReceiptDissectionInstance.id)
            }
            '*'{ respond tissueReceiptDissectionInstance, [status: OK] }
        }
    }

    def submit = {
        def tissueReceiptDissectionInstance = TissueReceiptDissection.get(params.id)
        if(!accessPrivilegeService.hasPrivilege(tissueReceiptDissectionInstance.caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        if(params.version) {
            def version = params.version.toLong()
            if(tissueReceiptDissectionInstance.version > version) {
                tissueReceiptDissectionInstance.errors.rejectValue("version", null, "Another user has updated this Tissue Receipt and Dissection form while you were editing")
                render(view: "edit", model: [tissueReceiptDissectionInstance: tissueReceiptDissectionInstance])
                return
            }
        }
        tissueReceiptDissectionInstance.dateSubmitted= new Date()
        tissueReceiptDissectionInstance.submittedBy=session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        def errorMap = checkError(tissueReceiptDissectionInstance)
        errorMap.each() {key, value ->
            tissueReceiptDissectionInstance.errors.rejectValue(key, value)
        }
        if (!tissueReceiptDissectionInstance.hasErrors() && tissueReceiptDissectionInstance.save(flush:true)) {
            flash.message = message(code: 'default.submitted.message', args: [message(code: 'Demographics.label',  default: 'Tissue Receipt and Dissection form for Case'), tissueReceiptDissectionInstance.caseRecord.caseId])
            render(view: "show", model: [tissueReceiptDissectionInstance: tissueReceiptDissectionInstance])
        }
        else {
            tissueReceiptDissectionInstance.discard()
            respond tissueReceiptDissectionInstance.errors, view:'edit'
            return
        }
    }
    
    def resumeEditing = {
        def tissueReceiptDissectionInstance = TissueReceiptDissection.get(params.id)
        tissueReceiptDissectionInstance.dateSubmitted = null
        tissueReceiptDissectionInstance.submittedBy = null
        if (tissueReceiptDissectionInstance.save(flush: true)) {
            redirect(action: "edit", id: tissueReceiptDissectionInstance.id)
        }
        else {
            render(view: "show", model: [tissueReceiptDissectionInstance: tissueReceiptDissectionInstance])
        }
    }
    
    Map getWarningMap(tissueReceiptDissectionInstance) {
        Map warningMap = [:]
        
        if ((tissueReceiptDissectionInstance.tumorSource)&&(!tissueReceiptDissectionInstance.tumorSource.trim().equals('')))
        {                                                                        
            if (!tissueReceiptDissectionInstance.tumorSource.equalsIgnoreCase(tissueReceiptDissectionInstance.caseRecord?.primaryTissueType?.toString()))
            {
                warningMap.put('tumorSource', '\'Source of tumor tissue\' is not the same as the Primary Organ - ' + tissueReceiptDissectionInstance.caseRecord?.primaryTissueType?.toString() + ".")
            }
        }
                
        return warningMap
    }
    
    def Map checkError(tissueReceiptDissectionInstance) {
        def result = [:]
         
        if(!tissueReceiptDissectionInstance.dateTimeTissueReceived) {
            result.put('dateTimeTissueReceived', 'tissueReceiptDissect.dateTimeReceived.blank')
        }

        if(!tissueReceiptDissectionInstance.tissueRecipient) {
            result.put('tissueRecipient','tissueReceiptDissect.tissueRecipient.blank')
        }

           
        if(!tissueReceiptDissectionInstance.parentTissueDissectedBy) {
            result.put('parentTissueDissectedBy','tissueReceiptDissect.dissectBy.blank')
        }

        if(!tissueReceiptDissectionInstance.parentTissueDissectBegan) {
            result.put('parentTissueDissectBegan','tissueReceiptDissect.dissectBegan.blank')
        }

        if(!tissueReceiptDissectionInstance.parentTissueDissectEnded) {
            result.put('parentTissueDissectEnded','tissueReceiptDissect.dissectEnded.blank')
        }

        if ((tissueReceiptDissectionInstance.parentTissueDissectBegan)&&(tissueReceiptDissectionInstance.parentTissueDissectEnded))
        {
            if (tissueReceiptDissectionInstance.parentTissueDissectBegan.compareTo(tissueReceiptDissectionInstance.parentTissueDissectEnded) > 0)
            {
                result.put('parentTissueDissectEnded','tissueReceiptDissect.DissectTime.error')
            }
        }
            
            
        if(!tissueReceiptDissectionInstance.grossAppearance) {
            result.put('grossAppearance','tissueReceiptDissect.grossAppearance.blank')
        } else if(tissueReceiptDissectionInstance.grossAppearance == 'Other-specify' && !tissueReceiptDissectionInstance.otherGrossAppearance) {
            result.put('grossAppearance','tissueReceiptDissect.otherGrossAppearance.blank')
        }

        if((!tissueReceiptDissectionInstance.tumorSource)||(tissueReceiptDissectionInstance.tumorSource.trim().equals(''))) {
            result.put('tumorSource','tissueReceiptDissect.tumorSource.blank')
        }

        if(!tissueReceiptDissectionInstance.collectionProcedure) {
            result.put('collectionProcedure','tissueReceiptDissect.collectionProcedure.blank')
        } else if(tissueReceiptDissectionInstance.collectionProcedure == 'Other-specify' && !tissueReceiptDissectionInstance.otherCollectionProcedure) {
            result.put('collectionProcedure','tissueReceiptDissect.otherCollectionProcedure.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativeType) {
            result.put('fixativeType','tissueReceiptDissect.fixativeType.blank')
        } else if(tissueReceiptDissectionInstance.fixativeType == 'Other-specify' && !tissueReceiptDissectionInstance.otherFixativeType) {
            result.put('fixativeType','tissueReceiptDissect.otherFixativeType.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativeFormula) {
            result.put('fixativeFormula','tissueReceiptDissect.fixativeFormula.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativePH) {
            result.put('fixativePH','tissueReceiptDissect.fixativePH.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativeManufacturer) {
            result.put('fixativeManufacturer','tissueReceiptDissect.fixativeManufacturer.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativeLotNum) {
            result.put('fixativeLotNum','tissueReceiptDissect.fixativeLotNum.blank')
        }

        if(!tissueReceiptDissectionInstance.dateFixativeLotNumExpired) {
            result.put('dateFixativeLotNumExpired','tissueReceiptDissect.dateFixativeLotNumExpired.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativeProductNum) {
            result.put('fixativeProductNum','tissueReceiptDissect.fixativeProductNum.blank')
        }

        if(!tissueReceiptDissectionInstance.fixativeProductType) {
            result.put('fixativeProductType','tissueReceiptDissect.fixativeProductType.blank')
        } else if(tissueReceiptDissectionInstance.fixativeProductType == 'Other-specify' && !tissueReceiptDissectionInstance.otherFixativeProductType) {
            result.put('fixativeProductType','tissueReceiptDissect.otherFixativeProductType.blank')
        }

        return result
           
        
    }
    
    @Transactional
    def delete(TissueReceiptDissection tissueReceiptDissectionInstance) {

        if (tissueReceiptDissectionInstance == null) {
            notFound()
            return
        }

        tissueReceiptDissectionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueReceiptDissection.label', default: 'TissueReceiptDissection'), tissueReceiptDissectionInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueReceiptDissection.label', default: 'TissueReceiptDissection'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def convertDate(params)
    {
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        def tissueReceiptDissectionInstance = TissueReceiptDissection.get(params.id)
        if(!tissueReceiptDissectionInstance)
        {
            tissueReceiptDissectionInstance = new TissueReceiptDissection(params)
            
        }
       
        def  dateTimeTissueReceived = params.dateTimeTissueReceived
        if(dateTimeTissueReceived && isDate(dateTimeTissueReceived)){
                
            tissueReceiptDissectionInstance.dateTimeTissueReceived=df.parse(dateTimeTissueReceived)
        }
        else{
           tissueReceiptDissectionInstance.dateTimeTissueReceived=null
        }
    
        def dateFixativeLotNumExpired=params.dateFixativeLotNumExpired
        if(dateFixativeLotNumExpired && isDate(dateFixativeLotNumExpired)){
            tissueReceiptDissectionInstance.dateFixativeLotNumExpired=df.parse(dateFixativeLotNumExpired)
        }
        else{
            tissueReceiptDissectionInstance.dateFixativeLotNumExpired=null
        }
       
        tissueReceiptDissectionInstance.save(failOnError:true)
        return tissueReceiptDissectionInstance
    }
    
    boolean isDate(dateStr){
        boolean result=false
        if(!dateStr)
        return false
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        df.setLenient(false);
        try{
        
            def date = df.parse(dateStr)
            result=true
        }catch (Exception e){
             
        }
         
        return result
        
        
    }
}
