package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TissueLocationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueLocation.list(params), model:[tissueLocationInstanceCount: TissueLocation.count()]
    }

    def show(TissueLocation tissueLocationInstance) {
        respond tissueLocationInstance
    }

    def create() {
        respond new TissueLocation(params)
    }

    @Transactional
    def save(TissueLocation tissueLocationInstance) {
        if (tissueLocationInstance == null) {
            notFound()
            return
        }

        if (tissueLocationInstance.hasErrors()) {
            respond tissueLocationInstance.errors, view:'create'
            return
        }

        tissueLocationInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueLocation.label', default: 'TissueLocation'), tissueLocationInstance.id])
                redirect tissueLocationInstance
            }
            '*' { respond tissueLocationInstance, [status: CREATED] }
        }
    }

    def edit(TissueLocation tissueLocationInstance) {
        respond tissueLocationInstance
    }

    @Transactional
    def update(TissueLocation tissueLocationInstance) {
        if (tissueLocationInstance == null) {
            notFound()
            return
        }

        if (tissueLocationInstance.hasErrors()) {
            respond tissueLocationInstance.errors, view:'edit'
            return
        }

        tissueLocationInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TissueLocation.label', default: 'TissueLocation'), tissueLocationInstance.id])
                redirect tissueLocationInstance
            }
            '*'{ respond tissueLocationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TissueLocation tissueLocationInstance) {

        if (tissueLocationInstance == null) {
            notFound()
            return
        }

        tissueLocationInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueLocation.label', default: 'TissueLocation'), tissueLocationInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueLocation.label', default: 'TissueLocation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
