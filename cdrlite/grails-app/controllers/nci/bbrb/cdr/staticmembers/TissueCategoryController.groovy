package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TissueCategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=TissueCategory
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueCategory.list(params), model:[tissueCategoryInstanceCount: TissueCategory.count()]
    }

    def show(TissueCategory tissueCategoryInstance) {
        respond tissueCategoryInstance
    }

    def create() {
        respond new TissueCategory(params)
    }

    @Transactional
    def save(TissueCategory tissueCategoryInstance) {
        if (tissueCategoryInstance == null) {
            notFound()
            return
        }

        if (tissueCategoryInstance.hasErrors()) {
            respond tissueCategoryInstance.errors, view:'create'
            return
        }

        tissueCategoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueCategory.label', default: 'TissueCategory'), tissueCategoryInstance.id])
                redirect tissueCategoryInstance
            }
            '*' { respond tissueCategoryInstance, [status: CREATED] }
        }
    }

    def edit(TissueCategory tissueCategoryInstance) {
        respond tissueCategoryInstance
    }

    @Transactional
    def update(TissueCategory tissueCategoryInstance) {
        if (tissueCategoryInstance == null) {
            notFound()
            return
        }

        if (tissueCategoryInstance.hasErrors()) {
            respond tissueCategoryInstance.errors, view:'edit'
            return
        }

        tissueCategoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TissueCategory.label', default: 'TissueCategory'), tissueCategoryInstance.id])
                redirect tissueCategoryInstance
            }
            '*'{ respond tissueCategoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TissueCategory tissueCategoryInstance) {

        if (tissueCategoryInstance == null) {
            notFound()
            return
        }

        tissueCategoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueCategory.label', default: 'TissueCategory'), tissueCategoryInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueCategory.label', default: 'TissueCategory'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
