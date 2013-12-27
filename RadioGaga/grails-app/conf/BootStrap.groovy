import com.rg.auth.SecRole
import com.rg.auth.SecUser
import com.rg.auth.SecUserSecRole

class BootStrap {

    def init = { servletContext ->
		def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER').save(failOnError: true)
		def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
		
		def adminUser = SecUser.findByUsername("admin")
		if (!adminUser){
			adminUser = new SecUser(username:"admin", password:"iamanadmin", isSupervisor:true).save(failOnError: true)
			SecUserSecRole.create adminUser, SecRole.findByAuthority('ROLE_ADMIN')
			log.info "created admin"
		}
		
		def adminUser2 = SecUser.findByUsername("admin2")
		if (!adminUser2){
			adminUser2 = new SecUser(username:"admin2", password:"iamanadmintoo", isSupervisor:true).save(failOnError: true)
			SecUserSecRole.create adminUser2, SecRole.findByAuthority('ROLE_ADMIN')
			log.info "created admin2"
		}
    }
    def destroy = {
    }
}
