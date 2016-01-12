package nci.bbrb.cdr.staticmembers


import nci.bbrb.cdr.datarecords.CandidateRecord
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrganizationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Organization.list(params), model:[organizationInstanceCount: Organization.count()]
    }

    def show(Organization organizationInstance) {
        respond organizationInstance
    }

    def create() {
        respond new Organization(params)
    }

    @Transactional
    def save(Organization organizationInstance) {
        if (organizationInstance == null) {
            notFound()
            return
        }

        if (organizationInstance.hasErrors()) {
            respond organizationInstance.errors, view:'create'
            return
        }

        organizationInstance.save flush:true
        if(organizationInstance.isBss){
            BSS bss = new BSS();
            bss.code =organizationInstance.code
            bss.name=organizationInstance.name
            bss.save (flush:true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'organization.label', default: 'Organization'), organizationInstance.id])
                redirect organizationInstance
            }
            '*' { respond organizationInstance, [status: CREATED] }
        }
    }

    def edit(Organization organizationInstance) {
        respond organizationInstance
    }

    @Transactional
    def update(Organization organizationInstance) {
        if (organizationInstance == null) {
            notFound()
            return
        }

        if (organizationInstance.hasErrors()) {
            respond organizationInstance.errors, view:'edit'
            return
        }

        def bss=BSS.findByCode(organizationInstance.code)
       
       if(bss && CandidateRecord.findAllByBss(bss, [max:1])){
           organizationInstance.isBss=true
       }
       
        organizationInstance.save flush:true
        
       
        
        if(organizationInstance.isBss && ! bss){
            BSS newbss = new BSS();
            newbss.code =organizationInstance.code
            newbss.name=organizationInstance.name
            newbss.save (flush:true)
        }else if(!organizationInstance.isBss && bss){
            bss.delete(failOnError:true, flush:true)
        }else{
            
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Organization.label', default: 'Organization'), organizationInstance.id])
                redirect organizationInstance
            }
            '*'{ respond organizationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Organization organizationInstance) {

        if (organizationInstance == null) {
            notFound()
            return
        }

        organizationInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Organization.label', default: 'Organization'), organizationInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'organization.label', default: 'Organization'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
