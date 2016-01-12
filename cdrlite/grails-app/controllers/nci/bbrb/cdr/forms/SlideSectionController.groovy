package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.SpecimenRecord
import nci.bbrb.cdr.datarecords.SlideRecord
import nci.bbrb.cdr.staticmembers.Organization

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SlideSectionController {
    def slideSectionService
    def accessPrivilegeService
    def scaffold = SlideSection

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SlideSection.list(params), model:[slideSectionInstanceCount: SlideSection.count()]
    }

//    def show(SlideSection slideSectionInstance) {
//        respond slideSectionInstance
//    }

    def show = {
//        println "show params: " + params
        
        def slideSectionInstance 
        if (params.slideSection?.id) {
            slideSectionInstance = SlideSection.get(params.slideSection.id)
        } else {
            if (params.id) {
                slideSectionInstance = SlideSection.get(params.id)
            }
        }
        if(!slideSectionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: ['Slide Section Form for Case', slideSectionInstance?.caseRecord?.caseId])}"
            redirect(controller: "home")
        } else {
//            int accessPrivilege = accessPrivilegeService.checkAccessPrivilege(slideSectionInstance.caseRecord, session, 'view')
//            if (accessPrivilege > 0) {
//                 redirect(controller: "login", action: ((accessPrivilege==1)?"denied":"sessionconflict"))
//                 return
//            }
//            if (!accessPrivilegeService.checkAccessPrivilege(slideSectionInstance.caseRecord, session, 'view')) {
//                redirect(controller: "login", action: "denied")
//                return
//            }
            
//            def canResume = (accessPrivilegeService.hasPrivilege(slideSectionInstance.caseRecord, session, 'edit') == 0)
            def canResume = accessPrivilegeService.hasPrivilege(slideSectionInstance.caseRecord, session, 'edit')
//            println "canResume: " + canResume
            [slideSectionInstance: slideSectionInstance, slides:SlideRecord.findAllByCaseId(slideSectionInstance?.caseRecord.id,[sort: "slideId"]), canResume: canResume]
        }
    }
    
    def create() {
//        println "create params: " + params
        def slideSectionInstance = new SlideSection()
        slideSectionInstance.properties = params

//        slideSectionInstance.formMetadata = FormMetadata.get(params.formMetadata.id)
        return [slideSectionInstance: slideSectionInstance, slides:SlideRecord.findAllByCaseId(params.caseRecord.id,[sort: "slideId"])]
        
    }

    @Transactional
    def save(SlideSection slideSectionInstance) {
//        println "save params: " + params
        if (slideSectionInstance == null) {
            notFound()
            return
        }

        checkSlideSectionError(slideSectionInstance)
        
        if (slideSectionInstance.hasErrors()) {
            respond slideSectionInstance.errors, view:'create'
            return
        }

        slideSectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'slideSection.label', default: 'SlideSection'), slideSectionInstance.id])
                redirect slideSectionInstance
            }
            '*' { respond slideSectionInstance, [status: CREATED] }
        }
    }

