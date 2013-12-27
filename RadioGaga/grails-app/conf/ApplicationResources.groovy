modules = {
    application {
        resource url:'js/application.js'
    }
	
	//controllers
	relayer {
		resource url:'js/controllers/relayer.js'
	}
	radio {
		resource url:'js/controllers/radio/radio.js'
	}
	
	//models
	models {
//		resource url:'js/models/Radio.js'
	}
	
	//frameworks
	atm {
		resource url:'js/frameworks/jquery.atmosphere.js'
	}
	ko {
		resource url:'js/frameworks/knockout.js'
	}
	require {
		resource url:'js/frameworks/require.min.js'
	}
}