package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.*

class TherapyRecord extends DataRecordBaseClass {

  //String therapyId
    String typeOfTherapy
    String descTherapy
    Date therapyDate
    Double howLongAgo
    HBCForm hbcForm
    String specOtherHBCForm
    Double durationMonths
    Double noOfYearsStopped
    HRTForm hrtForm
    String specOtherHRTForm
    HRTType hrtType
    ClinicalDataEntry clinicalDataEntry

    static belongsTo = [clinicalDataEntry:ClinicalDataEntry]
    
    static constraints = {
      //therapyId(blank:true,nullable:true)
        typeOfTherapy(blank:true,nullable:true)
        descTherapy(blank:true,nullable:true, widget:'textarea',maxSize:4000)
        therapyDate(blank:true,nullable:true)
        howLongAgo(nullable:true, blank:true)
        hbcForm(nullable:true, blank:true)
        specOtherHBCForm(blank:true,nullable:true)
        durationMonths(nullable:true, blank:true)
        noOfYearsStopped(nullable:true, blank:true)        
        hrtForm(nullable:true, blank:true)
        specOtherHRTForm(blank:true,nullable:true)
        hrtType(nullable:true, blank:true)
        clinicalDataEntry(blank:true,nullable:true)
    }
    
    enum HBCForm {
        Pill("Pill"),
        Injection("Injection"),
        IUD("IUD"),
        Patch("Patch"),
        VaginalRing("Vaginal ring"),
        OTH("Other, Specify")

        final String value;

        HBCForm(String value) {
            this.value = value;
        }

        String toString() {
            value;
        }

        String getKey() {
            name()
        }

        static list() {
            [Pill,Injection,IUD,Patch,VaginalRing,OTH]
        }
    }
    
    enum HRTForm {
        Pill("Pill"),
        Patch("Patch"),
        Cream("Cream"),
        Unknown("Unknown"),
        OTH("Other, Specify")

        final String value;

        HRTForm(String value) {
            this.value = value;
        }

        String toString() {
            value;
        }

        String getKey() {
            name()
        }

        static list() {
            [Pill,Patch,Cream,Unknown,OTH]
        }
    }

    enum HRTType {
        Estrogen("Estrogen alone"),
        EstroProge("Estrogen with progestin"),
        Progestin("Progestin alone"),
        Testosterone("Testosterone"),
        Unknown("Unknown")

        final String value;

        HRTType(String value) {
            this.value = value;
        }

        String toString() {
            value;
        }

        String getKey() {
            name()
        }

        static list() {
            [Estrogen,EstroProge,Progestin,Testosterone,Unknown]
        }
    }    

    static mapping = {
        table 'form_therapy'
        id generator:'sequence', params:[sequence:'form_therapy_pk']
    } 
}
