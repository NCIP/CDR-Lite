package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import org.grails.databinding.BindingFormat

import nci.bbrb.cdr.datarecords.*

class ClinicalDataEntry  extends DataRecordBaseClass {

    CaseRecord caseRecord
    Date dateSubmitted
    String submittedBy

    String prevMalignancy
    
    @BindingFormat('MM/dd/yyyy')
    Date prevCancerDiagDt
    Double prevCancerDiagEst
    String bloodRelCancer1
    String bloodRelCancer2
    String bloodRelCancer3
    String bloodRelCancer4
    String bloodRelCancer5
    String bloodRelCancer6
    String bloodRelCancer7
    String bloodRelCancer8
    String bloodRelCancer9
    String bloodRelCancer10
    String bloodRelCancer11
    String bloodRelCancer12
    String bloodRelCancer13
    String othBloodRelCancer
    String bloodRelCancer14 // for "None" 
    
    String relCancerType1
    String relCancerType2
    String relCancerType3
    String relCancerType4
    String relCancerType5
    String relCancerType6
    String relCancerType7
    String relCancerType8
    String relCancerType9
    String relCancerType10
    String relCancerType11
    String relCancerType12
    String relCancerType13    
    
    String isImmunoSupp
    String immunoSuppStatus1
    String immunoSuppStatus2
    String immunoSuppStatus3
    String immunoSuppStatus4    
    String otherImmunoSuppStatus

    String irradTherb4Surg
    String irradTherb4SurgDesc
    
    @BindingFormat('MM/dd/yyyy')
    Date irradTherb4SurgDt
    Double irradTherb4SurgEst

    String chemoTherb4Surg
    String chemoTherb4SurgDesc
    
    @BindingFormat('MM/dd/yyyy')
    Date chemoTherb4SurgDt
    Double chemoTherb4SurgEst

    String immTherb4Surg
    String immTherb4SurgDesc
    
    @BindingFormat('MM/dd/yyyy')
    Date immTherb4SurgDt
    Double immTherb4SurgEst
    String hormTherb4Surg
    String hormTherb4SurgDesc
    
    @BindingFormat('MM/dd/yyyy')
    Date hormTherb4SurgDt
    Double hormTherb4SurgEst

    String isAddtlColoRisk
    String addtlColoRisk1
    String addtlColoRisk2
    String addtlColoRisk3
    String addtlColoRisk4
    String addtlColoRisk5        
    String addtlColoRisk6
    String otherAddColRisk    
    
    String isEnvCarc
    String envCarc1
    String envCarc2
    String envCarc3
    String envCarc4
    String envCarc5    
    String envCarcExpDesc
    
    String hepB
    String hepC
    String hiv
    String scrAssay
    String otherInfect
    String wasPregnant
    String totPregnancies
    String totLiveBirths
    String ageAt1stChild
    String gynSurg
    String hormBirthControl
    String formHorBirthControl
    Double hormBCDur
    Double hormBCLast
    String othHorBC  //  as 'General Comment' of hormon birth control
    String usedHorReplaceTher
    String formHorReplaceTher
    String typeHorReplaceTher
    Double hormRTDur
    Double hormRTLast
    String othHorRT  //  as 'General Comment' of hormon replacement therapy
    String othFormHRT
    String othFormHBC
    String menoStatus
    String clinicalFIGOStg
    String clinicalTumStgGrp
    String perfStatusScale
    String karnofskyScore
    String ecogStatus
    String timingOfScore
    String timingOfScoreOs   
    String comments
    
    static belongsTo = [caseRecord: CaseRecord]
    
    String toString(){"$caseRecord.caseId"}
    
    static hasMany = [therapyRecords:TherapyRecord]


