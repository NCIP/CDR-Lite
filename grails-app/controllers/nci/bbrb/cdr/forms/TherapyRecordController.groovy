package nci.bbrb.cdr.forms



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TherapyRecordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TherapyRecord.list(params), model:[therapyRecordInstanceCount: TherapyRecord.count()]
    }

    def show(TherapyRecord therapyRecordInstance) {
        respond therapyRecordInstance
    }

    def create() {
        respond new TherapyRecord(params)
    }

    @Transactional
    def save(TherapyRecord therapyRecordInstance) {
        if (therapyRecordInstance == null) {
            notFound()
            return
        }

        if (therapyRecordInstance.hasErrors()) {
            respond therapyRecordInstance.errors, view:'create'
            return
        }

        therapyRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'therapyRecord.label', default: 'TherapyRecord'), therapyRecordInstance.id])
                redirect therapyRecordInstance
            }
            '*' { respond therapyRecordInstance, [status: CREATED] }
        }
    }

    def edit(TherapyRecord therapyRecordInstance) {
        respond therapyRecordInstance
    }

    @Transactional
    def update(TherapyRecord therapyRecordInstance) {
        if (therapyRecordInstance == null) {
            notFound()
            return
        }

        if (therapyRecordInstance.hasErrors()) {
            respond therapyRecordInstance.errors, view:'edit'
            return
        }

        therapyRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TherapyRecord.label', default: 'TherapyRecord'), therapyRecordInstance.id])
                redirect therapyRecordInstance
            }
            '*'{ respond therapyRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TherapyRecord therapyRecordInstance) {

        if (therapyRecordInstance == null) {
            notFound()
            return
        }

        therapyRecordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TherapyRecord.label', default: 'TherapyRecord'), therapyRecordInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'therapyRecord.label', default: 'TherapyRecord'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
