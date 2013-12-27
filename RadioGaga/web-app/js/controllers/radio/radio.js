define(["frameworks/knockout", "models/radioModels", "controllers/relayer"],
	function(ko, _radioModels, _relayer){
		var g_radio;
	
		function initializeRadioActions(){
			$(document).ready(function(){
				g_radio = new _radioModels.Radio();

				//ready the relayer
				_relayer.setCallbacks(null, function(response){
					if (response.responseBody){
						if ( response.responseBody.indexOf("syncResponse") > -1 ){
							syncResponse = response.responseBody.split("::")[1];
							updateTrack(JSON.parse(syncResponse));
						}
					}
				}, function(){
					console.log("Sorry we're offline at the moment!")
				}, function(r_socket, r_communicator){
					g_radio.relayer().socket(r_socket);
					g_radio.relayer().communicator(r_communicator);
					setupRadio();			
				});
				
				_relayer.setupRelay();				
			});
		}
		
		function updateTrack(trackData){
			var track = new _radioModels.Track();
			Utils.mapObject(trackData, track, [], true);
		}
		
		function setupRadio(){
			$("#power-control").click(function() {
				if (!g_radio.power()){
					src = "/images/icons/power-on.png";
					g_radio.turnOn();
				}else{
					src = "/images/icons/power-off.png";
					g_radio.turnOff();
				}
				g_radio.power(!g_radio.power());
				$("#power-control img").attr("src", src);
			});	
		}
		
		function getRadioObject(){
			return g_radio;
		}
		
		return {
			initializeRadioActions: initializeRadioActions,
			getRadioObject: getRadioObject
		}
	}
);
