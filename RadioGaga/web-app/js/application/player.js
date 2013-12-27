define(["models/linkViewModels", "frameworks/knockout", "controllers/relayer"],
	function(_linkViewModels, ko, _relayer){
		var listenedTracks = 0, curTrack, player, playing = false;
	
		function parseTrack(trackObj) {
	
			curTrack = trackObj;
			player.load()
			$(player).bind('canplay');
			$(player).bind('canplay', function() {
				startPlay(true);
			});
			
			if (trackObj.fromSite == "soundcloud"){
				var link = curTrack.link.replace("http://", "https://");
				var finalLink = link.substring (0, link.indexOf("&"));
				var chars = "0123456789abcdefghiklmnopqrstuvwxyz";
				var rnum = Math.floor(Math.random() * chars.length);
				var char = chars.substring(rnum, rnum+1);
				
				console.log("char is " + char)
				finalLink = finalLink.substring (0, finalLink.length - 1) + char;
				finalLink += link.substring (link.indexOf("&"), link.length);
				console.log(finalLink);
				var finalLinkParts = finalLink.split("&Expires=");
				var part2 = finalLinkParts[1].substring (10, finalLinkParts[1].length);
				console.log(part2);
				
				var expiry = finalLinkParts[1].substring (0, 10);
				console.log(expiry);
				expiry = Number(expiry) + 1000000;
				console.log(expiry);
				finalLink = finalLinkParts[0] + "&Expires=" + expiry.toString() + part2;
				console.log(finalLink);
				trackObj.link = finalLink;
				curTrack.link = finalLink;
			}
			
			$("#audioPlayer").attr("src", curTrack.link)
			$("#cur-track-title").html(trackObj.title);
			$("#cur-track-album").html(trackObj.album);
			$("#cur-track-artist").html(trackObj.artist);
			$("#cur-track-fromsite").html(trackObj.fromSite);
		}
	
		function pausePlay() {
			if (curTrack)
				curTrack.forceReset = false;
			player.pause();
			$("#play-btn").val("Play");
			playing = false;
//			broadcastTrackInfo();
		}
	
		function startPlay(forceReset) {
			if (curTrack)
				curTrack.forceReset = forceReset ? forceReset : false;
			$("#play-btn").removeAttr("disabled")
			player.play()
			$("#play-btn").val("Pause")
			playing = true
//			broadcastTrackInfo();
		}
	
		function getNextTrack(rnd) {
			pausePlay()
			$.ajax({
				url : "/getNextTrack",
				data : {
					"listenedTracks" : listenedTracks,
					"rnd" : rnd
				}
			}).done(function(trackObj) {
				if (trackObj == "reset") {
					listenedTracks = 0
				} else {
					parseTrack(trackObj)
					listenedTracks = listenedTracks + ", " + trackObj.id
				}
			});
		}
	
		function populateTrackList() {
			$.ajax({
				url : "/getTracks"
			}).done(function(trackList) {
				$("#track-list-container").css("height",(($(window).height()-$("#player-container").height() - 200) + "px"))
				$("#track-list-table").html(trackList);
			});
		}
	
		function playTrack(id) {
			$.ajax({
				url : "/getTrack",
				data : {
					"id" : id
				}
			}).done(function(trackObj) {
				if (trackObj != "not found") {
					parseTrack(trackObj)
					listenedTracks = listenedTracks + ", " + trackObj.id
				} else {
					console.log("not found")
				}
			})
		}
	
		function togglePlay() {
			if ($("#play-btn").val() == "Play") {
				if (curTrack) {
					startPlay()
				}
			} else {
				pausePlay()
			}
		}
	
		function positionGeneratorPopup(){
			$(".player-popup").each(function(){
				var left = ($(window).width() - $(this).width())/2;
				var top = ($(window).height() - $(this).height())/2;
				$(this).css({"top":top+"px", "left":left+"px"});
			});
		}
	
		var linkVM;
	
		function openGenerator(close){
			if (!close)
				$("#link-generator-popup, #screen-overlay").fadeIn(100);
			else
				$("#link-generator-popup, #screen-overlay").fadeOut(100);
		}
	
		function instantiatePlayer(callback){
			$.ajax({
				url : "/track/instantiatePlayer",
				success : function(data){
					if (data.success == true){
						console.log("player is ready");
						//setup relayer
						if (callback)
							callback();
					}else{
						var message = "Could not instantiate player :(";
						alert(message);
						console.log(message);
					}
				},
				error : function(){
					var message = "Could not instantiate player :(";
					alert(message);
					console.log(message);
				}
			});
		}
	
		function getTrackInfo(){
			var trackInfo = -1;
			if (curTrack){
				curTrack.currentTime = player.currentTime;
				curTrack.playing = playing;
				trackInfo = ko.toJSON(curTrack);
			}
			return trackInfo;
		}
	
		var relayerSocket, socket;
	
		function broadcastTrackInfo(){
			if (relayerSocket){
				var trackInfo = getTrackInfo();
				relayerSocket.push("syncResponse::"+trackInfo);
			}
		}
	
		function setupPlayerRelay(){
			$("#pc-open-broadcast").click(function(){
				if ($("#pc-open-broadcast").val() == "Open Broadcast!"){
					instantiatePlayer(function(){
						_relayer.setCallbacks(
							null, null, null,
							function(r_socket, r_communicator){
								relayerSocket = r_communicator;
								socket = r_socket;
								$("#pc-open-broadcast").val("Close Broadcast");
								_relayer.setCallbacks(
									null, 
									function(response){
										if (response.responseBody){
											if (response.responseBody == "syncRequest"){
												broadcastTrackInfo();
											}
										}
									}, 
									function(){
										console.log("Sorry we're offline at the moment!")
									}
								);
								relayerSocket.push("ins_player");
							}
						);
						_relayer.setupRelay();
					});
					
				}else{
					socket.unsubscribe();
					$("#pc-open-broadcast").val("Open Broadcast!");
				}
			});
		}
	
		function recommendTrack(){
			$.ajax({
				url : "/track/recommend/"+trackObj.id,
				success : function(data){
					console.log(data);
				},
				error : function(data){
					console.log(data);
				}
			});
		}
	
		function initPlayer(){
			$(document).ready(function(){
				populateTrackList();
				var linkVM = new _linkViewModels.LinkVM();
				ko.applyBindings(linkVM, $("#link-generator-popup")[0])
				//$(".cb-rnd").attr("disabled", "disabled");
				
				player = document.getElementById("audioPlayer")
				$("#next-btn").click(function() {
					getNextTrack()
				});
		
				$("#rnd-btn").click(function() {
					getNextTrack("rnd")
				});
		
				$("#play-btn").click(function() {
					togglePlay()
				});
				
				$("#rec-btn").click(function(){
					recommendTrack();
				});
				
				player.addEventListener('ended', function(){
					getNextTrack('rnd');
				});
				
				$(".pc-search-btn-main").click(function(){
					console.log("returning search query...")
					$.ajax({
						url : "/track/searchTracks",
						data : {"search_parameter": $(".pc-search-box-main").val()}
					}).done(function(trackList) {
						$("#track-list-table").html(trackList);
					})
				});
				positionGeneratorPopup();
				
				$(".list-play-btn").die("click");
				$(".list-play-btn").live("click", function(){
					playTrack($(this).attr("data-id"));
				});
				
				setupPlayerRelay();
			});
		}
		
		return {
			initPlayer: initPlayer
		}
	}
);
