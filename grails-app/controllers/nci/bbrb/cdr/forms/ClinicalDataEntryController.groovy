package nci.bbrb.cdr.forms



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import nci.bbrb.cdr.forms.TherapyRecord
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.util.AppSetting

@Transactional
class ClinicalDataEntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", savePrevCancerDiag: "POST"]
    def accessPrivilegeService
    def recipient
    def subject
    def emailBody
    def queryService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ClinicalDataEntry.list(params), model:[clinicalDataEntryInstanceCount: ClinicalDataEntry.count()]
    }

    def show(ClinicalDataEntry clinicalDataEntryInstance) {
        if(!accessPrivilegeService.hasPrivilege(clinicalDataEntryInstance.caseRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }

        respond clinicalDataEntryInstance
    }

    def create() {
        def clinicalDataEntry = new ClinicalDataEntry(params)
        respond clinicalDataEntry
    }

    @Transactional
    def save(ClinicalDataEntry clinicalDataEntryInstance) {
        if(params.caseRecord.id){
           clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
        }
        
        if (clinicalDataEntryInstance.hasErrors()) {
            respond clinicalDataEntryInstance.errors, view:'create'
            return
        }
        
        if(clinicalDataEntryInstance.save(flush:true))
        {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '),  clinicalDataEntryInstance.caseRecord.caseId])
                redirect(action: "editWithValidation",   id: clinicalDataEntryInstance.id)
            }
            '*' { respond clinicalDataEntryInstance, [status: CREATED] }
        }
        } else
        {
              render(view: "create", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        }
        
    }

    def edit= {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        def canSubmit = 'No'
        if(!accessPrivilegeService.hasPrivilege(clinicalDataEntryInstance.caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
       
        render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance, canSubmit: canSubmit]) 
        
    }
    
    def editWithValidation= {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        def canSubmit = 'No'
        if(!accessPrivilegeService.hasPrivilege(clinicalDataEntryInstance.caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        
        def errorMap= validateFields(clinicalDataEntryInstance)
        errorMap.each() {key, value ->
            
            clinicalDataEntryInstance.errors.rejectValue(key, value)
        }
        if (errorMap.size() == 0) {
            canSubmit = 'Yes'
        }
        render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance, canSubmit: canSubmit]) 
        
    }

    def savePrevCancerDiag = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            clinicalDataEntryInstance.save(flush:true, validate:false)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
        clinicalDataEntryInstance.properties = params
        TherapyRecord therapyRecord = new TherapyRecord()
        therapyRecord.typeOfTherapy = "prevcancer"
        therapyRecord.descTherapy = params.prevCancerDiagDesc
        if(params.prevCancerDiagDt)
        {
            if (params.prevCancerDiagDt!="Select Date" && params.prevCancerDiagDt!="" ) {
                if ((new Date(params.prevCancerDiagDt)) > new Date()) {
                    redirect(action: "edit", id: clinicalDataEntryInstance.id)
                    flash.message = "Previous malignancy diagnosis date cannot be in the future"
                    return
                } else {
                    therapyRecord.therapyDate = new Date(params.prevCancerDiagDt)
                }

            } else {
                params.prevCancerDiagDt=""
            }
        }
        if (params.prevCancerDiagEst!='') {
            therapyRecord.howLongAgo = Double.parseDouble(params.prevCancerDiagEst)   
        }
        therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
        therapyRecord.save(flush:true)
        clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
        if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush:true)) {
            redirect(action: "edit", id: clinicalDataEntryInstance.id)
        } else {
            render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        }
   }
    
    def saveChemo = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            
            //def caseRecord = clinicalDataEntryInstance.caseRecord
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            
            clinicalDataEntryInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
        
   
        if(clinicalDataEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(clinicalDataEntryInstance.version > version) {
                    
                    clinicalDataEntryInstance.errors.rejectValue("version",null, "Another user has updated this Clinical Data Entry form while you were editing")
                    render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                    return
                }
            }
            
            clinicalDataEntryInstance.properties = params
            TherapyRecord therapyRecord = new TherapyRecord()
            therapyRecord.typeOfTherapy = "chemo"
            therapyRecord.descTherapy = params.chemoTherb4SurgDesc
            if (params.chemoTherb4SurgDt!="Select Date" && params.chemoTherb4SurgDt!="" && (params.chemoTherb4SurgDt)) {
                if ((new Date(params.chemoTherb4SurgDt)) > new Date()) {
                    redirect(action: "edit", id: clinicalDataEntryInstance.id)
                    flash.message = "Chemotherapy date cannot be in the future"
                    return
                } else {
                    therapyRecord.therapyDate = new Date(params.chemoTherb4SurgDt)
                }
            } else {
                params.chemoTherb4SurgDt=""
            }
            if (params.chemoTherb4SurgEst!='') {
                therapyRecord.howLongAgo = Double.parseDouble(params.chemoTherb4SurgEst)  
            }
            therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
            therapyRecord.save(flush: true)
            clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
            
            if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush: true)) {
                redirect(action: "edit", id: clinicalDataEntryInstance.id)
            } else {
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        }
    }    
    
    def saveIrradTher = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            
            //def caseRecord = clinicalDataEntryInstance.caseRecord
                    
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            clinicalDataEntryInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: 'Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
        
        if(clinicalDataEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(clinicalDataEntryInstance.version > version) {
                    
                    clinicalDataEntryInstance.errors.rejectValue("version", null, "Another user has updated this Clinical Data Entry form while you were editing")
                    render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                    return
                }
            }
            
            clinicalDataEntryInstance.properties = params
            TherapyRecord therapyRecord = new TherapyRecord()
            therapyRecord.typeOfTherapy = "radiation"
            therapyRecord.descTherapy = params.irradTherb4SurgDesc
            if(params.irradTherb4SurgDt)
            {
                if (params.irradTherb4SurgDt!="Select Date"&&params.irradTherb4SurgDt!="" && (params.irradTherb4SurgDt)) {
                    if ((new Date(params.irradTherb4SurgDt)) > new Date()) {
                        redirect(action: "edit", id: clinicalDataEntryInstance.id)
                        flash.message = "Radiation therapy date cannot be in the future"
                        return
                    } else {                
                        therapyRecord.therapyDate = new Date(params.irradTherb4SurgDt)
                }
                } else {
                    params.irradTherb4SurgDt=""                
                }
            }
            if (params.irradTherb4SurgEst!='') {
            therapyRecord.howLongAgo = Double.parseDouble(params.irradTherb4SurgEst)
            }
            therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
            therapyRecord.save(flush: true)
            clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
            
            if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush: true)) {
                redirect(action: "edit", id: clinicalDataEntryInstance.id)
            } else {
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        }
    }    
    

    def saveImmunoTher = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            
            //def caseRecord = clinicalDataEntryInstance.caseRecord
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            clinicalDataEntryInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
        
        if(clinicalDataEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(clinicalDataEntryInstance.version > version) {
                    
                    clinicalDataEntryInstance.errors.rejectValue("version", null, "Another user has updated this Clinical Data Entry form while you were editing")
                    render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                    return
                }
            }
            
            clinicalDataEntryInstance.properties = params
            TherapyRecord therapyRecord = new TherapyRecord()
            therapyRecord.typeOfTherapy = "immuno"
            therapyRecord.descTherapy = params.immTherb4SurgDesc
            if(params.immTherb4SurgDt)
            {
                if (params.immTherb4SurgDt!="Select Date" && params.immTherb4SurgDt!="") {
                    if ((new Date(params.immTherb4SurgDt)) > new Date()) {
                        redirect(action: "edit", id: clinicalDataEntryInstance.id)
                        flash.message = "Immunotherapy date cannot be in the future"
                        return
                    } else {                
                        therapyRecord.therapyDate = new Date(params.immTherb4SurgDt)
                    }
                } else {
                    params.immTherb4SurgDt=""                
                }
            }
           
            if (params.immTherb4SurgEst!='') {
            therapyRecord.howLongAgo = Double.parseDouble(params.immTherb4SurgEst)
        }
            therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
            therapyRecord.save(flush: true)
            clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
            
            if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush: true)) {
                redirect(action: "edit", id: clinicalDataEntryInstance.id)
            } else {
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        }
    }        
    
    def saveHormonalTher = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            
            //def caseRecord = clinicalDataEntryInstance.caseRecord
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            clinicalDataEntryInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
        
        
        if(clinicalDataEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(clinicalDataEntryInstance.version > version) {
                    
                    clinicalDataEntryInstance.errors.rejectValue("version", null, "Another user has updated this Clinical Data Entry form while you were editing")
                    render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                    return
                }
            }
            
            clinicalDataEntryInstance.properties = params
            TherapyRecord therapyRecord = new TherapyRecord()
            therapyRecord.typeOfTherapy = "hormonal"
            therapyRecord.descTherapy = params.hormTherb4SurgDesc
            if(params.hormTherb4SurgDt)
            {
                if (params.hormTherb4SurgDt!="Select Date" && params.hormTherb4SurgDt!= "" ) {
                    if ((new Date(params.hormTherb4SurgDt)) > new Date()) {
                        redirect(action: "edit", id: clinicalDataEntryInstance.id)
                        flash.message = "Hormonal therapy date cannot be in the future"
                        return
                    } else {
                        therapyRecord.therapyDate = new Date(params.hormTherb4SurgDt)
                }
                } else {
                    params.hormTherb4SurgDt=""                
                }
            }
            if (params.hormTherb4SurgEst!='') {
            therapyRecord.howLongAgo = Double.parseDouble(params.hormTherb4SurgEst)
        }
            therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
            therapyRecord.save(flush: true)
            clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
            
            if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush: true)) {
                redirect(action: "edit", id: clinicalDataEntryInstance.id)
            } else {
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        }
    }        
    
