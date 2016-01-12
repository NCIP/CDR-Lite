package nci.bbrb.cdr.datarecords

import nci.bbrb.cdr.datarecords.SpecimenRecord

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SlideRecordController {
def accessPrivilegeService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SlideRecord.list(params), model:[slideRecordInstanceCount: SlideRecord.count()]
    }

    def show(SlideRecord slideRecordInstance) {
        def caseRecord=slideRecordInstance?.specimenRecord?.caseRecord
        if(!caseRecord){
             redirect(controller: "login", action: "denied")
            return
        }
                 
    if(!accessPrivilegeService.hasPrivilege(caseRecord, session, 'view')){
            redirect(controller: "login", action: "denied")
            return
    }
        respond slideRecordInstance
    }

    def create(SpecimenRecord specimenRecord) {
//        println "params: " + params
//        println "specimenRecord: " + specimenRecord
//        println "specimenRecord.getClass(): " + specimenRecord.getClass()
        def slideRecordInstance = new SlideRecord()
        if (specimenRecord) {
            slideRecordInstance.specimenRecord = specimenRecord
        } else {
            notFound()
            return
        }
        respond slideRecordInstance
    }

    @Transactional
    def save(SlideRecord slideRecordInstance) {
        if (slideRecordInstance == null) {
            notFound()
            return
        }

        if (slideRecordInstance.hasErrors()) {
            respond slideRecordInstance.errors, view:'create'
            return
        }

        slideRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'slideRecord.label', default: 'SlideRecord'), slideRecordInstance.id])
                redirect slideRecordInstance
            }
            '*' { respond slideRecordInstance, [status: CREATED] }
        }
    }

    def edit(SlideRecord slideRecordInstance) {
        def caseRecord=slideRecordInstance?.specimenRecord?.caseRecord
        if(!caseRecord){
             redirect(controller: "login", action: "denied")
            return
        }
               
        
        
    if(!accessPrivilegeService.hasPrivilege(caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
    }
        respond slideRecordInstance
    }

    @Transactional
    def update(SlideRecord slideRecordInstance) {
        if (slideRecordInstance == null) {
            notFound()
            return
        }

        if (slideRecordInstance.hasErrors()) {
            respond slideRecordInstance.errors, view:'edit'
            return
        }

        slideRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SlideRecord.label', default: 'SlideRecord'), slideRecordInstance.id])
                redirect slideRecordInstance
            }
            '*'{ respond slideRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SlideRecord slideRecordInstance) {

        if (slideRecordInstance == null) {
            notFound()
            return
        }

        slideRecordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SlideRecord.label', default: 'SlideRecord'), slideRecordInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'slideRecord.label', default: 'SlideRecord'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
