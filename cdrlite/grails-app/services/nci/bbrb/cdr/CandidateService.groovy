package nci.bbrb.cdr

import grails.transaction.Transactional

@Transactional
class CandidateService {

    def updateCandidate(candidateRecord) {
        candidateRecord.save(failOnError:true)
        def bss=candidateRecord.bss
        def caseList=candidateRecord.caseList
        caseList.each(){
            it.bss=bss
            it.save(failOnError:true)
        }

    }
}
