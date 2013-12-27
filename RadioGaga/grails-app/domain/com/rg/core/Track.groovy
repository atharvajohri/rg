package com.rg.core

import com.rg.auth.SecUser

class Track {

	//attributes
	String link
	String title
	String artist
	String album
	String length
	String details
	String genre
	String type
	String suggestions
	String fromSite
	Date dateCreated
	Boolean active = true
	Boolean recommended = false
	String artwork
	Long likes
	//links
//	static belongsTo = [addedBy: SecUser]

	static mapping = {
		sort 'id'
	}
		
	//constraints
    static constraints = {
//		addedBy nullable:true
		type nullable:true
		link url:true, unique:true
		length nullable:true
		details nullable:true
		suggestions nullable:true
		genre nullable:true
		fromSite nullable:true
		artwork nullable:true
		likes nullable:true
    }
}
