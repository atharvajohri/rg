package com.rg.core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class TrackController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def trackService
	def springSecurityService
	
    def index = {
        redirect(action: "list", params: params)
    }
	
	
	def player = {
		[allowRecommend: springSecurityService.getCurrentUser().username == "admin2" ? true : false ]
	}
	
	def searchTracks = {
		def parameter = params.search_parameter
		log.info "parameter is $parameter"
		def trackResults = []
		if (parameter){
			trackResults.addAll(Track.findAllByTitleIlike("%${parameter}%"))
			trackResults.addAll(Track.findAllByArtistIlike("%${parameter}%"))
			trackResults.addAll(Track.findAllByAlbumIlike("%${parameter}%"))
			trackResults.addAll(Track.findAllByLinkIlike("%${parameter}%"))
		}else{
			trackResults = Track.list()
		}
		
		render(template:"trackListTemplate",model:[trackList:trackResults])
	}
	
	def instantiatePlayer(){
		def player = Player.findByCurrent(true)
		if (player)
			player.delete()
		player = new Player(current: true, openedBy: springSecurityService.getCurrentUser())
		def response = [:]
		if (player.save()){
			response.success = true
			log.info "Player opened."
		}
		else{
			response.success = false
			log.info "Player could not be opened:"
			player.errors.each {println it}
		}
		
		render response as JSON
	}
	
	def returnTrackList = {
		render(template:"trackListTemplate",model:[trackList:Track.list()])
	}
	
	def portfolio = {
		
	}
	
	def gt = {
		if (params.id){
			def track = Track.get(Long.parseLong(params.id.toString()));
			log.info "Returning $track.title for ${request.getRemoteAddr()}"
			render track as JSON
		}else{
			render "not found"
		}
	}
	
	def nt = {
		def initTracks = Arrays.asList(params.listenedTracks.toString().split("\\s*,\\s*"))
		def listenedTracks = []
		initTracks.each { t ->
			listenedTracks.push(Long.parseLong(t))
		}
		
		def track = trackService.getNextTrack(listenedTracks, params.rnd);
		if (track){
			log.info "Playing $track.title by $track.artist for ${request.getRemoteAddr()}"
			render track as JSON
		}else{
			render "reset"
		}
	}
	

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [trackInstanceList: Track.list(params), trackInstanceTotal: Track.count()]
    }

    def create = {
        def trackInstance = new Track()
        trackInstance.properties = params
        return [trackInstance: trackInstance]
    }

    def save = {
        def trackInstance = new Track(params)
        if (trackInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'track.label', default: 'Track'), trackInstance.id])}"
            redirect(action: "show", id: trackInstance.id)
        }
        else {
            render(view: "create", model: [trackInstance: trackInstance])
        }
    }

    def show = {
        def trackInstance = Track.get(params.id)
        if (!trackInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'track.label', default: 'Track'), params.id])}"
            redirect(action: "list")
        }
        else {
            [trackInstance: trackInstance]
        }
    }

    def edit = {
        def trackInstance = Track.get(params.id)
        if (!trackInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'track.label', default: 'Track'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [trackInstance: trackInstance]
        }
    }

    def update = {
        def trackInstance = Track.get(params.id)
        if (trackInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (trackInstance.version > version) {
                    
                    trackInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'track.label', default: 'Track')] as Object[], "Another user has updated this Track while you were editing")
                    render(view: "edit", model: [trackInstance: trackInstance])
                    return
                }
            }
            trackInstance.properties = params
            if (!trackInstance.hasErrors() && trackInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'track.label', default: 'Track'), trackInstance.id])}"
                redirect(action: "show", id: trackInstance.id)
            }
            else {
                render(view: "edit", model: [trackInstance: trackInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'track.label', default: 'Track'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def trackInstance = Track.get(params.id)
        if (trackInstance) {
            try {
                trackInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'track.label', default: 'Track'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'track.label', default: 'Track'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'track.label', default: 'Track'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def length = {
		render params.string.size()	
    }
}