def saveHormonalBC = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            
            //def caseRecord = clinicalDataEntryInstance.caseRecord
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            
            clinicalDataEntryInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
        
        if(clinicalDataEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(clinicalDataEntryInstance.version > version) {
                    
                    clinicalDataEntryInstance.errors.rejectValue("version", null, "Another user has updated this Clinical Data Entry form while you were editing")
                    render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                    return
                }
            }
            
            clinicalDataEntryInstance.properties = params
            TherapyRecord therapyRecord = new TherapyRecord()
            therapyRecord.typeOfTherapy = "HBC"
            if ((params.formHBCOtherSpecification == null)||(params.formHBCOtherSpecification == '')||(params.formHBCOtherSpecification == 'null')) therapyRecord.specOtherHBCForm = ""
            else therapyRecord.specOtherHBCForm = params.formHBCOtherSpecification
            therapyRecord.hbcForm = params.formHorBirthControl
            if (params.hormBCDur!='') {
                therapyRecord.durationMonths = Double.parseDouble(params.hormBCDur)
            }
            if (params.hormBCLast!='') {
                therapyRecord.noOfYearsStopped = Double.parseDouble(params.hormBCLast)
            }
            
            therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
            therapyRecord.save(flush: true)
            clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
            
            if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush: true)) {
                redirect(action: "edit", id: clinicalDataEntryInstance.id)
            } else {
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: 'Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        }
    }

    def saveHormonalRT = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (!clinicalDataEntryInstance) {
            clinicalDataEntryInstance = new ClinicalDataEntry(params)
            
            //def caseRecord = clinicalDataEntryInstance.caseRecord
            if(params.caseRecord.id){
                clinicalDataEntryInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            }
            
            clinicalDataEntryInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"            
        }
                
        if(clinicalDataEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(clinicalDataEntryInstance.version > version) {
                    
                    clinicalDataEntryInstance.errors.rejectValue("version",null, "Another user has updated this Clinical Data Entry form while you were editing")
                    render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                    return
                }
            }
            
            clinicalDataEntryInstance.properties = params
            TherapyRecord therapyRecord = new TherapyRecord()
            therapyRecord.typeOfTherapy = "HRT"
            
            if ((params.formHRTOtherSpecification == null)||(params.formHRTOtherSpecification == '')||(params.formHRTOtherSpecification == 'null')) therapyRecord.specOtherHRTForm = ""
            else therapyRecord.specOtherHRTForm = params.formHRTOtherSpecification
            therapyRecord.hrtForm = params.formHorReplaceTher
            therapyRecord.hrtType = params.typeHorReplaceTher
            if (params.hormRTDur!='') {
                therapyRecord.durationMonths = Double.parseDouble(params.hormRTDur)
            }
            if (params.hormRTLast!='') {
                therapyRecord.noOfYearsStopped = Double.parseDouble(params.hormRTLast)
            }
            
            therapyRecord.clinicalDataEntry = clinicalDataEntryInstance
            therapyRecord.save(flush: true)
            clinicalDataEntryInstance.addToTherapyRecords(therapyRecord)
            
            if(!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush: true)) {
                redirect(action: "edit", id: clinicalDataEntryInstance.id)
            } else {
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: ' Clinical Data Entry form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])}"
            redirect(action: "list")
        }
    }
    def  CheckBoxValues(params)
    {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        clinicalDataEntryInstance.bloodRelCancer1= params.bloodRelCancer1 ? params.bloodRelCancer1 : params._bloodRelCancer1
        clinicalDataEntryInstance.bloodRelCancer2= params.bloodRelCancer2 ? params.bloodRelCancer2 :  params._bloodRelCancer2
        clinicalDataEntryInstance.bloodRelCancer3= params.bloodRelCancer3 ? params.bloodRelCancer3 :  params._bloodRelCancer3
        clinicalDataEntryInstance.bloodRelCancer4= params.bloodRelCancer4 ? params.bloodRelCancer4 :  params._bloodRelCancer4
        clinicalDataEntryInstance.bloodRelCancer5= params.bloodRelCancer5 ? params.bloodRelCancer5 : params._bloodRelCancer5
        clinicalDataEntryInstance.bloodRelCancer6= params.bloodRelCancer6 ? params.bloodRelCancer6 : params._bloodRelCancer6
        clinicalDataEntryInstance.bloodRelCancer7= params.bloodRelCancer7 ? params.bloodRelCancer7 : params._bloodRelCancer7
        clinicalDataEntryInstance.bloodRelCancer8= params.bloodRelCancer8 ? params.bloodRelCancer8 : params._bloodRelCancer8
        clinicalDataEntryInstance.bloodRelCancer9= params.bloodRelCancer9 ? params.bloodRelCancer9 : params._bloodRelCancer9
        clinicalDataEntryInstance.bloodRelCancer10= params.bloodRelCancer10 ? params.bloodRelCancer10 : params._bloodRelCancer10
        clinicalDataEntryInstance.bloodRelCancer11= params.bloodRelCancer11 ? params.bloodRelCancer11 : params._bloodRelCancer11
        clinicalDataEntryInstance.bloodRelCancer12= params.bloodRelCancer12 ? params.bloodRelCancer12 : params._bloodRelCancer12
        clinicalDataEntryInstance.bloodRelCancer13= params.bloodRelCancer13 ? params.bloodRelCancer13 : params._bloodRelCancer13
        clinicalDataEntryInstance.bloodRelCancer14= params.bloodRelCancer14 ? params.bloodRelCancer14 : params._bloodRelCancer14

        
        return clinicalDataEntryInstance 
    }
    
    @Transactional
    def update(ClinicalDataEntry clinicalDataEntryInstance) {
        clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        if (clinicalDataEntryInstance == null) {
            notFound()
            return
        }
        if(params.version) {
            def version = params.version.toLong()
            if(clinicalDataEntryInstance.version > version) {
                clinicalDataEntryInstance.errors.rejectValue("version", null, "Another user has updated this Clinical Data Entry form while you were editing")
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                return
            }
        }
        clinicalDataEntryInstance = CheckBoxValues(params)
        clinicalDataEntryInstance= checkboxReset(clinicalDataEntryInstance)
        if (clinicalDataEntryInstance.hasErrors()) {
            respond clinicalDataEntryInstance.errors, view:'edit'
            return
        }

        clinicalDataEntryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ClinicalDataEntry.label', default: 'Clinical Data Entry Form for Case '), clinicalDataEntryInstance?.caseRecord?.caseId])
                redirect (action: 'editWithValidation', id:clinicalDataEntryInstance.id) 
            }
            '*'{ respond clinicalDataEntryInstance, [status: OK] }
        }
    }

     def submit = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
         if(params.version) {
            def version = params.version.toLong()
            if(clinicalDataEntryInstance.version > version) {
                clinicalDataEntryInstance.errors.rejectValue("version", null, "Another user has updated this Clinical Data Entry form while you were editing")
                render(view: "edit", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
                return
            }
        }
        clinicalDataEntryInstance.dateSubmitted= new Date()
        clinicalDataEntryInstance.submittedBy=session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        
        def errorMap = validateFields(clinicalDataEntryInstance)
        errorMap.each() {key, value ->
            clinicalDataEntryInstance.errors.rejectValue(key, value)
        }
        if (!clinicalDataEntryInstance.hasErrors() && clinicalDataEntryInstance.save(flush:true)) {
            flash.message = message(code: 'default.submitted.message', args: [message(code: 'ClinicalDataEntry.label',  default: 'Clinical Data entry form for Case'), clinicalDataEntryInstance.caseRecord.caseId])
            render(view: "show", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        }
        else {
            clinicalDataEntryInstance.discard()
            respond clinicalDataEntryInstance.errors, view:'edit'
            return
        }
    }
    
    def resumeEditing = {
        def clinicalDataEntryInstance = ClinicalDataEntry.get(params.id)
        clinicalDataEntryInstance.dateSubmitted = null
        clinicalDataEntryInstance.submittedBy = null
        if (clinicalDataEntryInstance.save(flush: true)) {
            redirect(action: "edit", id: clinicalDataEntryInstance.id)
        }
        else {
            render(view: "show", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        }
    }
    
    @Transactional
    def delete(ClinicalDataEntry clinicalDataEntryInstance) {

        if (clinicalDataEntryInstance == null) {
            notFound()
            return
        }

        clinicalDataEntryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ClinicalDataEntry.label', default: 'ClinicalDataEntry'), clinicalDataEntryInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }
def deleteTherapy = {
        def therapyRecordInstance = TherapyRecord.get(params.id)
        def clinicalDataEntryInstance = therapyRecordInstance.clinicalDataEntry
        if(!accessPrivilegeService.hasPrivilege(clinicalDataEntryInstance.caseRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        therapyRecordInstance.delete(flush: true)
        if (params.therType.equalsIgnoreCase("Irrad")) {
            render(view: "_IrradTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        } else if (params.therType.equalsIgnoreCase("Chemo")) {
            render(view: "_ChemoTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        } else if (params.therType.equalsIgnoreCase("Immuno")) {
            render(view: "_ImmunoTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        } else if (params.therType.equalsIgnoreCase("Hormonal")) {
            render(view: "_HormTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        } else if (params.therType.equalsIgnoreCase("PrevCancer")) {
            render(view: "_PrevCancerTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        } else if (params.therType.equalsIgnoreCase("HBC")) {
            render(view: "_HBCTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])
        } else if (params.therType.equalsIgnoreCase("HRT")) {
            render(view: "_HRTTabContent", model: [clinicalDataEntryInstance: clinicalDataEntryInstance])            
        } 
}
    
    
    
    def checkInfectiousDisease(clinicalDataEntryInstance) {
        def result
        def organization = Organization.findByCode(clinicalDataEntryInstance.caseRecord?.bss?.parentBss?.code)
        def caseRecord = clinicalDataEntryInstance.caseRecord
        def queryType = QueryType.findByCode("VERIFY")
        def description
        def dueDate = (new Date()).plus(10)
        
        if (clinicalDataEntryInstance.hepB == 'Yes') {
            result = Query.executeQuery("select q from Query q where q.caseRecord.id = ? and task = 'HEPB'", [clinicalDataEntryInstance.caseRecord?.id])
            if (result.size() == 0) {
                description = "Infectious disease Hepatitis B data was entered and submitted for Case " + clinicalDataEntryInstance.caseRecord?.caseId + ". Please re-visit the Clinical Data Entry Form and verify all data related to Infectious disease Hepatitis B."
                queryService.createInfectiousDiseaseEntry(organization, caseRecord, queryType, description, dueDate, "HEPB")
            }
        }
        
        if (clinicalDataEntryInstance.hepC == 'Yes') {
            result = Query.executeQuery("select q from Query q where q.caseRecord.id = ? and task = 'HEPC'", [clinicalDataEntryInstance.caseRecord?.id])
            if (result.size() == 0) {
                description = "Infectious disease Hepatitis C data was entered and submitted for Case " + clinicalDataEntryInstance.caseRecord?.caseId + ". Please re-visit the Clinical Data Entry Form and verify all data related to Infectious disease Hepatitis C."
                queryService.createInfectiousDiseaseEntry(organization, caseRecord, queryType, description, dueDate, "HEPC")
            }
        }
        
        if (clinicalDataEntryInstance.hiv == 'Yes') {
            result = Query.executeQuery("select q from Query q where q.caseRecord.id = ? and task = 'HIV'", [clinicalDataEntryInstance.caseRecord?.id])
            if (result.size() == 0) {
                description = "Infectious disease HIV data was entered and submitted for Case " + clinicalDataEntryInstance.caseRecord?.caseId + ". Please re-visit the Clinical Data Entry Form and verify all data related to Infectious disease HIV."
                queryService.createInfectiousDiseaseEntry(organization, caseRecord, queryType, description, dueDate, "HIV")
            }
        }
        
        if (clinicalDataEntryInstance.scrAssay == 'Yes') {
            result = Query.executeQuery("select q from Query q where q.caseRecord.id = ? and task = 'HIVASSAY'", [clinicalDataEntryInstance.caseRecord?.id])
            if (result.size() == 0) {
                description = "Infectious disease HIV assay data was entered and submitted for Case " + clinicalDataEntryInstance.caseRecord?.caseId + ". Please re-visit the Clinical Data Entry Form and verify all data related to Infectious disease HIV assay."
                queryService.createInfectiousDiseaseEntry(organization, caseRecord, queryType, description, dueDate, "HIVASSAY")
            }
        }
        
        if (clinicalDataEntryInstance.otherInfect != null && clinicalDataEntryInstance.otherInfect?.trim() != "") {
            result = Query.executeQuery("select q from Query q where q.caseRecord.id = ? and task = 'OTHERINFECT'", [clinicalDataEntryInstance.caseRecord?.id])
            if (result.size() == 0) {
                description = "Other infectious disease data was entered and submitted for Case " + clinicalDataEntryInstance.caseRecord?.caseId + ". Please re-visit the Clinical Data Entry Form and verify all data related to Other Infectious Disease."
                queryService.createInfectiousDiseaseEntry(organization, caseRecord, queryType, description, dueDate, "OTHERINFECT")
            }
        }
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'clinicalDataEntry.label', default: 'ClinicalDataEntry'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def Map validateFields(clinicalDataEntryInstance) {
        def result = [:]
        def recsToDelList = []
        def therapyRecordsSize = 0
        def therapyRecordsPrevCancer = "No"
        def therapyRecordsIrrad = "No"
        def therapyRecordsChemo = "No"
        def therapyRecordsImmuno = "No"
        def therapyRecordsHorm = "No"
        def therapyRecordsHBC = "No"
        def therapyRecordsHRT = "No"
        
        
        if ((clinicalDataEntryInstance.therapyRecords!=null) || (clinicalDataEntryInstance.therapyRecords.size() != 0)) {        
                clinicalDataEntryInstance.therapyRecords.each() {
                    if(it.typeOfTherapy == "prevcancer") {
                        therapyRecordsPrevCancer = "Yes"
                    }
                    if(it.typeOfTherapy == "radiation") {
                        therapyRecordsIrrad = "Yes"
                    }
                    if(it.typeOfTherapy == "chemo") {
                        therapyRecordsChemo = "Yes"
                    }
                    if(it.typeOfTherapy == "immuno") {
                        therapyRecordsImmuno = "Yes"
                    }
                    if(it.typeOfTherapy == "hormonal") {
                        therapyRecordsHorm = "Yes"
                    }
                    if(it.typeOfTherapy == "HBC") {
                        therapyRecordsHBC = "Yes"
                    }
                    if(it.typeOfTherapy == "HRT") {
                        therapyRecordsHRT = "Yes"
                    }            
                }
        }
        
           
        //if (clinicalDataEntryInstance.prevMalignancy != 'Yes' || clinicalDataEntryInstance.prevMalignancy != 'No' || clinicalDataEntryInstance.prevMalignancy != 'Unknown' ) {
        if (clinicalDataEntryInstance.prevMalignancy == null ) {
             result.put('prevMalignancy', 'clinicalEntry.prevMalignancy.blank')
        } else {        
            if (clinicalDataEntryInstance.prevMalignancy == 'Yes' && therapyRecordsPrevCancer.equals("No")) {
                result.put('prevMalignancy', 'clinicalEntry.prevMalignancy.blankData')
            }
                if ((clinicalDataEntryInstance.prevMalignancy == 'No' || clinicalDataEntryInstance.prevMalignancy == 'Unknown')  && therapyRecordsPrevCancer.equals("Yes")) {
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "prevcancer") {
                            recsToDelList.add(it.id)
                        }
                    }
                }
//            if (clinicalDataEntryInstance.prevMalignancy == 'Yes' && clinicalDataEntryInstance.prevCancerDiagDt == null && clinicalDataEntryInstance.prevCancerDiagEst == null ) {
//                clinicalDataEntryInstance.errors.rejectValue('prevCancerDiagDt', 'Please enter a date when cancer was diagnosed before or how long ago it was diagnosed')
//            }            
        }

        int n = 0
        boolean checkRel = false
        while(true)
        {
            n++
            def bloodRelCancer
            def relCancerType
            try
            {
                bloodRelCancer = clinicalDataEntryInstance."${'bloodRelCancer' + n}"
            }
            catch(Exception ee)
            {
                break
            }
            
            try
            {
                relCancerType = clinicalDataEntryInstance."${'relCancerType' + n}"
            }
            catch(Exception ee)
            {
                //relCancerType = 'X'
            }
            
            if ((bloodRelCancer != null)&&(!bloodRelCancer.trim().equals('')))
            {
                checkRel = true
               
                if (bloodRelCancer.toLowerCase().startsWith('other')) {}
                else if (bloodRelCancer.toLowerCase().startsWith('none')) {}
                else if ((relCancerType == null)||(relCancerType.trim().equals('')))
                {
                    result.put('relCancerType'+n, 'clinicalEntry.relCancerType.blank')
                }
            }
        }
        
        
        if ((!checkRel))
        {
            result.put('bloodRelCancer14', 'clinicalEntry.bloodRelCancer14.blank')
        }
        if (clinicalDataEntryInstance.bloodRelCancer13 != null &&clinicalDataEntryInstance.bloodRelCancer13 != '' ) { 
            if (clinicalDataEntryInstance.othBloodRelCancer == null) { 
                result.put('othBloodRelCancer', 'clinicalEntry.relativeType.blank')
            } else {
                if (clinicalDataEntryInstance.relCancerType13 == null) {
                  result.put('relCancerType13', 'clinicalEntry.relCancerType.blank')
                }
            }
        }       
        
        if (clinicalDataEntryInstance.isImmunoSupp == null){
            result.put('isImmunoSupp', 'clinicalEntry.immunoSupp.blankOption')
        } else {
            if (clinicalDataEntryInstance.isImmunoSupp == 'Yes' && clinicalDataEntryInstance.immunoSuppStatus1 == null && clinicalDataEntryInstance.immunoSuppStatus2 == null && clinicalDataEntryInstance.immunoSuppStatus3 == null && clinicalDataEntryInstance.immunoSuppStatus4 == null) {
                result.put('immunoSuppStatus1', 'clinicalEntry.immunoSupp.blankData')
            } else {
                if (clinicalDataEntryInstance.immunoSuppStatus4 != null && clinicalDataEntryInstance.otherImmunoSuppStatus == null) { 
                    result.put('otherImmunoSuppStatus', 'clinicalEntry.immunoSupp.blank')
                } 
            }
        }
        

        if (clinicalDataEntryInstance.irradTherb4Surg == null) {
            result.put('irradTherb4Surg', 'clinicalEntry.irradTherb4Surg.blank')
        } else {
            if (clinicalDataEntryInstance.irradTherb4Surg == 'Yes' && therapyRecordsIrrad.equals("No")) {
                result.blank('irradTherb4Surg', 'clinicalEntry.irradTherb4Surg.blankData')
            }
                if ((clinicalDataEntryInstance.irradTherb4Surg == 'No' || clinicalDataEntryInstance.irradTherb4Surg == 'Unknown')  && therapyRecordsIrrad.equals("Yes")) {
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "radiation") {
                            recsToDelList.add(it.id)
                        }
                    }
                }
            
            
//                if (clinicalDataEntryInstance.irradTherb4SurgDesc == null) { 
//                    clinicalDataEntryInstance.errors.rejectValue('irradTherb4SurgDesc', 'Description of Radiation therapy before surgery cannot be blank')
//                }
//                if (clinicalDataEntryInstance.irradTherb4SurgDt == null) { 
//                    clinicalDataEntryInstance.errors.rejectValue('irradTherb4SurgDt', 'Date when Radiation therapy before surgery was done cannot be blank')
//                }            
//            }
        }
        
        if (clinicalDataEntryInstance.chemoTherb4Surg == null) {
            result.put('chemoTherb4Surg', 'clinicalEntry.chemoTherb4Surg.blank')
        } else {        
            if (clinicalDataEntryInstance.chemoTherb4Surg == 'Yes' && therapyRecordsChemo.equals("No")) {
                result.put('chemoTherb4Surg', 'clinicalEntry.chemoTherb4Surg.blankData')
            }        
                if ((clinicalDataEntryInstance.chemoTherb4Surg == 'No' || clinicalDataEntryInstance.chemoTherb4Surg == 'Unknown')  && therapyRecordsChemo.equals("Yes")) {
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "chemo") {
                            recsToDelList.add(it.id)
                        }
                    }
                }            
//            if (clinicalDataEntryInstance.chemoTherb4Surg == 'Yes') { 
//                    if (clinicalDataEntryInstance.chemoTherb4SurgDesc == null) { 
//                        clinicalDataEntryInstance.errors.rejectValue('chemoTherb4SurgDesc', 'Description of Chemotherapy before surgery cannot be blank')
//                    }
//                    if (clinicalDataEntryInstance.chemoTherb4SurgDt == null) { 
//                        clinicalDataEntryInstance.errors.rejectValue('chemoTherb4SurgDt', 'Date when Chemotherapy before surgery was done cannot be blank')
//                    }            
//                }        
        }

        if (clinicalDataEntryInstance.immTherb4Surg == null) {
            result.put('immTherb4Surg', 'clinicalEntry.immTherb4Surg.blank')
        } else {        
            if (clinicalDataEntryInstance.immTherb4Surg == 'Yes' && therapyRecordsImmuno.equals("No")) {
                result.put('immTherb4Surg', 'clinicalEntry.immTherb4Surg.blankData')
            }    
            
                if ((clinicalDataEntryInstance.immTherb4Surg == 'No' || clinicalDataEntryInstance.immTherb4Surg == 'Unknown')  && therapyRecordsImmuno.equals("Yes")) {
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "immuno") {
                            recsToDelList.add(it.id)
                        }
                    }
                }            
//            if (clinicalDataEntryInstance.immTherb4Surg == 'Yes') { 
//                if (clinicalDataEntryInstance.immTherb4SurgDesc == null) { 
//                    clinicalDataEntryInstance.errors.rejectValue('immTherb4SurgDesc', 'Description of Immunotherapy before surgery cannot be blank')
//                }
//                if (clinicalDataEntryInstance.immTherb4SurgDt == null) { 
//                    clinicalDataEntryInstance.errors.rejectValue('immTherb4SurgDt', 'Date when Immunotherapy before surgery was done cannot be blank')
//                }            
//            }       
        }

        if (clinicalDataEntryInstance.hormTherb4Surg == null) {
            result.put('hormTherb4Surg', 'clinicalEntry.hormTherb4Surg.blank')
        } else {        
            if (clinicalDataEntryInstance.hormTherb4Surg == 'Yes' && therapyRecordsHorm.equals("No")) {
                result.put('hormTherb4Surg', 'clinicalEntry.hormTherb4Surg.blankData')
            }            
                if ((clinicalDataEntryInstance.hormTherb4Surg == 'No' || clinicalDataEntryInstance.hormTherb4Surg == 'Unknown')  && therapyRecordsHorm.equals("Yes")) {
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "hormonal") {
                            recsToDelList.add(it.id)
                        }
                    }
                }            
            
//            if (clinicalDataEntryInstance.hormTherb4Surg == 'Yes') { 
//                if (clinicalDataEntryInstance.hormTherb4SurgDesc == null) { 
//                    clinicalDataEntryInstance.errors.rejectValue('hormTherb4SurgDesc', 'Description of hormonal therapy before surgery cannot be blank')
//                }
//                if (clinicalDataEntryInstance.hormTherb4SurgDt == null) { 
//                    clinicalDataEntryInstance.errors.rejectValue('hormTherb4SurgDt', 'Date when hormonal therapy before surgery was done cannot be blank')
//                }            
//            }
        }        
           
        if (clinicalDataEntryInstance.hepB == null) {
            result.put('hepB', 'clinicalEntry.hepB.blank')
        }         
        
        if (clinicalDataEntryInstance.hepC == null) {
            result.put('hepC', 'clinicalEntry.hepC.blank')
        }         

        if (clinicalDataEntryInstance.hiv == null) {
            result.put('hiv', 'clinicalEntry.hiv.blank')
        }         

        if (clinicalDataEntryInstance.scrAssay == null) {
            result.put('scrAssay', 'clinicalEntry.scrAssay.blank')
        }                 
        if (clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()=='Ovary'||
            clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()=='Uterus' ) {
            
            if (clinicalDataEntryInstance.wasPregnant == null) {
                result.put('wasPregnant', 'clinicalEntry.wasPregnant.blank')
            } else {
                if (clinicalDataEntryInstance.wasPregnant == 'Yes') { 
                    if (clinicalDataEntryInstance.totPregnancies == null) { 
                        result.put('totPregnancies', 'clinicalEntry.totPregnancies.blank')
                    }
                    if (clinicalDataEntryInstance.totLiveBirths == null) { 
                        result.put('totLiveBirths', 'clinicalEntry.totLiveBirths.blank')
                    }            
                    if (clinicalDataEntryInstance.ageAt1stChild == null) { 
                        result.put('ageAt1stChild', 'clinicalEntry.ageAt1stChild.blank')
                    }            
                }
            }
            
            if (clinicalDataEntryInstance.gynSurg == null) {
                result.put('gynSurg', 'clinicalEntry.gynSurg.blank')
            }

            if (clinicalDataEntryInstance.hormBirthControl.equals(null)) {
                result.put('hormBirthControl', 'clinicalEntry.hormBirthControl.blank')
            } else {
                if ((clinicalDataEntryInstance.hormBirthControl == 'Current user' || clinicalDataEntryInstance.hormBirthControl == 'Former user') && therapyRecordsHBC.equals("No")) {
                    result.put('hormBirthControl', 'clinicalEntry.hormBirthControl.prevHistblank')
                }
                
                if ((clinicalDataEntryInstance.hormBirthControl == 'Never used' || clinicalDataEntryInstance.hormBirthControl == 'Unknown')  && therapyRecordsHBC.equals("Yes")) {
                    clinicalDataEntryInstance.othHorBC = ""
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "HBC") {
                            recsToDelList.add(it.id)
                        }
                    }
                }                
            }

            if (clinicalDataEntryInstance.usedHorReplaceTher.equals(null)) {
                result.put('usedHorReplaceTher', 'clinicalEntry.usedHorReplaceTher.blank')
            } else {
                if (clinicalDataEntryInstance.usedHorReplaceTher == 'Yes' && therapyRecordsHRT.equals("No")) {
                    result.put('usedHorReplaceTher', 'clinicalEntry.usedHorReplaceTher.prevHistory')
                }
                if ((clinicalDataEntryInstance.usedHorReplaceTher == 'No' || clinicalDataEntryInstance.usedHorReplaceTher == 'Unknown')  && therapyRecordsHRT.equals("Yes")) {
                    clinicalDataEntryInstance.othHorRT = ""
                   clinicalDataEntryInstance.therapyRecords.each() {
                        if(it.typeOfTherapy == "HRT") {
                            recsToDelList.add(it.id)
                        }
                    }
                }                
            }

            if (clinicalDataEntryInstance.menoStatus.equals(null)) {
                result.put('menoStatus', 'clinicalEntry.menoStatus.blank')
            }
            /*
            else
            {
               if (clinicalDataEntryInstance.gynSurg != null)
               {
                   boolean tag = false
                   while(true)
                   {
                       String gynSrg = clinicalDataEntryInstance.gynSurg
                       if (gynSrg.toLowerCase().indexOf('neither hysterectomy') < 0) break
                       if (gynSrg.toLowerCase().indexOf('nor oophorectomy') < 0) break
                       String menoSt = clinicalDataEntryInstance.menoStatus
                       if (menoSt.toLowerCase().indexOf('no prior hysterectomy') < 0) break
                       if (menoSt.toLowerCase().indexOf('prior bilateral oophorectomy') < 0) break
                       tag = true
                       break
                   }
                   if (tag)
                   {
                       clinicalDataEntryInstance.errors.rejectValue('menoStatus', 'This menopausal status value(#12) contradicts the questionair of gynecological surgeries(#9)')
                   }
               }
            }
            println 'CCCC gynSurg=' + clinicalDataEntryInstance.gynSurg + ', menoStatus=' + clinicalDataEntryInstance.menoStatus
            */
            
            if (clinicalDataEntryInstance.clinicalFIGOStg.equals(null)&&clinicalDataEntryInstance.clinicalTumStgGrp.equals(null)) {
                result.put('clinicalFIGOStg', 'clinicalEntry.clinicalFIGOTumStg.blank')
               // result.put('clinicalTumStgGrp', 'clinicalEntry.clinicalFIGOTumStg.blank')
            }        
            } else {
               // println(" type ="+ clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()+"  "+AppSetting.findByCode("TUMOR_STAGE_"+clinicalDataEntryInstance.caseRecord.primaryTissueType.toString().toUpperCase())?.bigValue)
            if(AppSetting.findByCode("TUMOR_STAGE_"+clinicalDataEntryInstance.caseRecord.primaryTissueType.toString().toUpperCase())?.bigValue)
            {
            if (clinicalDataEntryInstance.clinicalTumStgGrp.equals(null)) {
                result.put('clinicalTumStgGrp', 'clinicalEntry.clinicalTumStgGrp.blank')
            }   
            }
        }
        
          
        
        if (clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()=='Lung') {
            if (clinicalDataEntryInstance.isEnvCarc == null){
                result.put('isEnvCarc', 'clinicalEntry.isEnvCarc.blank')
            } else {
                if (clinicalDataEntryInstance.isEnvCarc == 'Yes' && clinicalDataEntryInstance.envCarc1 == null && clinicalDataEntryInstance.envCarc2 == null && clinicalDataEntryInstance.envCarc3 == null && clinicalDataEntryInstance.envCarc4 == null && clinicalDataEntryInstance.envCarc5 == null) {
                        result.put('envCarc1', 'clinicalEntry.isEnvCarc.blankData')
                    }
            }
        }
        
        if (clinicalDataEntryInstance.caseRecord.primaryTissueType.toString()=='Colon') {
            
            if (clinicalDataEntryInstance.isAddtlColoRisk == null) {
                result.put('isAddtlColoRisk', 'clinicalEntry.isAddtlColoRisk.blank')
            } else {
            if (clinicalDataEntryInstance.isAddtlColoRisk == 'Yes' && clinicalDataEntryInstance.addtlColoRisk1 == null && clinicalDataEntryInstance.addtlColoRisk2 == null && clinicalDataEntryInstance.addtlColoRisk3 == null && clinicalDataEntryInstance.addtlColoRisk4 == null && clinicalDataEntryInstance.addtlColoRisk5 == null && clinicalDataEntryInstance.addtlColoRisk6 == null) {
                    result.put('addtlColoRisk1', 'clinicalEntry.isAddtlColoRisk.blankData')
                } else if (clinicalDataEntryInstance.addtlColoRisk6 != null && clinicalDataEntryInstance.otherAddColRisk == null) {
                    result.put('otherAddColRisk', 'clinicalEntry.otherAddColRisk.blank')
                }
            }
        }
        
        if ((clinicalDataEntryInstance.perfStatusScale.equals(null))||(clinicalDataEntryInstance.perfStatusScale.trim().equals(''))) {
            result.put('perfStatusScale', 'clinicalEntry.perfStatusScale.blank')
        } else {
            if (clinicalDataEntryInstance.perfStatusScale.equals("Karnofsky Score") && clinicalDataEntryInstance.karnofskyScore.equals(null)) {
                result.put('karnofskyScore', 'clinicalEntry.karnofskyScore.blank')
            }
            if (clinicalDataEntryInstance.perfStatusScale.equals("Eastern Cancer Oncology Group") && clinicalDataEntryInstance.ecogStatus.equals(null)) {
                result.put('ecogStatus', 'clinicalEntry.ecogStatus.blank')
            }            
        }               
        
        if ( ((!clinicalDataEntryInstance.perfStatusScale)||(clinicalDataEntryInstance.perfStatusScale == 'Not Recorded')||(clinicalDataEntryInstance.perfStatusScale.trim().equals('')))) {}
        else
        {
            if ((clinicalDataEntryInstance.timingOfScore.equals(null))||(clinicalDataEntryInstance.timingOfScore.trim().equals(''))) {
                result.put('timingOfScore', 'clinicalEntry.timingOfScore.blank')
            } else if (clinicalDataEntryInstance.timingOfScore.equals('Other, Specify') && ((clinicalDataEntryInstance.timingOfScoreOs == null)||clinicalDataEntryInstance.timingOfScoreOs.trim().equals(''))) {
                result.put('timingOfScoreOs', 'clinicalEntry.timingOfScoreOs.blank')
            }
        }

        recsToDelList.each() {
            def therapyRecordInstance = TherapyRecord.get(it)
            clinicalDataEntryInstance.removeFromTherapyRecords(therapyRecordInstance)
            therapyRecordInstance.delete(flush:true)
        }
        return result
    }
    def checkboxReset(clinicalDataEntryInstance)
    {
        if(clinicalDataEntryInstance.isEnvCarc == 'Yes' )
        {
           
            clinicalDataEntryInstance.envCarc1= params.envCarc1 ? params.envCarc1 : null
            clinicalDataEntryInstance.envCarc2= params.envCarc2 ? params.envCarc2 : null
            clinicalDataEntryInstance.envCarc3= params.envCarc3 ? params.envCarc3 : null
            clinicalDataEntryInstance.envCarc4= params.envCarc4 ? params.envCarc4 : null
            clinicalDataEntryInstance.envCarc5= params.envCarc5 ? params.envCarc5 : null
        }
        else
        {
            clinicalDataEntryInstance.envCarc1 = null
            clinicalDataEntryInstance.envCarc2 = null
            clinicalDataEntryInstance.envCarc3 = null
            clinicalDataEntryInstance.envCarc4 = null
            clinicalDataEntryInstance.envCarc5 = null
        }
        if(clinicalDataEntryInstance.isImmunoSupp == 'Yes')
        {
            clinicalDataEntryInstance.immunoSuppStatus1= params.immunoSuppStatus1 ? params.immunoSuppStatus1 : null
            clinicalDataEntryInstance.immunoSuppStatus2= params.immunoSuppStatus2 ? params.immunoSuppStatus2 : null
            clinicalDataEntryInstance.immunoSuppStatus3= params.immunoSuppStatus3 ? params.immunoSuppStatus3 : null
            clinicalDataEntryInstance.immunoSuppStatus4= params.immunoSuppStatus4 ? params.immunoSuppStatus4 : null
            clinicalDataEntryInstance.otherImmunoSuppStatus= params.otherImmunoSuppStatus ? params.otherImmunoSuppStatus :null
        
        }
        else
        { 
            clinicalDataEntryInstance.immunoSuppStatus1 = null
            clinicalDataEntryInstance.immunoSuppStatus2 = null
            clinicalDataEntryInstance.immunoSuppStatus3 = null
            clinicalDataEntryInstance.immunoSuppStatus4 = null
            clinicalDataEntryInstance.otherImmunoSuppStatus = null
        }
        return clinicalDataEntryInstance
    }
}