//    def edit(SlideSection slideSectionInstance) {
//        respond slideSectionInstance
//    }

    def edit = {
//        println "edit: params: "  + params
        def slideSectionInstance 
        if (params.slideSection?.id) {
            slideSectionInstance = SlideSection.get(params.slideSection.id)
        } else {
            if (params.id) {
                slideSectionInstance = SlideSection.get(params.id)
            }
        }
        if(!slideSectionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: ['Slide Section Form' + ' for Case', slideSectionInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        } else {
//            int accessPrivilege = accessPrivilegeService.checkAccessPrivilege(slideSectionInstance.caseRecord, session, 'edit')
//            if (accessPrivilege > 0) {
//                 redirect(controller: "login", action: ((accessPrivilege==1)?"denied":"sessionconflict"))
//                 return
//            }
            if (slideSectionInstance.dateSubmitted != null) {
                redirect(controller: "login", action: "denied")
                return
            }
            
            checkSlideSectionError(slideSectionInstance)
            def canSubmit = !slideSectionInstance.errors.hasErrors()
            slideSectionInstance.clearErrors()
            return [slideSectionInstance: slideSectionInstance, canSubmit:canSubmit, slides:SlideRecord.findAllByCaseId(slideSectionInstance?.caseRecord.id,[sort: "slideId"])]
        }
    }
    
    @Transactional
    def update(SlideSection slideSectionInstance) {
//         println "update: params: "  + params
        if (slideSectionInstance == null) {
            notFound()
            return
        }

        checkSlideSectionError(slideSectionInstance)
        def canSubmit = !slideSectionInstance.errors.hasErrors()
        if (slideSectionInstance.hasErrors()) {
            respond slideSectionInstance.errors, view:'edit'
            return
        }

        slideSectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SlideSection.label', default: 'SlideSection'), slideSectionInstance.id])
                redirect (action: 'edit', params: [id: slideSectionInstance.id])
//                return [action: edit, slideSectionInstance: slideSectionInstance, canSubmit:canSubmit, slides:SlideRecord.findAllByCaseId(slideSectionInstance?.caseRecord.id,[sort: "slideId"])]
            }
            '*'{ respond slideSectionInstance, [status: OK] }
        }
    }

    def submit = {
        def slideSectionInstance = SlideSection.get(params.id)
        if(slideSectionInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(slideSectionInstance.version > version) {
                    slideSectionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", "Another user has updated this Slide Sectioning Form while you were editing")
                    render(view: "edit", model: [slideSectionInstance: slideSectionInstance])
                    return
                }
            }

            slideSectionInstance.properties = params
            checkSlideSectionError(slideSectionInstance)

            if(!slideSectionInstance.hasErrors()) {
               // println("no errors")
                def username = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
                slideSectionService.submitForm(slideSectionInstance, username)

                flash.message = "${message(code: 'default.submitted.message', args: ['Slide Sectioning Form' + ' for Case', slideSectionInstance.caseRecord.caseId])}"
                redirect(controller: "caseRecord", action: "display", id: slideSectionInstance.caseRecord.id)
            } else {
                //println("has errors")
                redirect(action: "edit", id:slideSectionInstance.id)
            }
        } else {
            
            redirect(action: "list")
        }
    }

    def resumeEditing = {
        def slideSectionInstance = SlideSection.get(params.id)
        slideSectionInstance.dateSubmitted = null
        slideSectionInstance.submittedBy = null

        if(slideSectionInstance.save(flush: true)) {
            redirect(action: "edit", id: slideSectionInstance.id)
        } else {
            render(view: "show", model: [slideSectionInstance: slideSectionInstance, slides:SlideRecord.findAllByCaseId(slideSectionInstance?.caseRecord.id,[sort: "slideId"])])
        }
    }
    
    @Transactional
    def delete(SlideSection slideSectionInstance) {

        if (slideSectionInstance == null) {
            notFound()
            return
        }

        slideSectionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SlideSection.label', default: 'SlideSection'), slideSectionInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'slideSection.label', default: 'SlideSection'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def addSlide = {
//        println "add slide1: params: "  + params
//        println "slideId: " + slideId
        def caseId = params.caseId
        def slideRecord = new SlideRecord()
        def bssCode = CaseRecord.get(caseId).bss.code
        def specimen = SpecimenRecord.get(params.specimenRecord)

//        println "specimen: " + specimen
        def location = Organization.findByCode(bssCode)
        if(location) {
            slideRecord = new SlideRecord(
                specimenRecord: specimen,
                caseId: caseId,
                slideId: params.slideId,
                createdBy: bssCode,
            )

            if(slideRecord.validate()) {
                slideRecord.save(flush: true, failOnError: false)
            }
        } else {
            slideRecord.errors.rejectValue("slideId", "Slide BSS [${bssCode}] location not found.")
        }
        render(view: "slideTable", model: [slideRecord: slideRecord, slides:SlideRecord.findAllByCaseId(caseId,[sort: "slideId"])])
    }
    
    def addSlide2 = {
//        println("add slide2")
//        println "add slide2: params: "  + params
        def caseId = params.caseId
        def slideRecord = new SlideRecord()
        def bssCode = CaseRecord.get(caseId).bss.code
//        println "bssCode: " + bssCode
//        def location = Organization.findByCode(bssCode)
//        println "location: " + location
        def specimen = SpecimenRecord.get(params.specimenRecord)
        def userName = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
//        println "userName: " + userName

//        println "specimen: " + specimen
        
        if(userName) {
            slideRecord = new SlideRecord(
                specimenRecord: specimen,
                caseId: caseId,
                slideId: params.slideId,
                createdBy: userName,
            )

            if(slideRecord.validate()) {
                slideRecord.save(flush: true, failOnError: false)
            }
        } else {
            slideRecord.errors.rejectValue("slideId", "Unable to get the user name [${userName}] from the session: ${session.SPRING_SECURITY_CONTEXT}" )
        }
        def slides = SlideRecord.findAllByCaseId(caseId,[sort: "slideId"])
       // println("here/////")
        render(view: "slideTable2", model: [slideRecord: slideRecord, slides:slides, cid:caseId])
    }
    
    def deleteSlide = {
        def slideRecord = SlideRecord.get(params.id)
        try {
            slideRecord.delete(flush: true)
        } catch(org.hibernate.exception.ConstraintViolationException e) {
            e.printStackTrace
            slideRecord.errors.reject("slideId", "A foreign key constraint error occurred while deleting Slide ID [${slideRecord.slideId}].")
        }
        render(view: "slideTable", model: [slideRecord:slideRecord, slides:SlideRecord.findAllByCaseId(params.caseId,[sort: "slideId"])])
    }
       
    
    def deleteSlide2 = {
        def slideRecord = SlideRecord.get(params.id)
        try {
            slideRecord.delete(flush: true)
        } catch(org.hibernate.exception.ConstraintViolationException e) {
            e.printStackTrace
            slideRecord.errors.reject("slideId", "A foreign key constraint error occurred while deleting Slide ID [${slideRecord.slideId}].")
        }
        
        render(view: "slideTable2", model: [slideRecord:slideRecord, slides:SlideRecord.findAllByCaseId(params.caseId,[sort: "slideId"]), cid:params.caseId])
    }

    Map checkSlideSectionError(SlideSection slideSectionInstance) {
        
        def result = [:]
        
        if(!slideSectionInstance.slideSectionTech) {
            slideSectionInstance.errors.rejectValue('slideSectionTech', "Slide Section Technician Name is a required field.")
        }

        if(!slideSectionInstance.siteSOPSlideSection) {
            slideSectionInstance.errors.rejectValue('siteSOPSlideSection', "Slide Sectioning SOP is a required field.")
        }

        if(!slideSectionInstance.microtome) {
            slideSectionInstance.errors.rejectValue('microtome', "Microtome is a required field.")
        } else if(slideSectionInstance.microtome.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.microtomeOs) {
            slideSectionInstance.errors.rejectValue('microtomeOs', "Other Microtome (specify) is a required field.")
        }

        if(!slideSectionInstance.microtomeBladeType) {
            slideSectionInstance.errors.rejectValue('microtomeBladeType', "Microtome Blade Type is a required field.")
        } else if(slideSectionInstance.microtomeBladeType.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.microtomeBladeTypeOs) {
            slideSectionInstance.errors.rejectValue('microtomeBladeTypeOs', "Other Microtome Blade Type (specify) is a required field.")
        }

        if(!slideSectionInstance.microtomeBladeAge) {
            slideSectionInstance.errors.rejectValue('microtomeBladeAge', "Microtome Blade Age is a required field.")
        } else if(slideSectionInstance.microtomeBladeAge.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.microtomeBladeAgeOs) {
            slideSectionInstance.errors.rejectValue('microtomeBladeAgeOs', "Other Microtome Blade Age (specify) is a required field.")
        }

        if(!slideSectionInstance.facedBlockPrep) {
            slideSectionInstance.errors.rejectValue('facedBlockPrep', "Preparation of block face for sectioning is a required field.")
        } else if(slideSectionInstance.facedBlockPrep.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.facedBlockPrepOs) {
            slideSectionInstance.errors.rejectValue('facedBlockPrepOs', "Other Faced Block Prep (specify) is a required field.")
        }

        if(!slideSectionInstance.sectionThickness) {
            slideSectionInstance.errors.rejectValue('sectionThickness', "Section Thickness is a required field.")
        } else if(slideSectionInstance.sectionThickness.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.sectionThicknessOs) {
            slideSectionInstance.errors.rejectValue('sectionThicknessOs', "Other Section Thickness (specify) is a required field.")
        }

        if(!slideSectionInstance.slideCharge) {
            slideSectionInstance.errors.rejectValue('slideCharge', "Slide Charge is a required field.")
        } else if(slideSectionInstance.slideCharge.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.slideChargeOs) {
            slideSectionInstance.errors.rejectValue('slideChargeOs', "Other Slide Charge (specify) is a required field.")
        }

        if(!slideSectionInstance.waterBathTemp) {
            slideSectionInstance.errors.rejectValue('waterBathTemp', "Water Bath Temp is a required field.")
        } else if(slideSectionInstance.waterBathTemp.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.waterBathTempOs) {
            slideSectionInstance.errors.rejectValue('waterBathTempOs', "Other Water Bath Temp (specify) is a required field.")
        }

        if(!slideSectionInstance.microtomeDailyMaint) {
            slideSectionInstance.errors.rejectValue('microtomeDailyMaint', "Microtome Maintenance is a required field.")
        } else if(slideSectionInstance.microtomeDailyMaint.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.microtomeDailyMaintOs) {
            slideSectionInstance.errors.rejectValue('microtomeDailyMaintOs', "Please record any deviations from Microtome Daily Maintenance SOP.")
        }

        if(!slideSectionInstance.waterbathMaint) {
            slideSectionInstance.errors.rejectValue('waterbathMaint', "Waterbath Maintenance is a required field.")
        } else if(slideSectionInstance.waterbathMaint.equalsIgnoreCase('Other (specify)') && !slideSectionInstance.waterbathMaintOs) {
            slideSectionInstance.errors.rejectValue('waterbathMaintOs', "Please record any deviations from the Water Bath Daily Maintenance SOP.")
        }
    }
}
