package nci.bbrb.cdr.staticmembers

class QueryType extends StaticMemberBaseClass {

    static mapping = {
        table 'st_query_type'
        id generator:'sequence', params:[sequence:'st_query_type_pk']
    }
    
    static searchable = {
        only = ['name', 'code']
        'name' name:'qtTypeName'
        'code' name:'qtTypeCode'
        root false
    }
}
