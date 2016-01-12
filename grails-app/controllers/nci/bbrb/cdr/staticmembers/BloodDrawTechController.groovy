package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BloodDrawTechController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=BloodDrawTech
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BloodDrawTech.list(params), model:[bloodDrawTechInstanceCount: BloodDrawTech.count()]
    }

    def show(BloodDrawTech bloodDrawTechInstance) {
        respond bloodDrawTechInstance
    }

    def create() {
        respond new BloodDrawTech(params)
    }

    @Transactional
    def save(BloodDrawTech bloodDrawTechInstance) {
        if (bloodDrawTechInstance == null) {
            notFound()
            return
        }

        if (bloodDrawTechInstance.hasErrors()) {
            respond bloodDrawTechInstance.errors, view:'create'
            return
        }

        bloodDrawTechInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bloodDrawTech.label', default: 'BloodDrawTech'), bloodDrawTechInstance.id])
                redirect bloodDrawTechInstance
            }
            '*' { respond bloodDrawTechInstance, [status: CREATED] }
        }
    }

    def edit(BloodDrawTech bloodDrawTechInstance) {
        respond bloodDrawTechInstance
    }

    @Transactional
    def update(BloodDrawTech bloodDrawTechInstance) {
        if (bloodDrawTechInstance == null) {
            notFound()
            return
        }

        if (bloodDrawTechInstance.hasErrors()) {
            respond bloodDrawTechInstance.errors, view:'edit'
            return
        }

        bloodDrawTechInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BloodDrawTech.label', default: 'BloodDrawTech'), bloodDrawTechInstance.id])
                redirect bloodDrawTechInstance
            }
            '*'{ respond bloodDrawTechInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BloodDrawTech bloodDrawTechInstance) {

        if (bloodDrawTechInstance == null) {
            notFound()
            return
        }

        bloodDrawTechInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BloodDrawTech.label', default: 'BloodDrawTech'), bloodDrawTechInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bloodDrawTech.label', default: 'BloodDrawTech'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
