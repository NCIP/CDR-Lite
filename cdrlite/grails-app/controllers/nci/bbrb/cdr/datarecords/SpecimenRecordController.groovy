package nci.bbrb.cdr.datarecords

import nci.bbrb.cdr.staticmembers.StorageTemp

import java.text.SimpleDateFormat
import grails.transaction.Transactional
import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class SpecimenRecordController {
    def accessPrivilegeService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)
        //respond SpecimenRecord.list(params), model:[specimenRecordInstanceCount: SpecimenRecord.count()]
        redirect (action: 'list')
    }
    
    def list(SpecimenRecord specimenRecordInstance) {
        params.max = Math.min(params.max ? Integer.parseInt(params.max): 10, 100)
        params.offset = (params.offset ? Integer.parseInt(params.offset): 0)
                
        def instanceList = []
        int count
        if ((session.authorities.size() == 1)&&(session.authorities.contains('ROLE_BSS')))
        {
            def instanceList2 = SpecimenRecord.findAll()
            def instanceList3 = []
            instanceList2.each() {
                if (it.caseRecord?.bss?.code.equals(session.org?.code)) instanceList3.add(it)
            }
            count = instanceList3.size()
            
            int n = 0
            instanceList3.each() {
                if ((n >= params.offset)&&(instanceList.size() < params.max)) instanceList.add(it)
                n++
            }
        }
        else
        {
            instanceList = SpecimenRecord.list(params)
            count = SpecimenRecord.count()
        }
        respond instanceList, model:[specimenRecordInstanceCount: count]
    }

    def show(SpecimenRecord specimenRecordInstance) {
//        println "show: params: " + params
        def canResume
        if(!accessPrivilegeService.hasPrivilege(specimenRecordInstance?.caseRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        canResume=true
        [specimenRecordInstance: specimenRecordInstance, canResume: canResume]
    }

    def create() {
//        println "create: params: " + params
        def specimenRecordInstance = new SpecimenRecord()
        def caseRecord = CaseRecord.get(params.caseRecord.id)
        if (caseRecord) {
            specimenRecordInstance.caseRecord = caseRecord
        } else {
            notFound()
            return
        }
        respond specimenRecordInstance
    }

    @Transactional
    def save(SpecimenRecord specimenRecordInstance) {
//        println "save: params: " + params
//        println "save: params.action: " + params.action
        if (specimenRecordInstance == null) {
            notFound()
            return
        }

        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        if(params.preservationTime){
            specimenRecordInstance.preservationTime=df.parse(params.preservationTime)
        }
        if(params.preservationTime){
            specimenRecordInstance.storageTime=df.parse(params.storageTime)
        }
        def canSubmit = !specimenRecordInstance.errors.hasErrors()
        if (!duplicateID(specimenRecordInstance)) {
            specimenRecordInstance.save(flush:true,failOnError: true)
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'Specimen Record Saved', args: [message(code: 'specimenRecord.label', default: 'Specimen Record'), specimenRecordInstance.specimenId])
                    redirect(action: "editWithValidation", id: specimenRecordInstance.id)
    //                redirect specimenRecordInstance
                }
            
            }
        } else {
            specimenRecordInstance.errors.rejectValue('specimenId', 'Specimen ID must be unique.')
            render(view: "edit", model: [specimenRecordInstance: specimenRecordInstance, canSubmit: !specimenRecordInstance.errors.hasErrors()])
        }
    }

    def edit(SpecimenRecord specimenRecordInstance) {
//        println "edit: params: " + params
        if(!specimenRecordInstance) {
            flash.message = "Specimen Record not found"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(specimenRecordInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            def caseRecord
            if (params.caseRecord?.id) {
                
                caseRecord = CaseRecord.get(params.caseRecord.id)
            } else {
                if (params.id) {
                    def caseId
                    caseId = SpecimenRecord.get(params.id).caseRecord.id
                    
                    caseRecord = CaseRecord.get(caseId)
                }
            }
            
            if (caseRecord) {
                specimenRecordInstance.caseRecord = caseRecord
            } else {
                notFound()
                return
            }
            specimenRecordInstance.submittedBy=null
            specimenRecordInstance.dateSubmitted=null
            
            def canSubmit = !specimenRecordInstance.errors.hasErrors()
            specimenRecordInstance.clearErrors()
           
            return [specimenRecordInstance: specimenRecordInstance, canSubmit: canSubmit]
        }
    }

    def editWithValidation = {
//        println "editWithValidation: params: " + params
        def specimenRecordInstance = SpecimenRecord.get(params.id)
        
        if(!specimenRecordInstance) {
            flash.message = "Specimen Record Instance not found"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(specimenRecordInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }

            specimenRecordInstance.submittedBy = null
            specimenRecordInstance.dateSubmitted = null
            
            def errorMap = checkError(specimenRecordInstance, params.action)
            errorMap.each() {key, value ->
                specimenRecordInstance.errors.rejectValue(key, value)
            }

            if (errorMap.size() > 0) {
                respond specimenRecordInstance.errors, view:'edit'
                return
            }
            render(view: "edit", model: [specimenRecordInstance: specimenRecordInstance, canSubmit: !specimenRecordInstance.errors.hasErrors()])
        }
    }

    @Transactional
    def update(SpecimenRecord specimenRecordInstance) {
//        println "update: params: " + params
        if (specimenRecordInstance == null) {
            notFound()
            return
        }

        def errorMap = checkError(specimenRecordInstance, params.action)
        if (errorMap.size() > 0) {
            errorMap.each() {key, value ->
                specimenRecordInstance.errors.rejectValue(key, value)
            }
        }
        if (specimenRecordInstance.hasErrors()) {
            respond specimenRecordInstance.errors, view:'edit'
            return
        }

        specimenRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SpecimenRecord.label', default: 'Specimen Record'), specimenRecordInstance.specimenId])
                redirect specimenRecordInstance
            }
            '*'{ respond specimenRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def submit(SpecimenRecord specimenRecordInstance) {
        if (specimenRecordInstance == null) {
            notFound()
            return
        }

        if(params.version) {
            def version = params.version.toLong()
            if(specimenRecordInstance.version > version) {
                    
                specimenRecordInstance.errors.rejectValue("version", null, "Another user has updated this Specimen Record while you were editing")
                //render(view: "edit", model: [specimenRecordInstance: specimenRecordInstance])
                respond specimenRecordInstance.errors, view:'edit'
                return
            }
        }

        if (specimenRecordInstance.hasErrors()) {
            respond specimenRecordInstance.errors, view:'edit'
            return
        }
        specimenRecordInstance.dateSubmitted = new Date()
        specimenRecordInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        specimenRecordInstance.save(flush:true,failOnError:true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.submitted.message', args: [message(code: 'SpecimenRecord.label', default: 'Specimen Record '), specimenRecordInstance.specimenId])
                redirect specimenRecordInstance.caseRecord
            }
            '*'{ respond specimenRecordInstance.caseRecord, [status: OK] }
        }
    }
    
    @Transactional
    def delete(SpecimenRecord specimenRecordInstance) {

        if (specimenRecordInstance == null) {
            notFound()
            return
        }

        if (specimenRecordInstance.slides.size() > 0) {
            specimenRecordInstance.errors.rejectValue('slides', 'Cannot delete! Slides for this specimen exist.')
            flash.message = message(code: 'Error! Cannot delete this specimen! Slides Exist.', args: [message(code: 'SpecimenRecord.label', default: 'Specimen Record'), specimenRecordInstance.specimenId])
            redirect(controller: "CaseRecord", action: "show", params: [caseRecordInstance: specimenRecordInstance.caseRecord] )
        } else {
            specimenRecordInstance.delete flush:true
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'SpecimenRecord.label', default: 'Specimen Record'), specimenRecordInstance.specimenId])
                    redirect(controller: "CaseRecord", action: "show", params: [caseRecordInstance: specimenRecordInstance.caseRecord] )

                }
                '*'{ render status: NO_CONTENT }
            }
        }
        
        
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'specimenRecord.label', default: 'SpecimenRecord'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    boolean duplicateID(specimenRecordInstance) {
        /* hard to avoid a double-negative here.  duplicateID returns true in the failure case and false in the success (non duplicate ID) case - Tabor */
        def thisID = specimenRecordInstance.id
        def sp = SpecimenRecord.findBySpecimenId(specimenRecordInstance.specimenId)
        if (sp) {
            if (thisID.equals(sp.id)) {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    Map checkError(specimenRecordInstance, action) {
//        println "specimenRecordInstance: " + specimenRecordInstance
//        println "action:                 " + action
        def errorMap = [:]
        if (specimenRecordInstance.preservationTime > new Date()) {
            errorMap.put('preservationTime', 'Preservation time cannot be in the future.')
        }
        if (specimenRecordInstance.storageTime > new Date()) {
            errorMap.put('storageTime', 'Storage time cannot be in the future.')
        }
        if (specimenRecordInstance.preservationTime > specimenRecordInstance.storageTime) {
            errorMap.put('preservationTime', 'Preservation time must be before storage time.')
        }
        
//        if (!specimenRecordInstance.source) {           
//            errorMap.put('source', 'healthhistory.source.blank')
//        }
        return errorMap
    }
}
