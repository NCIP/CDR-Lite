package nci.bbrb.cdr.authservice

import org.apache.commons.lang.builder.HashCodeBuilder

class CdrUserRole implements Serializable {

	private static final long serialVersionUID = 1

	CdrUser cdrUser
	CdrRole cdrRole

	boolean equals(other) {
		if (!(other instanceof CdrUserRole)) {
			return false
		}

		other.cdrUser?.id == cdrUser?.id &&
		other.cdrRole?.id == cdrRole?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (cdrUser) builder.append(cdrUser.id)
		if (cdrRole) builder.append(cdrRole.id)
		builder.toHashCode()
	}

	static CdrUserRole get(long cdrUserId, long cdrRoleId) {
		CdrUserRole.where {
			cdrUser == CdrUser.load(cdrUserId) &&
			cdrRole == CdrRole.load(cdrRoleId)
		}.get()
	}

	static boolean exists(long cdrUserId, long cdrRoleId) {
		CdrUserRole.where {
			cdrUser == CdrUser.load(cdrUserId) &&
			cdrRole == CdrRole.load(cdrRoleId)
		}.count() > 0
	}

	static CdrUserRole create(CdrUser cdrUser, CdrRole cdrRole, boolean flush = false) {
		//def instance = new CdrUserRole(cdrUser: cdrUser, cdrRole: cdrRole)
		//instance.save(flush: flush, insert: true)
		//instance
                new CdrUserRole(cdrUser: cdrUser, cdrRole: cdrRole).save(flush: flush, insert: true)
	}

	static boolean remove(CdrUser u, CdrRole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = CdrUserRole.where {
			cdrUser == CdrUser.load(u.id) &&
			cdrRole == CdrRole.load(r.id)
		}.deleteAll()

		if (flush) { CdrUserRole.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(CdrUser u, boolean flush = false) {
		if (u == null) return

		CdrUserRole.where {
			cdrUser == CdrUser.load(u.id)
		}.deleteAll()

		if (flush) { CdrUserRole.withSession { it.flush() } }
	}

	static void removeAll(CdrRole r, boolean flush = false) {
		if (r == null) return

		CdrUserRole.where {
			cdrRole == CdrRole.load(r.id)
		}.deleteAll()

		if (flush) { CdrUserRole.withSession { it.flush() } }
	}

	static constraints = {
		cdrRole validator: { CdrRole r, CdrUserRole ur ->
			if (ur.cdrUser == null) return
			boolean existing = false
			CdrUserRole.withNewSession {
				existing = CdrUserRole.exists(ur.cdrUser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['cdrRole', 'cdrUser']
		version false
	}
}
