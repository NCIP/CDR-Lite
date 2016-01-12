package nci.bbrb.cdr.authservice

class CdrRole {

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
