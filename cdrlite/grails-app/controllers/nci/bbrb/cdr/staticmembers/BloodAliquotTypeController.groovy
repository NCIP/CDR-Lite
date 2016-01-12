package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BloodAliquotTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold = BloodAliquotType
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BloodAliquotType.list(params), model:[bloodAliquotTypeInstanceCount: BloodAliquotType.count()]
    }

    def show(BloodAliquotType bloodAliquotTypeInstance) {
        respond bloodAliquotTypeInstance
    }

    def create() {
        respond new BloodAliquotType(params)
    }

    @Transactional
    def save(BloodAliquotType bloodAliquotTypeInstance) {
        if (bloodAliquotTypeInstance == null) {
            notFound()
            return
        }

        if (bloodAliquotTypeInstance.hasErrors()) {
            respond bloodAliquotTypeInstance.errors, view:'create'
            return
        }

        bloodAliquotTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bloodAliquotType.label', default: 'BloodAliquotType'), bloodAliquotTypeInstance.id])
                redirect bloodAliquotTypeInstance
            }
            '*' { respond bloodAliquotTypeInstance, [status: CREATED] }
        }
    }

    def edit(BloodAliquotType bloodAliquotTypeInstance) {
        respond bloodAliquotTypeInstance
    }

    @Transactional
    def update(BloodAliquotType bloodAliquotTypeInstance) {
        if (bloodAliquotTypeInstance == null) {
            notFound()
            return
        }

        if (bloodAliquotTypeInstance.hasErrors()) {
            respond bloodAliquotTypeInstance.errors, view:'edit'
            return
        }

        bloodAliquotTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BloodAliquotType.label', default: 'BloodAliquotType'), bloodAliquotTypeInstance.id])
                redirect bloodAliquotTypeInstance
            }
            '*'{ respond bloodAliquotTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BloodAliquotType bloodAliquotTypeInstance) {

        if (bloodAliquotTypeInstance == null) {
            notFound()
            return
        }

        bloodAliquotTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BloodAliquotType.label', default: 'BloodAliquotType'), bloodAliquotTypeInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bloodAliquotType.label', default: 'BloodAliquotType'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
