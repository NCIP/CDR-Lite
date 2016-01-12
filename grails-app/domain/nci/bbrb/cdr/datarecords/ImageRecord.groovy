package nci.bbrb.cdr.datarecords

class ImageRecord extends DataRecordBaseClass{

    SlideRecord slideRecord
    String imageId
    static constraints = {
    }
    
    
     static mapping = {
      table 'dr_image'
      id generator:'sequence', params:[sequence:'dr_image_pk']
    }
}
