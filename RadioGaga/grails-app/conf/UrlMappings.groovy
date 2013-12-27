class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		//custom
		"/player" (controller:"track", action:"player")
		"/getTracks" (controller:"track", action:"returnTrackList")
		"/getTrack" (controller:"track", action:"gt")
		"/getNextTrack" (controller:"track", action:"nt")
		
		"/"(view:"/index")
		"500"(view:'/error')
	}
}
