package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.*
//import grails.plugins.springsecurity.Secured
//import grails.transaction.Transactional


//@Transactional(readOnly = true)
class TissueProcessEmbedController {


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    static String CDR_FORM_NAME = 'Tissue Processing-Embedding Form'
    
    def accessPrivilegeService    

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        [tissueProcessEmbedInstanceList: TissueProcessEmbed.list(params), tissueProcessEmbedInstanceTotal: TissueProcessEmbed.count()]
    }

    def create = {
        def tissueProcessEmbedInstance = new TissueProcessEmbed()
        tissueProcessEmbedInstance.properties = params
        //tissueProcessEmbedInstance.expKeyBarcodeId = tissueProcessEmbedInstance.caseRecord?.tissueReceiptsAndDissection?.experimentalKeyId

        return [tissueProcessEmbedInstance: tissueProcessEmbedInstance]
    }

    //@Transactional
    def save = {
        def tissueProcessEmbedInstance = new TissueProcessEmbed(params)
        
        // Populate SOP Record
        //def formMetadataInstance = FormMetadata.get(params.formMetadata.id)
        //def sopInstance
        //if (formMetadataInstance?.sops?.size() > 0) {
        //    sopInstance = SOP.get(formMetadataInstance?.sops?.get(0)?.id)
        //    tissueProcessEmbedInstance.processingSOP = new SOPRecord(sopId:sopInstance.id, sopNumber:sopInstance.sopNumber, sopVersion:sopInstance.activeSopVer).save(flush: true)
        //}
        //if (formMetadataInstance?.sops?.size() > 1) {
        //    sopInstance = SOP.get(formMetadataInstance?.sops?.get(1)?.id)
        //    tissueProcessEmbedInstance.embeddingSOP = new SOPRecord(sopId:sopInstance.id, sopNumber:sopInstance.sopNumber, sopVersion:sopInstance.activeSopVer).save(flush: true)
        //}
        
        if(tissueProcessEmbedInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance?.caseRecord?.caseId])}"
            redirect(action: "editWithValidation", id: tissueProcessEmbedInstance.id)
        } else {
            render(view: "create", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
        }
    }

    def show = {
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        if(!tissueProcessEmbedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
            redirect(action: "list")
        } else {
            
            if(!accessPrivilegeService.hasPrivilege(tissueProcessEmbedInstance?.caseRecord, session, 'view')){
                redirect(controller: "login", action: "denied")
                return
            }
            
//            if (!accessPrivilegeService.checkAccessPrivilege(tissueProcessEmbedInstance.caseRecord, session, 'view')) {
//                redirect(controller: "login", action: "denied")
//                return
//            }            
            def canResume = (accessPrivilegeService.hasPrivilege(tissueProcessEmbedInstance?.caseRecord, session, 'edit'))
            [tissueProcessEmbedInstance: tissueProcessEmbedInstance, canResume: canResume]
        }
    }

    def edit = {
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        if(!tissueProcessEmbedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(tissueProcessEmbedInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            if (tissueProcessEmbedInstance.submittedBy != null) {
                redirect(controller: "login", action: "denied")
                return
            }            
            validateFields(tissueProcessEmbedInstance)
            def canSubmit = !tissueProcessEmbedInstance.errors.hasErrors()
            tissueProcessEmbedInstance.clearErrors()
            return [tissueProcessEmbedInstance: tissueProcessEmbedInstance, canSubmit: canSubmit]
        }
    }

    def editWithValidation = {
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        if(!tissueProcessEmbedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(tissueProcessEmbedInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            if (tissueProcessEmbedInstance.submittedBy != null) {
                redirect(controller: "login", action: "denied")
                return
            }            
            validateFields(tissueProcessEmbedInstance)
            render(view: "edit", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance, canSubmit: !tissueProcessEmbedInstance.errors.hasErrors()])
            //return  [tissueProcessEmbedInstance: tissueProcessEmbedInstance, canSubmit: !tissueProcessEmbedInstance.errors.hasErrors()]
        }
    }

    //@Transactional
    def update = {
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        if(tissueProcessEmbedInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(tissueProcessEmbedInstance.version > version) {
                    tissueProcessEmbedInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [CDR_FORM_NAME] as Object[], "Another user has updated this TissueProcessEmbed while you were editing")
                    render(view: "edit", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
                    return
                }
            }

            tissueProcessEmbedInstance.properties = params
            if(!tissueProcessEmbedInstance.hasErrors() && tissueProcessEmbedInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
                redirect(action: "editWithValidation", id: tissueProcessEmbedInstance.id)
            } else {
                render(view: "edit", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
            redirect(action: "list")
        }
    }

    def submit = {
        
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        if(tissueProcessEmbedInstance) {
            
            if(params.version) {
                def version = params.version.toLong()
                if(tissueProcessEmbedInstance.version > version) {
                    tissueProcessEmbedInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [CDR_FORM_NAME + ' for Case'] as Object[], "Another user has updated this TissueProcessEmbed while you were editing")
                    render(view: "edit", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
                    return
                }
            }
            tissueProcessEmbedInstance.properties = params
            validateFields(tissueProcessEmbedInstance)
            
            if(!tissueProcessEmbedInstance.hasErrors()) {
                tissueProcessEmbedInstance.dateSubmitted = new Date()
                tissueProcessEmbedInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
                if (tissueProcessEmbedInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.submitted.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
                    redirect(controller: "caseRecord", action: "show", id: tissueProcessEmbedInstance.caseRecord.id)
                }
                else 
                {
                    tissueProcessEmbedInstance.discard()
                    render(view: "edit", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
                }
                
            } else {
                tissueProcessEmbedInstance.discard()
                render(view: "edit", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
            redirect(action: "list")
        }
    }

    //@Secured(['ROLE_ADMIN']) 
    //@Transactional
    def delete = {
        
        if ( (session.DM == true) && (session.org?.code?.equals('DCC'))) {}
        else {
             redirect(controller: "login", action: "denied")
             return
        }
        
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        if(tissueProcessEmbedInstance) {
            try {
                tissueProcessEmbedInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
                redirect(action: "list")
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
                redirect(action: "show", id: params.id)
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [CDR_FORM_NAME + ' for Case', tissueProcessEmbedInstance.caseRecord.caseId])}"
            redirect(action: "list")
        }
    }

    def resumeEditing = {
        def tissueProcessEmbedInstance = TissueProcessEmbed.get(params.id)
        tissueProcessEmbedInstance.dateSubmitted = null
        tissueProcessEmbedInstance.submittedBy = null

        if(tissueProcessEmbedInstance.save(flush: true)) {
            redirect(action: "edit", id: tissueProcessEmbedInstance.id)
        } else {
            render(view: "show", model: [tissueProcessEmbedInstance: tissueProcessEmbedInstance])
        }
    }

    def validateFields(tissueProcessEmbedInstance) {
        //if(!tissueProcessEmbedInstance.expKeyBarcodeId) {
        //    tissueProcessEmbedInstance.errors.rejectValue('expKeyBarcodeId', 'Question #1 cannot be blank')
        //}
        int n = 1

        n++ // #2
        if(!tissueProcessEmbedInstance.tissProcessorMdl) {
            tissueProcessEmbedInstance.errors.rejectValue('tissProcessorMdl', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.tissProcessorMdl == 'Other, Specify' && !tissueProcessEmbedInstance.othTissProcessorMdl) {
            tissueProcessEmbedInstance.errors.rejectValue('othTissProcessorMdl', null, 'Please specify other for question #'+n+'.')
        }

        n++ // #3
        if(!tissueProcessEmbedInstance.procMaintenance) {
            tissueProcessEmbedInstance.errors.rejectValue('procMaintenance', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.procMaintenance == 'No - Specify' && !tissueProcessEmbedInstance.othProcMaintenance) {
            tissueProcessEmbedInstance.errors.rejectValue('othProcMaintenance', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #4
        if(!tissueProcessEmbedInstance.alcoholType) {
            tissueProcessEmbedInstance.errors.rejectValue('alcoholType', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.alcoholType == 'Other, Specify' && !tissueProcessEmbedInstance.othAlcoholType) {
            tissueProcessEmbedInstance.errors.rejectValue('othAlcoholType', null, 'Please specify other for question #'+n+'.')
        }

        n++ // #5
        if(!tissueProcessEmbedInstance.clearingAgt) {
            tissueProcessEmbedInstance.errors.rejectValue('clearingAgt', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.clearingAgt == 'Other, Specify' && !tissueProcessEmbedInstance.othClearingAgt) {
            tissueProcessEmbedInstance.errors.rejectValue('othClearingAgt', null, 'Please specify other for question #'+n+'.')
        }

        n++ // #6
        if(!tissueProcessEmbedInstance.alcoholStgDur) {
            tissueProcessEmbedInstance.errors.rejectValue('alcoholStgDur', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.alcoholStgDur == 'No - Specify' && !tissueProcessEmbedInstance.othAlcoholStgDur) {
            tissueProcessEmbedInstance.errors.rejectValue('othAlcoholStgDur', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #7
        if(!tissueProcessEmbedInstance.dehydrationProcDur) {
            tissueProcessEmbedInstance.errors.rejectValue('dehydrationProcDur', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.dehydrationProcDur == 'No - Specify' && !tissueProcessEmbedInstance.othDehydrationProcDur) {
            tissueProcessEmbedInstance.errors.rejectValue('othDehydrationProcDur', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #8
        if(!tissueProcessEmbedInstance.temperatureDehyd) {
            tissueProcessEmbedInstance.errors.rejectValue('temperatureDehyd', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.temperatureDehyd == 'No - Specify' && !tissueProcessEmbedInstance.othTemperatureDehyd) {
            tissueProcessEmbedInstance.errors.rejectValue('othTemperatureDehyd', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #9
        if(!tissueProcessEmbedInstance.numStages) {
            tissueProcessEmbedInstance.errors.rejectValue('numStages', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.numStages == 'No - Specify' && !tissueProcessEmbedInstance.othNumStages) {
            tissueProcessEmbedInstance.errors.rejectValue('othNumStages', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #10
        if(!tissueProcessEmbedInstance.clearingAgtDur) {
            tissueProcessEmbedInstance.errors.rejectValue('clearingAgtDur', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.clearingAgtDur == 'No - Specify' && !tissueProcessEmbedInstance.othClearingAgtDur) {
            tissueProcessEmbedInstance.errors.rejectValue('othClearingAgtDur', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #11
        if(!tissueProcessEmbedInstance.temperatureClearingAgt) {
            tissueProcessEmbedInstance.errors.rejectValue('temperatureClearingAgt', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.temperatureClearingAgt == 'No - Specify' && !tissueProcessEmbedInstance.othTemperatureClearingAgt) {
            tissueProcessEmbedInstance.errors.rejectValue('othTemperatureClearingAgt', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #12
        if(!tissueProcessEmbedInstance.paraffImpreg) {
            tissueProcessEmbedInstance.errors.rejectValue('paraffImpreg', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.paraffImpreg == 'No - Specify' && !tissueProcessEmbedInstance.othParaffImpreg) {
            tissueProcessEmbedInstance.errors.rejectValue('othParaffImpreg', null, 'Please specify the reason for question #'+n+'.')
        }

        n++ // #13
        if(!tissueProcessEmbedInstance.tempParaffinProc) {
            tissueProcessEmbedInstance.errors.rejectValue('tempParaffinProc', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.tempParaffinProc == 'No - Specify' && !tissueProcessEmbedInstance.othTempParaffinProc) {
            tissueProcessEmbedInstance.errors.rejectValue('othTempParaffinProc', null, 'Please specify the reason for question #'+n+'.')
        }

        n = n + 3  // #16
        if(!tissueProcessEmbedInstance.typeParaffin) {
            tissueProcessEmbedInstance.errors.rejectValue('typeParaffin', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #17
        if(!tissueProcessEmbedInstance.paraffinManufacturer) {
            tissueProcessEmbedInstance.errors.rejectValue('paraffinManufacturer', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.paraffinManufacturer == 'Other, Specify' && !tissueProcessEmbedInstance.otherParaffinManufacturer) {
            tissueProcessEmbedInstance.errors.rejectValue('otherParaffinManufacturer', null, 'Please specify other for question #'+n+'.')
        }

        n++ // #18
        if(!tissueProcessEmbedInstance.paraffinProductNum) {
            tissueProcessEmbedInstance.errors.rejectValue('paraffinProductNum', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #19
        if(!tissueProcessEmbedInstance.paraffinLotNum) {
            tissueProcessEmbedInstance.errors.rejectValue('paraffinLotNum', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #20
        if(!tissueProcessEmbedInstance.tempParaffinEmbed) {
            tissueProcessEmbedInstance.errors.rejectValue('tempParaffinEmbed', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #21
        if(!tissueProcessEmbedInstance.paraffinUsage) {
            tissueProcessEmbedInstance.errors.rejectValue('paraffinUsage', null, 'Please select an option for question #'+n+'.')
        } else if(tissueProcessEmbedInstance.paraffinUsage == 'Other, Specify' && !tissueProcessEmbedInstance.otherParaffinUsage) {
            tissueProcessEmbedInstance.errors.rejectValue('otherParaffinUsage', null, 'Please specify other for question #'+n+'.')
        }

        n++ // #22
        if(!tissueProcessEmbedInstance.waxAge) {
            tissueProcessEmbedInstance.errors.rejectValue('waxAge', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #23
        if(!tissueProcessEmbedInstance.totalTimeBlocksCooled) {
            tissueProcessEmbedInstance.errors.rejectValue('totalTimeBlocksCooled', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #24
        if(!tissueProcessEmbedInstance.siteSOPProcEmbed) {
            tissueProcessEmbedInstance.errors.rejectValue('siteSOPProcEmbed', null, 'Question #'+n+' cannot be blank.')
        }

        n++ // #25
        if(tissueProcessEmbedInstance.storedFfpeBlocksPerSop == 'No - Specify' && !tissueProcessEmbedInstance.othStoredFfpeBlocksPerSop) {
            tissueProcessEmbedInstance.errors.rejectValue('othStoredFfpeBlocksPerSop', null, 'Please specify the reason for question #'+n+'.')
        }
    }    
    
}
