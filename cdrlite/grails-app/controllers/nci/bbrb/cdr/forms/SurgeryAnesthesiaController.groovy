package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CaseRecord


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SurgeryAnesthesiaController {
    def accessPrivilegeService
    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SurgeryAnesthesia.list(params), model:[surgeryAnesthesiaInstanceCount: SurgeryAnesthesia.count()]
    }

    def show(SurgeryAnesthesia surgeryAnesthesiaInstance) {
        def canResume
        if(!accessPrivilegeService.hasPrivilege(surgeryAnesthesiaInstance?.caseRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        canResume=true
        
        
        //respond surgeryAnesthesiaInstance
        [surgeryAnesthesiaInstance: surgeryAnesthesiaInstance, canResume: canResume]
    }
    
   
    
    def save = {
       
        def surgeryAnesthesiaInstance = new SurgeryAnesthesia(params)
        if (surgeryAnesthesiaInstance.save(flush: true)) {
            // flash.message = "${message(code: 'default.created.message', args: [message(code: 'surgeryAnesthesiaInstance.label', default: 'SurgeryAnesthesia'), surgeryAnesthesiaInstance.id])}"
            flash.message = message(code: 'default.created.message', args: [message(code: 'surgeryAnesthesiaInstance', default: 'Surgery Anesthesia Form for '), surgeryAnesthesiaInstance.caseRecord.caseId])  
        }
        redirect(action: "edit", id: surgeryAnesthesiaInstance.id)
    }
  
    def edit(SurgeryAnesthesia surgeryAnesthesiaInstance) {
        // respond surgeryAnesthesiaInstance
        
        if(!surgeryAnesthesiaInstance) {
            flash.message = "surgeryAnesthesiaInstance not found"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(surgeryAnesthesiaInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            surgeryAnesthesiaInstance.submittedBy=null
            surgeryAnesthesiaInstance.dateSubmitted=null
            
            if(surgeryAnesthesiaInstance.version > 0){
                validateFields(surgeryAnesthesiaInstance)
            }
            def canSubmit
            if(!surgeryAnesthesiaInstance.errors.hasErrors() && surgeryAnesthesiaInstance.surgeryDate){
                canSubmit =true
            }
           
            return [surgeryAnesthesiaInstance: surgeryAnesthesiaInstance, canSubmit: canSubmit]
        }
    }      

    
    def update = {
        def surgeryAnesthesiaInstance = SurgeryAnesthesia.get(params.id)
        if (surgeryAnesthesiaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (surgeryAnesthesiaInstance.version > version) {
                    
                    surgeryAnesthesiaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'candidateEligibility.label', default: 'SurgeryAnesthesia')] as Object[], "Another user has updated this SurgeryAnesthesia while you were editing")
                    render(view: "edit", model: [surgeryAnesthesiaInstance: surgeryAnesthesiaInstance])
                    return
                }
            }
            surgeryAnesthesiaInstance.properties=params
           
            boolean successSaved = false
            try
            {
                successSaved = surgeryAnesthesiaInstance.save(flush: true)
               
            }catch(java.sql.BatchUpdateException se)
            {
                flash.message("Another user has updated this form while you were editing")
           
            }
            def canSubmit=false
            def errorMap
            //println surgeryAnesthesiaInstance.version+" is version"
            // params.each {k,v->
            //     println k+"->"+v
            // }
            if(surgeryAnesthesiaInstance.version > 0){
                validateFields(surgeryAnesthesiaInstance)
                // canSubmit = !surgeryAnesthesiaInstance.errors.hasErrors()
            }
            if(!surgeryAnesthesiaInstance.errors.hasErrors()){
                canSubmit=true
                flash.message = message(code: 'default.updated.message', args: [message(code: 'surgeryAnesthesiaInstance', default: 'Surgery Anesthesia Form for '), surgeryAnesthesiaInstance.caseRecord.caseId])  
            }
               
            render(view: "edit", model: [surgeryAnesthesiaInstance: surgeryAnesthesiaInstance,canSubmit:canSubmit])
           
        }
        else {
            redirect(controller: "caseRecord", action: "show", id: params.caseId)
        }
    }

    @Transactional
    def submit(SurgeryAnesthesia surgeryAnesthesiaInstance) {
        if (surgeryAnesthesiaInstance == null) {
            notFound()
            return
        }
        
    
        if(params.version) {
            def version = params.version.toLong()
            if(surgeryAnesthesiaInstance.version > version) {
                    
                surgeryAnesthesiaInstance.errors.rejectValue("version", null, "Another user has updated this SurgeryAnesthesia while you were editing")
                //render(view: "edit", model: [surgeryAnesthesiaInstance: surgeryAnesthesiaInstance])
                respond surgeryAnesthesiaInstance.errors, view:'edit'
                return
            }
        }

        if (surgeryAnesthesiaInstance.hasErrors()) {
            respond surgeryAnesthesiaInstance.errors, view:'edit'
            return
        }
        surgeryAnesthesiaInstance.dateSubmitted = new Date()
        surgeryAnesthesiaInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        surgeryAnesthesiaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.submitted.message', args: [message(code: 'SurgeryAnesthesia.label', default: 'SurgeryAnesthesia Form for '), surgeryAnesthesiaInstance.caseRecord.caseId])
                redirect(controller: "caseRecord", action: "show", id: params.caseId)
            }
           
        }
    }

   

    def resumeEditing = {
        def surgeryAnesthesiaInstance = SurgeryAnesthesia.get(params.id)
        surgeryAnesthesiaInstance.dateSubmitted = null
        surgeryAnesthesiaInstance.submittedBy = null

        if(surgeryAnesthesiaInstance.save(flush: true)) {
            redirect(action: "edit", id: surgeryAnesthesiaInstance.id)
        } else {
            render(view: "show", model: [surgeryAnesthesiaInstance: surgeryAnesthesiaInstance])
        }
    }
    
   
    @Transactional
    def delete(SurgeryAnesthesia surgeryAnesthesiaInstance) {

        if (surgeryAnesthesiaInstance == null) {
            notFound()
            return
        }

        surgeryAnesthesiaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SurgeryAnesthesia.label', default: 'SurgeryAnesthesia'), surgeryAnesthesiaInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'surgeryAnesthesia.label', default: 'SurgeryAnesthesia'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    def validateFields(surgeryAnesthesiaInstance) {
        String primaryTissueType = surgeryAnesthesiaInstance.caseRecord?.primaryTissueType?.toString()
        boolean isPrimaryTissueTypeLung = "Lung".equals(primaryTissueType)
        boolean isPrimaryTissueTypeOvary = "Ovary".equals(primaryTissueType)
        boolean isPrimaryTissueTypeColon = "Colon".equals(primaryTissueType)
        boolean isPrimaryTissueTypeKidney = "Kidney".equals(primaryTissueType)

        setError(surgeryAnesthesiaInstance, 'surgeryDate', surgeryAnesthesiaInstance.surgeryDate, 'Surgery date is required.');

        //println " in validate error routine"
        if(surgeryAnesthesiaInstance.poSedDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('poSedDiv', null, 'Please specify Yes/No to state if Pre-operative IV Sedation drugs were administered.')
        } else {
            if(surgeryAnesthesiaInstance.poSedDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.poSed1Name && !surgeryAnesthesiaInstance.poSed2Name &&
                    !surgeryAnesthesiaInstance.poSed3Name && !surgeryAnesthesiaInstance.poSed4Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('poSed1Name',null,  'Please choose at least one Pre-operative IV Sedation drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.poSed1Name) {
                        setError(surgeryAnesthesiaInstance, 'poSed1Dose', surgeryAnesthesiaInstance.poSed1Dose, 'The Pre-operative IV Sedation administered drug (Diazepam) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poSed1Unit', surgeryAnesthesiaInstance.poSed1Unit, 'The Pre-operative IV Sedation administered drug (Diazepam) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poSed1Time', surgeryAnesthesiaInstance.poSed1Time, 'The Pre-operative IV Sedation administered drug (Diazepam) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poSed2Name) {
                        setError(surgeryAnesthesiaInstance, 'poSed2Dose', surgeryAnesthesiaInstance.poSed2Dose, 'The Pre-operative IV Sedation administered drug (Lorazepam) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poSed2Unit', surgeryAnesthesiaInstance.poSed2Unit, 'The Pre-operative IV Sedation administered drug (Lorazepam) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poSed2Time', surgeryAnesthesiaInstance.poSed2Time, 'The Pre-operative IV Sedation administered drug (Lorazepam) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poSed3Name) {
                        setError(surgeryAnesthesiaInstance, 'poSed3Dose', surgeryAnesthesiaInstance.poSed3Dose, 'The Pre-operative IV Sedation administered drug (Midazolam) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poSed3Unit', surgeryAnesthesiaInstance.poSed3Unit, 'The Pre-operative IV Sedation administered drug (Midazolam) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poSed3Time', surgeryAnesthesiaInstance.poSed3Time, 'The Pre-operative IV Sedation administered drug (Midazolam) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poSed4Name) {
                        setError(surgeryAnesthesiaInstance, 'poSed4Dose', surgeryAnesthesiaInstance.poSed4Dose, 'The Other IV Sedation administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poSed4Unit', surgeryAnesthesiaInstance.poSed4Unit, 'The Other IV Sedation administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poSed4Time', surgeryAnesthesiaInstance.poSed4Time, 'The Other IV Sedation administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }


        if(surgeryAnesthesiaInstance.poOpDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('poOpDiv', null, 'Please specify Yes/No to state if Pre-operative IV Opiate drugs were administered.')
        } else {
            if(surgeryAnesthesiaInstance.poOpDiv.equals("Yes")) {        
                if(!surgeryAnesthesiaInstance.poOp1Name && !surgeryAnesthesiaInstance.poOp2Name &&
                    !surgeryAnesthesiaInstance.poOp3Name && !surgeryAnesthesiaInstance.poOp4Name && !surgeryAnesthesiaInstance.poOp5Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('poOp1Name',null,  'Please choose at least one Pre-operative IV Opiates drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.poOp1Name) {
                        setError(surgeryAnesthesiaInstance, 'poOp1Dose', surgeryAnesthesiaInstance.poOp1Dose, 'The Pre-operative IV Opiates administered drug (Fentanyl) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poOp1Unit', surgeryAnesthesiaInstance.poOp1Unit, 'The Pre-operative IV Opiates administered drug (Fentanyl) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poOp1Time', surgeryAnesthesiaInstance.poOp1Time, 'The Pre-operative IV Opiates administered drug (Fentanyl) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poOp2Name) {
                        setError(surgeryAnesthesiaInstance, 'poOp2Dose', surgeryAnesthesiaInstance.poOp2Dose, 'The Pre-operative IV Opiates administered drug (Hydromorphone) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poOp2Unit', surgeryAnesthesiaInstance.poOp2Unit, 'The Pre-operative IV Opiates administered drug (Hydromorphone) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poOp2Time', surgeryAnesthesiaInstance.poOp2Time, 'The Pre-operative IV Opiates administered drug (Hydromorphone) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poOp3Name) {
                        setError(surgeryAnesthesiaInstance, 'poOp3Dose', surgeryAnesthesiaInstance.poOp3Dose, 'The Pre-operative IV Opiates administered drug (Meperidine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poOp3Unit', surgeryAnesthesiaInstance.poOp3Unit, 'The Pre-operative IV Opiates administered drug (Meperidine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poOp3Time', surgeryAnesthesiaInstance.poOp3Time, 'The Pre-operative IV Opiates administered drug (Meperidine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poOp4Name) {
                        setError(surgeryAnesthesiaInstance, 'poOp4Dose', surgeryAnesthesiaInstance.poOp4Dose, 'The Pre-operative IV Opiates administered drug (Morphine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poOp4Unit', surgeryAnesthesiaInstance.poOp4Unit, 'The Pre-operative IV Opiates administered drug (Morphine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poOp4Time', surgeryAnesthesiaInstance.poOp4Time, 'The Pre-operative IV Opiates administered drug (Morphine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poOp5Name) {
                        setError(surgeryAnesthesiaInstance, 'poOp5Dose', surgeryAnesthesiaInstance.poOp5Dose, 'The Other IV Opiates administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poOp5Unit', surgeryAnesthesiaInstance.poOp5Unit, 'The Other IV Opiates administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poOp5Time', surgeryAnesthesiaInstance.poOp5Time, 'The Other IV Opiates administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.poAntiemDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('poAntiemDiv',null,  'Please specify Yes/No to state if Pre-operative IV Antiemetic drugs were administered.')
        } else {
            if(surgeryAnesthesiaInstance.poAntiemDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.poAntiem1Name &&
                    !surgeryAnesthesiaInstance.poAntiem2Name && !surgeryAnesthesiaInstance.poAntiem3Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('poAntiem1Name',null,  'Please choose at least one Pre-operative IV Antiemetics drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.poAntiem1Name) {
                        setError(surgeryAnesthesiaInstance, 'poAntiem1Dose', surgeryAnesthesiaInstance.poAntiem1Dose, 'The Pre-operative IV Antiemetics administered drug (Droperidol) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poAntiem1Unit', surgeryAnesthesiaInstance.poAntiem1Unit, 'The Pre-operative IV Antiemetics administered drug (Droperidol) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poAntiem1Time', surgeryAnesthesiaInstance.poAntiem1Time, 'The Pre-operative IV Antiemetics administered drug (Droperidol) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poAntiem2Name) {
                        setError(surgeryAnesthesiaInstance, 'poAntiem2Dose', surgeryAnesthesiaInstance.poAntiem2Dose, 'The Pre-operative IV Antiemetic administered drug (Ondansetron) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poAntiem2Unit', surgeryAnesthesiaInstance.poAntiem2Unit, 'The Pre-operative IV Antiemetic administered drug (Ondansetron) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poAntiem2Time', surgeryAnesthesiaInstance.poAntiem2Time, 'The Pre-operative IV Antiemetic administered drug (Ondansetron) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poAntiem3Name) {
                        setError(surgeryAnesthesiaInstance, 'poAntiem3Dose', surgeryAnesthesiaInstance.poAntiem3Dose, 'The Other IV Antiemetic administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poAntiem3Unit', surgeryAnesthesiaInstance.poAntiem3Unit, 'The Other IV Antiemetic administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poAntiem3Time', surgeryAnesthesiaInstance.poAntiem3Time, 'The Other IV Antiemetic administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.poAntiAcDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('poAntiAcDiv',null,  'Please specify Yes/No to state if Pre-operative IV Anti-acid drugs were administered.')
        } else {
            if(surgeryAnesthesiaInstance.poAntiAcDiv.equals("Yes")) {        
                if(!surgeryAnesthesiaInstance.poAntiAc1Name && !surgeryAnesthesiaInstance.poAntiAc2Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('poAntiAc1Name', null, 'Please choose at least one Pre-operative IV Anti-acids drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.poAntiAc1Name) {
                        setError(surgeryAnesthesiaInstance, 'poAntiAc1Dose', surgeryAnesthesiaInstance.poAntiAc1Dose, 'The Pre-operative IV Anti-acids administered drug (Ranitidine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poAntiAc1Unit', surgeryAnesthesiaInstance.poAntiAc1Unit, 'The Pre-operative IV Anti-acids administered drug (Ranitidine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poAntiAc1Time', surgeryAnesthesiaInstance.poAntiAc1Time, 'The Pre-operative IV Anti-acids administered drug (Ranitidine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poAntiAc2Name) {
                        setError(surgeryAnesthesiaInstance, 'poAntiAc2Dose', surgeryAnesthesiaInstance.poAntiAc2Dose, 'The Other IV Anti-acids administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poAntiAc2Unit', surgeryAnesthesiaInstance.poAntiAc2Unit, 'The Other IV Anti-acids administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poAntiAc2Time', surgeryAnesthesiaInstance.poAntiAc2Time, 'The Other IV Anti-acids administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        if(surgeryAnesthesiaInstance.poMedDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('poMedDiv',null, 'Please specify Yes/No to state if Other Pre-operative IV Medications were administered.')
        } else {
            if(surgeryAnesthesiaInstance.poMedDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.poMed1Name && !surgeryAnesthesiaInstance.poMed2Name && !surgeryAnesthesiaInstance.poMed3Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('poMed1Name', null, 'Please enter one (or more) Pre-operative IV drug(s) used but not mentioned above and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.poMed1Name) {
                        setError(surgeryAnesthesiaInstance, 'poMed1Dose', surgeryAnesthesiaInstance.poMed1Dose, 'The Other Pre-operative IV Medications first entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poMed1Unit', surgeryAnesthesiaInstance.poMed1Unit, 'The Other Pre-operative IV Medications first entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poMed1Time', surgeryAnesthesiaInstance.poMed1Time, 'The Other Pre-operative IV Medications first entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poMed2Name) {
                        setError(surgeryAnesthesiaInstance, 'poMed2Dose', surgeryAnesthesiaInstance.poMed2Dose, 'The Other Pre-operative IV Medications second entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poMed2Unit', surgeryAnesthesiaInstance.poMed2Unit, 'The Other Pre-operative IV Medications second entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poMed2Time', surgeryAnesthesiaInstance.poMed2Time, 'The Other Pre-operative IV Medications second entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.poMed3Name) {
                        setError(surgeryAnesthesiaInstance, 'poMed3Dose', surgeryAnesthesiaInstance.poMed3Dose, 'The Other Pre-operative IV Medications third entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'poMed3Unit', surgeryAnesthesiaInstance.poMed3Unit, 'The Other Pre-operative IV Medications third entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'poMed3Time', surgeryAnesthesiaInstance.poMed3Time, 'The Other Pre-operative IV Medications third entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        //setError(surgeryAnesthesiaInstance, 'anesIndStartTime', surgeryAnesthesiaInstance.anesIndStartTime, 'Time Anesthesia Induction began is required');

        if(surgeryAnesthesiaInstance.localAnesDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('localAnesDiv', null, 'Please specify Yes/No to state if Local Anesthesia Agents were administered.')
        } else {
            if(surgeryAnesthesiaInstance.localAnesDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.localAnes1Name &&
                    !surgeryAnesthesiaInstance.localAnes2Name &&
                    !surgeryAnesthesiaInstance.localAnes3Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('localAnes1Name',null,  'Please choose at least one Local Anesthesia Agents drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.localAnes1Name) {
                        setError(surgeryAnesthesiaInstance, 'localAnes1Dose', surgeryAnesthesiaInstance.localAnes1Dose, 'The Local Anesthesia Agents administered drug (Lidocaine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'localAnes1Unit', surgeryAnesthesiaInstance.localAnes1Unit, 'The Local Anesthesia Agents administered drug (Lidocaine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'localAnes1Time', surgeryAnesthesiaInstance.localAnes1Time, 'The Local Anesthesia Agents administered drug (Lidocaine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.localAnes2Name) {
                        setError(surgeryAnesthesiaInstance, 'localAnes2Dose', surgeryAnesthesiaInstance.localAnes2Dose, 'The Local Anesthesia Agents administered drug (Procaine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'localAnes2Unit', surgeryAnesthesiaInstance.localAnes2Unit, 'The Local Anesthesia Agents administered drug (Procaine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'localAnes2Time', surgeryAnesthesiaInstance.localAnes2Time, 'The Local Anesthesia Agents administered drug (Procaine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.localAnes3Name) {
                        setError(surgeryAnesthesiaInstance, 'localAnes3Dose', surgeryAnesthesiaInstance.localAnes3Dose, 'The Other IV Local Anesthesia Agents administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'localAnes3Unit', surgeryAnesthesiaInstance.localAnes3Unit, 'The Other IV Local Anesthesia Agents administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'localAnes3Time', surgeryAnesthesiaInstance.localAnes3Time, 'The Other IV Local Anesthesia Agents administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.regAnesDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('regAnesDiv', null, 'Please specify Yes/No to state if Regional Anesthesia Agents were administered.')
        } else {
            if(surgeryAnesthesiaInstance.regAnesDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.regAnes1Name &&
                    !surgeryAnesthesiaInstance.regAnes2Name &&
                    !surgeryAnesthesiaInstance.regAnes3Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('regAnes1Name', null, 'Please choose at least one Regional (Spinal/Epidural) Anesthesia Agents drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.regAnes1Name) {
                        setError(surgeryAnesthesiaInstance, 'regAnes1Dose', surgeryAnesthesiaInstance.regAnes1Dose, 'The Regional (Spinal/Epidural) Anesthesia Agents administered drug (Bupivacaine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'regAnes1Unit', surgeryAnesthesiaInstance.regAnes1Unit, 'The Regional (Spinal/Epidural) Anesthesia Agents administered drug (Bupivacaine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'regAnes1Time', surgeryAnesthesiaInstance.regAnes1Time, 'The Regional (Spinal/Epidural) Anesthesia Agents administered drug (Bupivacaine) entry is incomplete. Please enter the time.')
                    }

                    if(surgeryAnesthesiaInstance.regAnes2Name) {
                        setError(surgeryAnesthesiaInstance, 'regAnes2Dose', surgeryAnesthesiaInstance.regAnes2Dose, 'The Regional (Spinal/Epidural) Anesthesia Agents administered drug (Lidocaine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'regAnes2Unit', surgeryAnesthesiaInstance.regAnes2Unit, 'The Regional (Spinal/Epidural) Anesthesia Agents administered drug (Lidocaine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'regAnes2Time', surgeryAnesthesiaInstance.regAnes2Time, 'The Regional (Spinal/Epidural) Anesthesia Agents administered drug (Lidocaine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.regAnes3Name) {
                        setError(surgeryAnesthesiaInstance, 'regAnes3Dose', surgeryAnesthesiaInstance.regAnes3Dose, 'The Other Spinal/Regional Anesthetic administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'regAnes3Unit', surgeryAnesthesiaInstance.regAnes3Unit, 'The Other Spinal/Regional Anesthetic administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'regAnes3Time', surgeryAnesthesiaInstance.regAnes3Time, 'The Other Spinal/Regional Anesthetic administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.anesDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('anesDiv', null, 'Please specify Yes/No to state if IV Anesthesia Agents were administered.')
        } else {
            if(surgeryAnesthesiaInstance.anesDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.anes1Name && !surgeryAnesthesiaInstance.anes2Name &&
                    !surgeryAnesthesiaInstance.anes3Name && !surgeryAnesthesiaInstance.anes4Name &&
                    !surgeryAnesthesiaInstance.anes5Name && !surgeryAnesthesiaInstance.anes6Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('anes1Name',null,  'Please choose at least one IV Anesthesia Agents drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.anes1Name) {
                        setError(surgeryAnesthesiaInstance, 'anes1Dose', surgeryAnesthesiaInstance.anes1Dose, 'The IV Anesthesia Agents administered drug (Brevital) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'anes1Unit', surgeryAnesthesiaInstance.anes1Unit, 'The IV Anesthesia Agents administered drug (Brevital) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'anes1Time', surgeryAnesthesiaInstance.anes1Time, 'The IV Anesthesia Agents administered drug (Brevital) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.anes2Name) {
                        setError(surgeryAnesthesiaInstance, 'anes2Dose', surgeryAnesthesiaInstance.anes2Dose, 'The IV Anesthesia Agents administered drug (Etomidate) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'anes2Unit', surgeryAnesthesiaInstance.anes2Unit, 'The IV Anesthesia Agents administered drug (Etomidate) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'anes2Time', surgeryAnesthesiaInstance.anes2Time, 'The IV Anesthesia Agents administered drug (Etomidate) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.anes3Name) {
                        setError(surgeryAnesthesiaInstance, 'anes3Dose', surgeryAnesthesiaInstance.anes3Dose, 'The IV Anesthesia Agents administered drug (Ketamine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'anes3Unit', surgeryAnesthesiaInstance.anes3Unit, 'The IV Anesthesia Agents administered drug (Ketamine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'anes3Time', surgeryAnesthesiaInstance.anes3Time, 'The IV Anesthesia Agents administered drug (Ketamine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.anes4Name) {
                        setError(surgeryAnesthesiaInstance, 'anes4Dose', surgeryAnesthesiaInstance.anes4Dose, 'The IV Anesthesia Agents administered drug (Propofol) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'anes4Unit', surgeryAnesthesiaInstance.anes4Unit, 'The IV Anesthesia Agents administered drug (Propofol) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'anes4Time', surgeryAnesthesiaInstance.anes4Time, 'The IV Anesthesia Agents administered drug (Propofol) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.anes5Name) {
                        setError(surgeryAnesthesiaInstance, 'anes5Dose', surgeryAnesthesiaInstance.anes5Dose, 'The IV Anesthesia Agents administered drug (Sodium Thiopental) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'anes5Unit', surgeryAnesthesiaInstance.anes5Unit, 'The IV Anesthesia Agents administered drug (Sodium Thiopental) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'anes5Time', surgeryAnesthesiaInstance.anes5Time, 'The IV Anesthesia Agents administered drug (Sodium Thiopental) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.anes6Name) {
                        setError(surgeryAnesthesiaInstance, 'anes6Dose', surgeryAnesthesiaInstance.anes6Dose, 'The Other IV Anesthesia Agents administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'anes6Unit', surgeryAnesthesiaInstance.anes6Unit, 'The Other IV Anesthesia Agents administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'anes6Time', surgeryAnesthesiaInstance.anes6Time, 'The Other IV Anesthesia Agents administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.narcOpDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('narcOpDiv', null, 'Please specify Yes/No to state if IV Narcotic/Opiate Agents were administered.')
        } else {
            if(surgeryAnesthesiaInstance.narcOpDiv.equals("Yes")) {        
                if(!surgeryAnesthesiaInstance.narcOp1Name && !surgeryAnesthesiaInstance.narcOp2Name &&
                    !surgeryAnesthesiaInstance.narcOp3Name && !surgeryAnesthesiaInstance.narcOp4Name && !surgeryAnesthesiaInstance.narcOp5Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('narcOp1Name', null, 'Please choose at least one IV Narcotic/Opiate Agents drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.narcOp1Name) {
                        setError(surgeryAnesthesiaInstance, 'narcOp1Dose', surgeryAnesthesiaInstance.narcOp1Dose, 'The IV Narcotic/Opiate Agents administered drug (Fentanyl) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'narcOp1Unit', surgeryAnesthesiaInstance.narcOp1Unit, 'The IV Narcotic/Opiate Agents administered drug (Fentanyl) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'narcOp1Time', surgeryAnesthesiaInstance.narcOp1Time, 'The IV Narcotic/Opiate Agents administered drug (Fentanyl) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.narcOp2Name) {
                        setError(surgeryAnesthesiaInstance, 'narcOp2Dose', surgeryAnesthesiaInstance.narcOp2Dose, 'The IV Narcotic/Opiate Agents administered drug (Hydromorphone) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'narcOp2Unit', surgeryAnesthesiaInstance.narcOp2Unit, 'The IV Narcotic/Opiate Agents administered drug (Hydromorphone) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'narcOp2Time', surgeryAnesthesiaInstance.narcOp2Time, 'The IV Narcotic/Opiate Agents administered drug (Hydromorphone) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.narcOp3Name) {
                        setError(surgeryAnesthesiaInstance, 'narcOp3Dose', surgeryAnesthesiaInstance.narcOp3Dose, 'The IV Narcotic/Opiate Agents administered drug (Meperidine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'narcOp3Unit', surgeryAnesthesiaInstance.narcOp3Unit, 'The IV Narcotic/Opiate Agents administered drug (Meperidine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'narcOp3Time', surgeryAnesthesiaInstance.narcOp3Time, 'The IV Narcotic/Opiate Agents administered drug (Meperidine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.narcOp4Name) {
                        setError(surgeryAnesthesiaInstance, 'narcOp4Dose', surgeryAnesthesiaInstance.narcOp4Dose, 'The IV Narcotic/Opiate Agents administered drug (Morphine) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'narcOp4Unit', surgeryAnesthesiaInstance.narcOp4Unit, 'The IV Narcotic/Opiate Agents administered drug (Morphine) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'narcOp4Time', surgeryAnesthesiaInstance.narcOp4Time, 'The IV Narcotic/Opiate Agents administered drug (Morphine) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.narcOp5Name) {
                        setError(surgeryAnesthesiaInstance, 'narcOp5Dose', surgeryAnesthesiaInstance.narcOp5Dose, 'The Other Narcotics/Opiates administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'narcOp5Unit', surgeryAnesthesiaInstance.narcOp5Unit, 'The Other Narcotics/Opiates administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'narcOp5Time', surgeryAnesthesiaInstance.narcOp5Time, 'The Other Narcotics/Opiates administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }


        if(surgeryAnesthesiaInstance.musRelaxDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('musRelaxDiv', null, 'Please specify Yes/No to state if IV Muscle Relaxants were administered.')
        } else {
            if(surgeryAnesthesiaInstance.musRelaxDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.musRelax1Name && !surgeryAnesthesiaInstance.musRelax2Name &&
                    !surgeryAnesthesiaInstance.musRelax3Name && !surgeryAnesthesiaInstance.musRelax4Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('musRelax1Name', null, 'Please choose at least one IV Muscle Relaxants drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.musRelax1Name) {
                        setError(surgeryAnesthesiaInstance, 'musRelax1Dose', surgeryAnesthesiaInstance.musRelax1Dose, 'The IV Muscle Relaxants administered drug (Pancuronium) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'musRelax1Unit', surgeryAnesthesiaInstance.musRelax1Unit, 'The IV Muscle Relaxants administered drug (Pancuronium) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'musRelax1Time', surgeryAnesthesiaInstance.musRelax1Time, 'The IV Muscle Relaxants administered drug (Pancuronium) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.musRelax2Name) {
                        setError(surgeryAnesthesiaInstance, 'musRelax2Dose', surgeryAnesthesiaInstance.musRelax2Dose, 'The IV Muscle Relaxants administered drug (Suxamethonium Chloride) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'musRelax2Unit', surgeryAnesthesiaInstance.musRelax2Unit, 'The IV Muscle Relaxants administered drug (Suxamethonium Chloride) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'musRelax2Time', surgeryAnesthesiaInstance.musRelax2Time, 'The IV Muscle Relaxants administered drug (Suxamethonium Chloride) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.musRelax3Name) {
                        setError(surgeryAnesthesiaInstance, 'musRelax3Dose', surgeryAnesthesiaInstance.musRelax3Dose, 'The IV Muscle Relaxants administered drug (Vercuronium) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'musRelax3Unit', surgeryAnesthesiaInstance.musRelax3Unit, 'The IV Muscle Relaxants administered drug (Vercuronium) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'musRelax3Time', surgeryAnesthesiaInstance.musRelax3Time, 'The IV Muscle Relaxants administered drug (Vercuronium) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.musRelax4Name) {
                        setError(surgeryAnesthesiaInstance, 'musRelax4Dose', surgeryAnesthesiaInstance.musRelax4Dose, 'The Other Muscle Relaxants administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'musRelax4Unit', surgeryAnesthesiaInstance.musRelax4Unit, 'The Other Muscle Relaxants administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'musRelax4Time', surgeryAnesthesiaInstance.musRelax4Time, 'The Other Muscle Relaxants administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.inhalAnesDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('inhalAnesDiv', null, 'Please specify Yes/No to state if Inhalation Anesthesia Agents were administered.')
        } else {
            if(surgeryAnesthesiaInstance.inhalAnesDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.inhalAnes1Name &&
                    !surgeryAnesthesiaInstance.inhalAnes2Name && !surgeryAnesthesiaInstance.inhalAnes3Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('inhalAnes1Name',null,  'Please choose at least one Inhalation Anesthesia Agents drug and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.inhalAnes1Name) {
                        setError(surgeryAnesthesiaInstance, 'inhalAnes1Dose', surgeryAnesthesiaInstance.inhalAnes1Dose, 'The Inhalation Anesthesia Agents administered drug (Isoflurane) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'inhalAnes1Unit', surgeryAnesthesiaInstance.inhalAnes1Unit, 'The Inhalation Anesthesia Agents administered drug (Isoflurane) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'inhalAnes1Time', surgeryAnesthesiaInstance.inhalAnes1Time, 'The Inhalation Anesthesia Agents administered drug (Isoflurane) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.inhalAnes2Name) {
                        setError(surgeryAnesthesiaInstance, 'inhalAnes2Dose', surgeryAnesthesiaInstance.inhalAnes2Dose, 'The Inhalation Anesthesia Agents administered drug (Nitrous Oxide) entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'inhalAnes2Unit', surgeryAnesthesiaInstance.inhalAnes2Unit, 'The Inhalation Anesthesia Agents administered drug (Nitrous Oxide) entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'inhalAnes2Time', surgeryAnesthesiaInstance.inhalAnes2Time, 'The Inhalation Anesthesia Agents administered drug (Nitrous Oxide) entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.inhalAnes3Name) {
                        setError(surgeryAnesthesiaInstance, 'inhalAnes3Dose', surgeryAnesthesiaInstance.inhalAnes3Dose, 'The Other Inhalation Anesthesia Agents administered drug entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'inhalAnes3Unit', surgeryAnesthesiaInstance.inhalAnes3Unit, 'The Other Inhalation Anesthesia Agents administered drug entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'inhalAnes3Time', surgeryAnesthesiaInstance.inhalAnes3Time, 'The Other Inhalation Anesthesia Agents administered drug entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        
        if(surgeryAnesthesiaInstance.addtlAnesDiv == null) {
            surgeryAnesthesiaInstance.errors.rejectValue('addtlAnesDiv', null, 'Please specify Yes/No to state if any Additional Anesthesia Agents were administered.')
        } else {
            if(surgeryAnesthesiaInstance.addtlAnesDiv.equals("Yes")) {
                if(!surgeryAnesthesiaInstance.addtlAnes1Name &&
                    !surgeryAnesthesiaInstance.addtlAnes2Name && !surgeryAnesthesiaInstance.addtlAnes3Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('addtlAnes1Name', null, 'Please enter one (or more) Additional Anesthesia Agents drug(s) used but not mentioned above and enter its dosage, unit and time')
                } else {
                    if(surgeryAnesthesiaInstance.addtlAnes1Name) {
                        setError(surgeryAnesthesiaInstance, 'addtlAnes1Dose', surgeryAnesthesiaInstance.addtlAnes1Dose, 'The Additional Anesthesia Agents Used first entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'addtlAnes1Unit', surgeryAnesthesiaInstance.addtlAnes1Unit, 'The Additional Anesthesia Agents Used first entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'addtlAnes1Time', surgeryAnesthesiaInstance.addtlAnes1Time, 'The Additional Anesthesia Agents Used first entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.addtlAnes2Name) {
                        setError(surgeryAnesthesiaInstance, 'addtlAnes2Dose', surgeryAnesthesiaInstance.addtlAnes2Dose, 'The Additional Anesthesia Agents Used second entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'addtlAnes2Unit', surgeryAnesthesiaInstance.addtlAnes2Unit, 'The Additional Anesthesia Agents Used second entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'addtlAnes2Time', surgeryAnesthesiaInstance.addtlAnes2Time, 'The Additional Anesthesia Agents Used second entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.addtlAnes3Name) {
                        setError(surgeryAnesthesiaInstance, 'addtlAnes3Dose', surgeryAnesthesiaInstance.addtlAnes3Dose, 'The Additional Anesthesia Agents Used third entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'addtlAnes3Unit', surgeryAnesthesiaInstance.addtlAnes3Unit, 'The Additional Anesthesia Agents Used third entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'addtlAnes3Time', surgeryAnesthesiaInstance.addtlAnes3Time, 'The Additional Anesthesia Agents Used third entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        if((surgeryAnesthesiaInstance.insulinAdmin.equals(null) || "Undef".equals(surgeryAnesthesiaInstance.insulinAdmin)) && 
            (surgeryAnesthesiaInstance.steroidAdmin.equals(null) || "Undef".equals(surgeryAnesthesiaInstance.steroidAdmin)) && 
            (surgeryAnesthesiaInstance.antibioAdmin.equals(null) || "Undef".equals(surgeryAnesthesiaInstance.antibioAdmin)) &&
            (surgeryAnesthesiaInstance.othMedAdmin.equals(null) || "Undef".equals(surgeryAnesthesiaInstance.othMedAdmin))) {
            surgeryAnesthesiaInstance.errors.rejectValue('insulinAdmin', null, 'Please specify Yes/No to state if any Insulin drugs were administered.')
            surgeryAnesthesiaInstance.errors.rejectValue('steroidAdmin', null, 'Please specify Yes/No to state if any Steroid drugs were administered.')
            surgeryAnesthesiaInstance.errors.rejectValue('antibioAdmin', null, 'Please specify Yes/No to state if any Antibiotic drugs were administered.')
            surgeryAnesthesiaInstance.errors.rejectValue('othMedAdmin', null, 'Please specify Yes/No to state if any Other medication were administered.')
        } else {
            if("Yes".equals(surgeryAnesthesiaInstance.insulinAdmin)) {
                if(!surgeryAnesthesiaInstance.insul1Name && !surgeryAnesthesiaInstance.insul2Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('insul1Name', null, 'Please enter details for at least one of the other (Insulin) medications administered during surgery.')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('insul1Dose', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('insul1Unit', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('insul1Time', '')
                } else {
                    if(surgeryAnesthesiaInstance.insul1Name) {
                        setError(surgeryAnesthesiaInstance, 'insul1Dose', surgeryAnesthesiaInstance.insul1Dose, 'The other medications administered during surgery first Insulin entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'insul1Unit', surgeryAnesthesiaInstance.insul1Unit, 'The other medications administered during surgery first Insulin entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'insul1Time', surgeryAnesthesiaInstance.insul1Time, 'The other medications administered during surgery first Insulin entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.insul2Name) {
                        setError(surgeryAnesthesiaInstance, 'insul2Dose', surgeryAnesthesiaInstance.insul2Dose, 'The other medications administered during surgery second Insulin entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'insul2Unit', surgeryAnesthesiaInstance.insul2Unit, 'The other medications administered during surgery second Insulin entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'insul2Time', surgeryAnesthesiaInstance.insul2Time, 'The other medications administered during surgery second Insulin entry is incomplete. Please enter the time.');
                    }
                }
            }

            if("Yes".equals(surgeryAnesthesiaInstance.steroidAdmin)) {
                if(!surgeryAnesthesiaInstance.steroid1Name && !surgeryAnesthesiaInstance.steroid2Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('steroid1Name', null, 'Please enter details for at least one of the other (Steroid) medications administered during surgery.')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('steroid1Dose', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('steroid1Unit', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('steroid1Time', '')
                } else {
                    if(surgeryAnesthesiaInstance.steroid1Name) {
                        setError(surgeryAnesthesiaInstance, 'steroid1Dose', surgeryAnesthesiaInstance.steroid1Dose, 'The other medications administered during surgery first Steroid entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'steroid1Unit', surgeryAnesthesiaInstance.steroid1Unit, 'The other medications administered during surgery first Steroid entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'steroid1Time', surgeryAnesthesiaInstance.steroid1Time, 'The other medications administered during surgery first Steroid entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.steroid2Name) {
                        setError(surgeryAnesthesiaInstance, 'steroid2Dose', surgeryAnesthesiaInstance.steroid2Dose, 'The other medications administered during surgery second Steroid entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'steroid2Unit', surgeryAnesthesiaInstance.steroid2Unit, 'The other medications administered during surgery second Steroid entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'steroid2Time', surgeryAnesthesiaInstance.steroid2Time, 'The other medications administered during surgery second Steroid entry is incomplete. Please enter the time.');
                    }
                }
            }

            if("Yes".equals(surgeryAnesthesiaInstance.antibioAdmin)) {
                if(!surgeryAnesthesiaInstance.antibio1Name && !surgeryAnesthesiaInstance.antibio2Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('antibio1Name', null, 'Please enter details for at least one of the other (Antibiotic) medications administered during surgery.')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('antibio1Dose', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('antibio1Unit', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('antibio1Time', '')
                } else {
                    if(surgeryAnesthesiaInstance.antibio1Name) {
                        setError(surgeryAnesthesiaInstance, 'antibio1Dose', surgeryAnesthesiaInstance.antibio1Dose, 'The other medications administered during surgery first Antibiotic entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'antibio1Unit', surgeryAnesthesiaInstance.antibio1Unit, 'The other medications administered during surgery first Antibiotic entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'antibio1Time', surgeryAnesthesiaInstance.antibio1Time, 'The other medications administered during surgery first Antibiotic entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.antibio2Name) {
                        setError(surgeryAnesthesiaInstance, 'antibio2Dose', surgeryAnesthesiaInstance.antibio2Dose, 'The other medications administered during surgery second Antibiotic entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'antibio2Unit', surgeryAnesthesiaInstance.antibio2Unit, 'The other medications administered during surgery second Antibiotic entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'antibio2Time', surgeryAnesthesiaInstance.antibio2Time, 'The other medications administered during surgery second Antibiotic entry is incomplete. Please enter the time.');
                    }
                }
            }

            if("Yes".equals(surgeryAnesthesiaInstance.othMedAdmin)) {
                if(!surgeryAnesthesiaInstance.med1Name && !surgeryAnesthesiaInstance.med2Name) {
                    surgeryAnesthesiaInstance.errors.rejectValue('med1Name', null, 'Please enter details for at least one of the other (Other Medication) medications administered during surgery.')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('med1Dose', '')
                    //                    surgeryAnesthesiaInstance.errors.rejectValue('med1Time', '')
                } else {
                    if(surgeryAnesthesiaInstance.med1Name) {
                        setError(surgeryAnesthesiaInstance, 'med1Dose', surgeryAnesthesiaInstance.med1Dose, 'The other medications administered during surgery first Other Medication entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'med1Unit', surgeryAnesthesiaInstance.med1Unit, 'The other medications administered during surgery first Other Medication entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'med1Time', surgeryAnesthesiaInstance.med1Time, 'The other medications administered during surgery first Other Medication entry is incomplete. Please enter the time.');
                    }

                    if(surgeryAnesthesiaInstance.med2Name) {
                        setError(surgeryAnesthesiaInstance, 'med2Dose', surgeryAnesthesiaInstance.med2Dose, 'The other medications administered during surgery second Other Medication entry is incomplete. Please enter the dosage.');
                        setError(surgeryAnesthesiaInstance, 'med2Unit', surgeryAnesthesiaInstance.med2Unit, 'The other medications administered during surgery second Other Medication entry is incomplete. Please enter the unit.');
                        setError(surgeryAnesthesiaInstance, 'med2Time', surgeryAnesthesiaInstance.med2Time, 'The other medications administered during surgery second Other Medication entry is incomplete. Please enter the time.');
                    }
                }
            }
        }

        if(!surgeryAnesthesiaInstance.firstIncisTime) {
            surgeryAnesthesiaInstance.errors.rejectValue('firstIncisTime',null,  'Time of First Incision is required.')
        }

        if(isPrimaryTissueTypeColon || isPrimaryTissueTypeLung || isPrimaryTissueTypeKidney || isPrimaryTissueTypeOvary) {
            if(!surgeryAnesthesiaInstance.surgicalProc) {
                surgeryAnesthesiaInstance.errors.rejectValue('surgicalProc',null,  'Surgical Procedure is required.')
            } else if(surgeryAnesthesiaInstance.surgicalProc == 'Other-specify' && !surgeryAnesthesiaInstance.otherSurgicalProc) {
                surgeryAnesthesiaInstance.errors.rejectValue('otherSurgicalProc', null, 'Please specify other surgical procedure')
            }
        }

        if(isPrimaryTissueTypeKidney || isPrimaryTissueTypeOvary) {
            if(!surgeryAnesthesiaInstance.surgicalMethod) {
                surgeryAnesthesiaInstance.errors.rejectValue('surgicalMethod', null, 'Surgical method is required.')
            } else if(surgeryAnesthesiaInstance.surgicalMethod == 'Other-specify' && !surgeryAnesthesiaInstance.otherSurgicalMethod) {
                surgeryAnesthesiaInstance.errors.rejectValue('otherSurgicalMethod', null, 'Please specify other surgical method')
            }
        }

        
        
        int n = 0
        while(true)
        {
            n++
            
            def side = ''
            def left = ''
            def firstClampTime
            def secondClampTime
            def organResecTime
            if (n == 1)
            {
                side = 'Left'
                firstClampTime = surgeryAnesthesiaInstance.firstClampTimeLeft
                secondClampTime = surgeryAnesthesiaInstance.secondClampTimeLeft
                organResecTime = surgeryAnesthesiaInstance.organResecTimeLeft
            }
            else if (n == 2)
            {
                if(!isPrimaryTissueTypeOvary) break 
                side = 'Right'
                firstClampTime = surgeryAnesthesiaInstance.firstClampTimeRight
                secondClampTime = surgeryAnesthesiaInstance.secondClampTimeRight
                organResecTime = surgeryAnesthesiaInstance.organResecTimeRight
            }
            else break;
                        
            if(isPrimaryTissueTypeOvary) left = '- '+side+' '
            else left = ''
            
            if(!firstClampTime) {
                surgeryAnesthesiaInstance.errors.rejectValue('firstClampTime' + side, null, 'Time of First Clamp '+left+'is required.')
            }
            else
            {
                if(surgeryAnesthesiaInstance.firstIncisTime) {
                    if (surgeryAnesthesiaInstance.firstIncisTime.compareTo(firstClampTime) > 0 )
                    surgeryAnesthesiaInstance.errors.rejectValue('firstClampTime' + side, null, 'Time of First Clamp '+left+'is less than Time of First Incision.')
                }
                def compareTime = firstClampTime
                def seq = 'First'
                if (secondClampTime) {
                    if (firstClampTime.compareTo(secondClampTime) > 0 )
                    {
                        surgeryAnesthesiaInstance.errors.rejectValue('secondClampTime' + side, null, 'Time of Second Clamp '+left+'is less than Time of First Clamp.')
                    }
                    else
                    {
                        compareTime = secondClampTime
                        seq = 'Second'
                    }
                }
                
                if(organResecTime) {
                    if (compareTime.compareTo(organResecTime) > 0 )
                    surgeryAnesthesiaInstance.errors.rejectValue('organResecTime' + side, null, 'Time of Organ Resection '+left+'is less than Time of '+seq+' Clamp.')
                }
            }
            
            if(!organResecTime) {
                surgeryAnesthesiaInstance.errors.rejectValue('organResecTime' + side, null, 'Time of Organ Resection '+left+'is required.')
            }
        }
        
            
        

        //        if(!surgeryAnesthesiaInstance.temperature1 && !surgeryAnesthesiaInstance.timeTemp1 && !surgeryAnesthesiaInstance.temperature2 && !surgeryAnesthesiaInstance.timeTemp2) {
        //            surgeryAnesthesiaInstance.errors.rejectValue('temperature1', 'Please answer question #24 regarding the temperature details')
        //            surgeryAnesthesiaInstance.errors.rejectValue('timeTemp1', '')
        //            surgeryAnesthesiaInstance.errors.rejectValue('temperature2', '')
        //            surgeryAnesthesiaInstance.errors.rejectValue('timeTemp2', '')
        //        } else {
        if(!surgeryAnesthesiaInstance.temperature1) {
            surgeryAnesthesiaInstance.errors.rejectValue('temperature1', null, 'Please enter the First temperature recorded for the participant')
        }
        if(!surgeryAnesthesiaInstance.timeTemp1) {
            surgeryAnesthesiaInstance.errors.rejectValue('timeTemp1', null, 'Please enter the Time when the First temperature was recorded for the participant')
        }
        if(!surgeryAnesthesiaInstance.temperature2) {
            surgeryAnesthesiaInstance.errors.rejectValue('temperature2', null, 'Please enter the Second temperature recorded for the participant')
        }
        if(!surgeryAnesthesiaInstance.timeTemp2) {
            surgeryAnesthesiaInstance.errors.rejectValue('timeTemp2', null, 'Please enter the Time when the Second temperature was recorded for the participant')
        }
        //        }

        //println 'CCC CO2 Level value=' + surgeryAnesthesiaInstance.co2LevelValue + ', Unit=' + surgeryAnesthesiaInstance.co2LevelUnit.toString() + ', Other Unit=\'' + surgeryAnesthesiaInstance.co2LevelUnitOther + '\''
        if(!surgeryAnesthesiaInstance.co2LevelValue) {
            surgeryAnesthesiaInstance.errors.rejectValue('co2LevelValue', null, 'Carbon Dioxide level (CO2) recorded at time closest to organ resection is required.')
        }
        else
        {
            if(!surgeryAnesthesiaInstance.co2LevelUnit) {
                surgeryAnesthesiaInstance.errors.rejectValue('co2LevelUnit', null, 'The Unit data for Carbon Dioxide level (CO2) is required.')
            }   
            else if(surgeryAnesthesiaInstance.co2LevelUnit.toString() == 'Other, Specify')
            {
                //println 'CCC CO2 trim()=\'' + surgeryAnesthesiaInstance.co2LevelUnitOther?.trim() + '\''
                if (!surgeryAnesthesiaInstance.co2LevelUnitOther || surgeryAnesthesiaInstance.co2LevelUnitOther.trim() == '') 
                {
                    surgeryAnesthesiaInstance.errors.rejectValue('co2LevelUnit', null, 'The Unit data for Carbon Dioxide level (CO2) is not completely specified yet.')
                }
                else 
                {
                    surgeryAnesthesiaInstance.co2LevelUnitOther = surgeryAnesthesiaInstance.co2LevelUnitOther.trim()
                    //println 'CCC CO2 final value=\'' + surgeryAnesthesiaInstance.co2LevelUnitOther + '\''
                }
            }  
        }
        //if(!surgeryAnesthesiaInstance.co2Level) {
        //    surgeryAnesthesiaInstance.errors.rejectValue('co2Level', 'Carbon Dioxide level (CO2) recorded at time closest to organ resection is required')
        //}

       

        if(isPrimaryTissueTypeOvary) {
            if(surgeryAnesthesiaInstance.isPelvicWashColl.equals(null) || surgeryAnesthesiaInstance.isPelvicWashColl.equals("Undef")) {
                surgeryAnesthesiaInstance.errors.rejectValue('isPelvicWashColl',null,  'Pelvic Washings collection record is required.')
            } else {
                if(surgeryAnesthesiaInstance.isPelvicWashColl == 'Yes' && !surgeryAnesthesiaInstance.collPelvicWash) {
                    surgeryAnesthesiaInstance.errors.rejectValue('collPelvicWash', null, 'Please enter the volume of Pelvic Washings collected.')
                }
            }
        }

        if(!surgeryAnesthesiaInstance.specOrLeavingTime) {
            surgeryAnesthesiaInstance.errors.rejectValue('specOrLeavingTime', null, 'Time when the specimen left Operating Room is required.')
        }
        
        /*
        if(!surgeryAnesthesiaInstance.albuminCount) {
        surgeryAnesthesiaInstance.errors.rejectValue('albuminCount', null, 'Albumin Count is required.')
        }
        
        if(!surgeryAnesthesiaInstance.rbcCount) {
        surgeryAnesthesiaInstance.errors.rejectValue('rbcCount', null, 'Packed Red blood cells Count is required.')
        }
        
        if(!surgeryAnesthesiaInstance.plateletCount) {
        surgeryAnesthesiaInstance.errors.rejectValue('plateletCount', null, 'Platelet Count is required.')
        }
        
        if(!surgeryAnesthesiaInstance.frozPlasma) {
        surgeryAnesthesiaInstance.errors.rejectValue('frozPlasma', null, 'Frozen plasma Count is required.')
        }
        
        
        
        if(!surgeryAnesthesiaInstance.bloodLossb4OrganExc) {
        surgeryAnesthesiaInstance.errors.rejectValue('bloodLossb4OrganExc', null, ' Blood loss is required.')
        }
        
        if(!surgeryAnesthesiaInstance.bloodLossRecPt) {
        surgeryAnesthesiaInstance.errors.rejectValue('bloodLossRecPt', null, 'Enter when was blood loss recorded.')
        }
        
        if(!surgeryAnesthesiaInstance.urineVolb4Exc) {
        surgeryAnesthesiaInstance.errors.rejectValue('urineVolb4Exc', null, 'Enter Urine output Volume.')
        }
        
        if(!surgeryAnesthesiaInstance.urineVolRecPt) {
        surgeryAnesthesiaInstance.errors.rejectValue('urineVolRecPt', null, 'Enter when urine volume recorded.')
        }
        
        if(!surgeryAnesthesiaInstance.durFastingb4Surg) {
        surgeryAnesthesiaInstance.errors.rejectValue('durFastingb4Surg', null, 'Enter duriation of fasting before surgery.')
        }
         */
        
        
    }

    def setError(surgeryAnesthesiaInstance, name, value, message) {
        if(!value) {
            surgeryAnesthesiaInstance.errors.rejectValue(name, null, message)
        }
    }
}
