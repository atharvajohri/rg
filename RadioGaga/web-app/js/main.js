requirejs(["controllers/radio/radio", "application/player"],
	function(_radio, _player) {
		if (window.location.pathname.indexOf("radio") > -1){
			_radio.initializeRadioActions();
		}else if(window.location.pathname.indexOf("player") > -1){
			_player.initPlayer();			
		}
	}
);