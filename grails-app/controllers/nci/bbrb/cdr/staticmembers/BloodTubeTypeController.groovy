package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BloodTubeTypeController {
def scaffold=BloodTubeType
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BloodTubeType.list(params), model:[bloodTubeTypeInstanceCount: BloodTubeType.count()]
    }

    def show(BloodTubeType bloodTubeTypeInstance) {
        respond bloodTubeTypeInstance
    }

    def create() {
        respond new BloodTubeType(params)
    }

    @Transactional
    def save(BloodTubeType bloodTubeTypeInstance) {
        if (bloodTubeTypeInstance == null) {
            notFound()
            return
        }

        if (bloodTubeTypeInstance.hasErrors()) {
            respond bloodTubeTypeInstance.errors, view:'create'
            return
        }

        bloodTubeTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bloodTubeType.label', default: 'BloodTubeType'), bloodTubeTypeInstance.id])
                redirect bloodTubeTypeInstance
            }
            '*' { respond bloodTubeTypeInstance, [status: CREATED] }
        }
    }

    def edit(BloodTubeType bloodTubeTypeInstance) {
        respond bloodTubeTypeInstance
    }

    @Transactional
    def update(BloodTubeType bloodTubeTypeInstance) {
        if (bloodTubeTypeInstance == null) {
            notFound()
            return
        }

        if (bloodTubeTypeInstance.hasErrors()) {
            respond bloodTubeTypeInstance.errors, view:'edit'
            return
        }

        bloodTubeTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BloodTubeType.label', default: 'BloodTubeType'), bloodTubeTypeInstance.id])
                redirect bloodTubeTypeInstance
            }
            '*'{ respond bloodTubeTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BloodTubeType bloodTubeTypeInstance) {

        if (bloodTubeTypeInstance == null) {
            notFound()
            return
        }

        bloodTubeTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BloodTubeType.label', default: 'BloodTubeType'), bloodTubeTypeInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bloodTubeType.label', default: 'BloodTubeType'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
