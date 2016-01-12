/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.CandidateRecord

/**
 *
 * @author mareedus
 */
class ScreeningEnrollment extends DataRecordBaseClass{
	
    CandidateRecord candidateRecord
    Date screeningDate
    String nameCreateCandidate
    String metCriteria
    String comments
    Date dateSubmitted
    String submittedBy
        
    static constraints = {
        candidateRecord(blank:false, nullable:false)
        nameCreateCandidate(blank:true, nullable:true)
        metCriteria(blank:true, nullable:true)
        comments(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        screeningDate(blank:true, nullable:true)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
    }
        static mapping = {
        table 'form_screening_enrollment'
        id generator:'sequence', params:[sequence:'form_screening_enrollment_pk']
    }
}

