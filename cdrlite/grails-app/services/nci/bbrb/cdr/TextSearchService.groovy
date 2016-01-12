package nci.bbrb.cdr

import grails.transaction.Transactional
import nci.bbrb.cdr.datarecords.CaseRecord

@Transactional
class TextSearchService {

     def index_all = {
        Thread.start {
          
            log.info((new Date()).toString() + " started index CaseRecord")
            println("start index....")
            CaseRecord.index()
             println("end index....")
            log.info((new Date()).toString() + " End index CaseRecord")
       
          
        }
       
    }

    
    
}