    static constraints = {
        caseRecord(blank:false, nullable:false)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
        prevMalignancy(blank:true, nullable:true)
        prevCancerDiagDt(blank:true, nullable:true)
        prevCancerDiagEst(blank:true, nullable:true)
        bloodRelCancer1(blank:true, nullable:true)
        bloodRelCancer2(blank:true, nullable:true)
        bloodRelCancer3(blank:true, nullable:true)
        bloodRelCancer4(blank:true, nullable:true)
        bloodRelCancer5(blank:true, nullable:true)
        bloodRelCancer6(blank:true, nullable:true)
        bloodRelCancer7(blank:true, nullable:true)
        bloodRelCancer8(blank:true, nullable:true)
        bloodRelCancer9(blank:true, nullable:true)
        bloodRelCancer10(blank:true, nullable:true)
        bloodRelCancer11(blank:true, nullable:true)
        bloodRelCancer12(blank:true, nullable:true)
        bloodRelCancer13(blank:true, nullable:true)
        othBloodRelCancer(blank:true, nullable:true)
        bloodRelCancer14(blank:true, nullable:true)

        relCancerType1(blank:true, nullable:true)
        relCancerType2(blank:true, nullable:true)
        relCancerType3(blank:true, nullable:true)
        relCancerType4(blank:true, nullable:true)
        relCancerType5(blank:true, nullable:true)
        relCancerType6(blank:true, nullable:true)
        relCancerType7(blank:true, nullable:true)
        relCancerType8(blank:true, nullable:true)
        relCancerType9(blank:true, nullable:true)
        relCancerType10(blank:true, nullable:true)
        relCancerType11(blank:true, nullable:true)
        relCancerType12(blank:true, nullable:true)
        relCancerType13(blank:true, nullable:true)   
        isImmunoSupp(blank:true, nullable:true)    
        immunoSuppStatus1(blank:true, nullable:true)
        immunoSuppStatus2(blank:true, nullable:true)
        immunoSuppStatus3(blank:true, nullable:true)
        immunoSuppStatus4(blank:true, nullable:true)
        otherImmunoSuppStatus(blank:true, nullable:true)
        irradTherb4Surg(blank:true, nullable:true)
        irradTherb4SurgDesc(blank:true, nullable:true)
        irradTherb4SurgDt(blank:true, nullable:true)
        irradTherb4SurgEst(blank:true, nullable:true)
        chemoTherb4Surg(blank:true, nullable:true)
        chemoTherb4SurgDesc(blank:true, nullable:true)
        chemoTherb4SurgDt(blank:true, nullable:true)
        chemoTherb4SurgEst(blank:true, nullable:true)
        immTherb4Surg(blank:true, nullable:true)
        immTherb4SurgDesc(blank:true, nullable:true)
        immTherb4SurgDt(blank:true, nullable:true)
        immTherb4SurgEst(blank:true, nullable:true)
        hormTherb4Surg(blank:true, nullable:true)
        hormTherb4SurgDesc(blank:true, nullable:true)
        hormTherb4SurgDt(blank:true, nullable:true)
        hormTherb4SurgEst(blank:true, nullable:true)
        wasPregnant(blank:true, nullable:true)
        totPregnancies(blank:true, nullable:true)
        totLiveBirths(blank:true, nullable:true)
        ageAt1stChild(blank:true, nullable:true)
        gynSurg(blank:true, nullable:true)
        hepB(blank:true, nullable:true)
        hepC(blank:true, nullable:true)
        hiv(blank:true, nullable:true)
        otherInfect(blank:true, nullable:true)
        scrAssay(blank:true, nullable:true)
        hormBirthControl(blank:true, nullable:true)
        formHorBirthControl(blank:true, nullable:true)
        hormBCDur(blank:true, nullable:true)
        hormBCLast(blank:true, nullable:true)
        othHorBC(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        usedHorReplaceTher(blank:true, nullable:true)
        formHorReplaceTher(blank:true, nullable:true)
        typeHorReplaceTher(blank:true, nullable:true)
        hormRTDur(blank:true, nullable:true)
        hormRTLast(blank:true, nullable:true)
        othHorRT(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        menoStatus(blank:true, nullable:true)
        
        isEnvCarc(blank:true, nullable:true)
        envCarc1(blank:true, nullable:true)
        envCarc2(blank:true, nullable:true)
        envCarc3(blank:true, nullable:true)
        envCarc4(blank:true, nullable:true)
        envCarc5(blank:true, nullable:true)    
        envCarcExpDesc(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        
        isAddtlColoRisk(blank:true, nullable:true)
        addtlColoRisk1(blank:true, nullable:true)
        addtlColoRisk2(blank:true, nullable:true)
        addtlColoRisk3(blank:true, nullable:true)
        addtlColoRisk4(blank:true, nullable:true)
        addtlColoRisk5(blank:true, nullable:true)        
        addtlColoRisk6(blank:true, nullable:true)
        otherAddColRisk(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        othFormHRT(blank:true, nullable:true)
        othFormHBC(blank:true, nullable:true)
        clinicalFIGOStg(blank:true, nullable:true)
        clinicalTumStgGrp(blank:true, nullable:true)
        perfStatusScale(blank:true, nullable:true)
        karnofskyScore(blank:true, nullable:true)
        ecogStatus(blank:true, nullable:true)
        timingOfScore(blank:true, nullable:true)
        timingOfScoreOs(blank:true, nullable:true)
        comments(blank:true, nullable:true, widget:'textarea', maxSize:4000)
    }
    
    static mapping = {
        table 'form_clinical_data_entry'
        id generator:'sequence', params:[sequence:'form_clinical_data_entry_pk']
        therapyRecords sort:"id" 
    }
}
