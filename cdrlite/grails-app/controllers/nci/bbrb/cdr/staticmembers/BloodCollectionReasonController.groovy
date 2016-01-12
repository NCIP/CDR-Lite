package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BloodCollectionReasonController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=BloodCollectionReason
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BloodCollectionReason.list(params), model:[bloodCollectionReasonInstanceCount: BloodCollectionReason.count()]
    }

    def show(BloodCollectionReason bloodCollectionReasonInstance) {
        respond bloodCollectionReasonInstance
    }

    def create() {
        respond new BloodCollectionReason(params)
    }

    @Transactional
    def save(BloodCollectionReason bloodCollectionReasonInstance) {
        if (bloodCollectionReasonInstance == null) {
            notFound()
            return
        }

        if (bloodCollectionReasonInstance.hasErrors()) {
            respond bloodCollectionReasonInstance.errors, view:'create'
            return
        }

        bloodCollectionReasonInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bloodCollectionReason.label', default: 'BloodCollectionReason'), bloodCollectionReasonInstance.id])
                redirect bloodCollectionReasonInstance
            }
            '*' { respond bloodCollectionReasonInstance, [status: CREATED] }
        }
    }

    def edit(BloodCollectionReason bloodCollectionReasonInstance) {
        respond bloodCollectionReasonInstance
    }

    @Transactional
    def update(BloodCollectionReason bloodCollectionReasonInstance) {
        if (bloodCollectionReasonInstance == null) {
            notFound()
            return
        }

        if (bloodCollectionReasonInstance.hasErrors()) {
            respond bloodCollectionReasonInstance.errors, view:'edit'
            return
        }

        bloodCollectionReasonInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BloodCollectionReason.label', default: 'BloodCollectionReason'), bloodCollectionReasonInstance.id])
                redirect bloodCollectionReasonInstance
            }
            '*'{ respond bloodCollectionReasonInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BloodCollectionReason bloodCollectionReasonInstance) {

        if (bloodCollectionReasonInstance == null) {
            notFound()
            return
        }

        bloodCollectionReasonInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BloodCollectionReason.label', default: 'BloodCollectionReason'), bloodCollectionReasonInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bloodCollectionReason.label', default: 'BloodCollectionReason'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
