package nci.bbrb.cdr

import grails.transaction.Transactional
import nci.bbrb.cdr.util.CaseStatus

@Transactional
class CaseStatusService {

   def getStatus(caseRecordInstance) {
        def caseStatus = new CaseStatus()
        
        if (!caseRecordInstance.blood) {
            caseStatus.blood = 1
        } else if (!caseRecordInstance.blood.dateSubmitted) {
            caseStatus.blood = 2
        } else {
            caseStatus.blood = 3
        }
        
        
        if (!caseRecordInstance.surgeryAnesthesia) {
            caseStatus.surgeryAnesthesia = 1
        } else if (!caseRecordInstance.surgeryAnesthesia.dateSubmitted) {
            caseStatus.surgeryAnesthesia = 2
        } else {
            caseStatus.surgeryAnesthesia = 3
        }
        
		
	if (!caseRecordInstance.tissueReceiptsAndDissection) {
            caseStatus.tissueReceiptDissection = 1
        } else if (!caseRecordInstance.tissueReceiptsAndDissection.dateSubmitted) {
            caseStatus.tissueReceiptDissection = 2
        } else {
            caseStatus.tissueReceiptDissection = 3
        }
        if (!caseRecordInstance.tissueProcessEmbed) {
            caseStatus.tissueProcessEmbed = 1
        } else if (!caseRecordInstance.tissueProcessEmbed.dateSubmitted) {
            caseStatus.tissueProcessEmbed = 2
        } else {
            caseStatus.tissueProcessEmbed = 3
        }
        if (caseRecordInstance.specimens.size() == 0) {
            caseStatus.specimenPreservation = 1
        } else if (caseRecordInstance?.caseStatus?.code == 'INIT' || caseRecordInstance?.caseStatus?.code == 'COLL' || caseRecordInstance?.caseStatus?.code == 'DATA'  || caseRecordInstance?.caseStatus?.code == 'REMED') {
            caseStatus.specimenPreservation = 1
            caseRecordInstance.specimens.each() {
                if (it.tissueType.code != "BLOOD"){
                    caseStatus.specimenPreservation = 2
                }
            }
        } else {
            caseStatus.specimenPreservation = 3
        }
        if (!caseRecordInstance.slideSection) {
            caseStatus.slideSection = 1
        } else if (!caseRecordInstance.slideSection.dateSubmitted) {
            caseStatus.slideSection = 2
        } else {
            caseStatus.slideSection = 3
        }
         if (!caseRecordInstance.clinicalDataEntry) {
            caseStatus.clinicalDataEntry = 1
        } else if (!caseRecordInstance.clinicalDataEntry.dateSubmitted) {
            caseStatus.clinicalDataEntry = 2
        } else {
            caseStatus.clinicalDataEntry = 3
        }
       
      
        if (!caseRecordInstance.tissueGrossEvaluation) {
            caseStatus.tissueGrossEvaluation = 1
        } else if (!caseRecordInstance.tissueGrossEvaluation.dateSubmitted) {
            caseStatus.tissueGrossEvaluation = 2
        } else {
            caseStatus.tissueGrossEvaluation = 3
        }
        
        if (!caseRecordInstance.slidePrep) {
            caseStatus.slidePrep = 1
        } else if (!caseRecordInstance.slidePrep.dateSubmitted) {
            caseStatus.slidePrep = 2
        } else {
            caseStatus.slidePrep = 3
        }
        
        
        
        return caseStatus
    }
    
}
