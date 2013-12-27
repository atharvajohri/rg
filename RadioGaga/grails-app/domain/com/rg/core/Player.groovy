package com.rg.core

import com.rg.auth.SecUser

class Player {

	String uuid
	Date dateCreated
	SecUser openedBy
	Boolean current = false
	
    static constraints = {
		uuid nullable:true
    }
}
