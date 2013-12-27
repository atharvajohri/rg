function Radio() {
	var self = this;
	//state variables
	self.power = false;
	self.connected = false;
	self.synced = false;
	self.trackObject;
	
	//function variables
	self.relayer;
	self.player;
	self.timeUpdateCallback;
	//functions
	self.synchronize = function(){
		//ask for song information
		var message = new Message("sync");
		self.relayer.push("sync");
	}
	self.updateTrack = function(custom){
		/*var originalVolume = radio.player.volume;
		var volumeChangeInterval = setInterval(function(){
			if (radio.player.volume > 0.1){
				radio.player.volume = Number(radio.player.volume) - 0.05; 	
			}else{
				radio.player.volume = 0.0;
				clearInterval(volumeChangeInterval);
				$(radio.player).attr("src", radio.trackObject ? radio.trackObject.link : "");
				volumeChangeInterval = setInterval(function(){
					if (radio.player.volume < originalVolume){
						radio.player.volume = Number(radio.player.volume).toFixed(2) + 0.05; 	
					}else{
						radio.player.volume = originalVolume;
						clearInterval(volumeChangeInterval);
					}
				}, 100);
			}
		}, 100);*/
		var trackInfo = "";
		if (radio.trackObject){
			if (radio.trackObject.title)
				trackInfo += "<b>Title</b>:" + radio.trackObject.title;
			if (radio.trackObject.artist)
				trackInfo += "&nbsp;&nbsp;<b>Artist</b>:" + radio.trackObject.artist;
			if (radio.trackObject.album)
				trackInfo += "&nbsp;&nbsp;<b>Album</b>:" + radio.trackObject.album;
			$("#track-info-container .track-info").html(trackInfo);
			$(radio.player).attr("src", radio.trackObject ? radio.trackObject.link : "");
	
			self.getTrackGraphics();
		}
	}
	
	self.getTrackGraphics = function(){
		$.ajax({
			url: "/radio/getTrackGraphics",
			data: {"keywords":radio.trackObject.title + "::" + radio.trackObject.artist + "::" + radio.trackObject.album},
			success: function(data){
				
			}, 
			error: function(data){
				
			}
		})
	}
	
	self.reset = function(){
		radio.player.removeEventListener('progress', updateLoadedDuration);
		clearInterval(timeSyncInterval);
		timeSyncDuration = 0;
		firstUpdated = false;
		self.timeUpdateCallback = null;
	}
}

var radio = new Radio(), timeSyncInterval, timeSyncDuration=0, firstUpdated = false;

$(document).ready(function() {
	setupUI();
});

function timeUpdateTrigger(){
	if (radio.timeUpdateCallback)
		radio.timeUpdateCallback();
}

function setupUI() {
	$("#power-control").click(function() {
		var src = "";
		if (!radio.power) {
			src = "/images/icons/power-on.png";
			radio.player = document.getElementById("audioPlayer");
			if ( !radio.relayer ){
				radio.relayer = setupRelay(function(response){
					radio.connected = true;
					radio.synchronize();
				}, function(response){
					if (response.responseBody){
						if (response.responseBody.indexOf("syncResponse") > -1){
							var syncResponse = response.responseBody;
							var trackJSON = syncResponse.split("::");
							
							if (trackJSON[1] == "-1"){
								console.log ("Station is not broadcasting.");
							}else{
								var trackData = JSON.parse(trackJSON[1]);
								if (radio.synced == true && !trackData.forceReset){
									if (trackData.playing == true)
										radio.player.play();
									else
										radio.player.pause();
								}else{
									//station is broadcasting
									radio.reset();
									radio.trackObject = JSON.parse(trackJSON[1]);
									radio.synced = false;
									//start incrementing time for sync
									timeSyncInterval = setInterval(function(){
										radio.trackObject.currentTime = Number(radio.trackObject.currentTime) + 0.5;
									}, 500);
									
									//update the track
									radio.updateTrack();
									
									//play the track when it is ready
									$(radio.player).unbind('canplay');
									$(radio.player).bind('canplay', function() {
										if (radio.trackObject){
											if (radio.trackObject.playing == true)
												this.play();
											else
												this.pause();
										}
									});
									
									radio.player.addEventListener('progress', updateLoadedDuration);
								}
							}
						}
					}
				});
			}else{
				radio.synchronize();
			}
		}else{
			src = "/images/icons/power-off.png";
			radio.player.pause();
			radio.updateTrack();
			radio.reset();
			radio.trackObject = null;
		}
		radio.power = !radio.power;
		$("#power-control img").attr("src", src);
	});
	
}

function updateLoadedDuration(){
	radio.trackObject.loaded = radio.player.buffered.end(0);
	if ((radio.trackObject.loaded - 2) >= radio.trackObject.currentTime){ //2 seconds as buffer
		//time playing on server can be synced without delay now
		radio.synced = true;
		radio.player.removeEventListener('progress', updateLoadedDuration);
		radio.player.currentTime = radio.trackObject.currentTime;
		radio.reset();
	}
}
