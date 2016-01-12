package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BloodDrawTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=BloodDrawType
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BloodDrawType.list(params), model:[bloodDrawTypeInstanceCount: BloodDrawType.count()]
    }

    def show(BloodDrawType bloodDrawTypeInstance) {
        respond bloodDrawTypeInstance
    }

    def create() {
        respond new BloodDrawType(params)
    }

    @Transactional
    def save(BloodDrawType bloodDrawTypeInstance) {
        if (bloodDrawTypeInstance == null) {
            notFound()
            return
        }

        if (bloodDrawTypeInstance.hasErrors()) {
            respond bloodDrawTypeInstance.errors, view:'create'
            return
        }

        bloodDrawTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bloodDrawType.label', default: 'BloodDrawType'), bloodDrawTypeInstance.id])
                redirect bloodDrawTypeInstance
            }
            '*' { respond bloodDrawTypeInstance, [status: CREATED] }
        }
    }

    def edit(BloodDrawType bloodDrawTypeInstance) {
        respond bloodDrawTypeInstance
    }

    @Transactional
    def update(BloodDrawType bloodDrawTypeInstance) {
        if (bloodDrawTypeInstance == null) {
            notFound()
            return
        }

        if (bloodDrawTypeInstance.hasErrors()) {
            respond bloodDrawTypeInstance.errors, view:'edit'
            return
        }

        bloodDrawTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BloodDrawType.label', default: 'BloodDrawType'), bloodDrawTypeInstance.id])
                redirect bloodDrawTypeInstance
            }
            '*'{ respond bloodDrawTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BloodDrawType bloodDrawTypeInstance) {

        if (bloodDrawTypeInstance == null) {
            notFound()
            return
        }

        bloodDrawTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BloodDrawType.label', default: 'BloodDrawType'), bloodDrawTypeInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bloodDrawType.label', default: 'BloodDrawType'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
