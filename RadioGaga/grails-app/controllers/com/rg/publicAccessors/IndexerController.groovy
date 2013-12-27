package com.rg.publicAccessors

import grails.converters.JSON
import com.rg.core.Track

class IndexerController {

    def indexer = {
		log.info " logging $params"
        def existing = Track.findByTitle(params.title)
        def responseMap = [:]
        if (!existing){
            def track = new Track(params)
            if (track.validate()){
                track.save(flush:true)
                log.info "Saved new track $track"
                responseMap.success = "true"
            }else{
                log.info "Could not save new track.."
                track.errors.each {log.info it}
                responseMap.success = "false"
                responseMap.errors = track.errors
            }
                
        }else{
            responseMap.success = "false"
            responseMap.errors = "exists"
        }
        render responseMap as JSON
	}
}
