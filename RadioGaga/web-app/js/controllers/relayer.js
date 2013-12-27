//This controller sets up relaying for getting info about the broadcast
define(["frameworks/jquery.atmosphere"],
	function(){
	
		var g_openCallback, g_messageCallback, g_errorCallback, g_initCallback;
		var g_socket, g_communicator;
		var g_initCheckInterval, g_initTimeout, g_maxTimesRun;
		
		//creates a socket connection for communication
		function setupRelay(initCheckInterval, maxTimesRun){
			g_socket = $.atmosphere;
			var request = { 
				url: '/atmosphere/radioRelayer',
				contentType : "application/json",
				logLevel : 'debug',
				transport : 'websocket' 
			};
			
			request.onOpen = function(response){
				if (response.transport == "websocket" && !response.error){
					console.log ("***RELAYER***: Relayer is ready..");
					console.log (response);
					if (g_openCallback)
						g_openCallback(response);
				}else{
					g_communicator = "FAILED";
					console.log("***RELAYER***: Could not initialize.. Try refreshing.")
					if (g_errorCallback)
						g_errorCallback(response);
				}
			}
			
			request.onMessage= function(response){
				console.log ("***RELAYER***: Got a message:");
				console.log(response);
				if (g_messageCallback)
					g_messageCallback(response);
			}
			
			request.onError= function(response){
				console.log("***RELAYER***: Some error occurred: \n ");
				console.log(response);
				if (g_errorCallback)
					g_errorCallback(response);
			}
			
			g_communicator = g_socket.subscribe(request);
			g_initCheckInterval = initCheckInterval || 100; //100ms
			g_maxTimesRun = maxTimesRun || 20;
			
			checkForInit(0);
		}
		
		function checkForInit(timesRun){
			g_initTimeout = setTimeout(function(){
				timesRun++;
				console.log("***RELAYER*** Checked for init " + timesRun);
				if (g_communicator){
					if (g_initCallback)
						g_initCallback(g_socket, g_communicator);
				}else{
					if (timesRun > g_maxTimesRun){
						console.log("***RELAYER*** Can't check more for init, max exceeded.");
						g_communicator = "FAIL";
					}else{
						checkForInit(timesRun);
					}
				}
				
				
			}, g_initCheckInterval);
		}
		
		function setCallbacks(oc, mc, ec, ic){
			if (oc)
				g_openCallback = oc;
			if (mc)
				g_messageCallback = mc;
			if (ec)
				g_errorCallback = ec;
			if (ic)
				g_initCallback = ic;
		}
		
		function stopInitChecker(){
			clearTimeout(g_initTimeout);
		}
		
		return {
			setupRelay: setupRelay,
			setCallbacks: setCallbacks,
			stopInitChecker: stopInitChecker
		}
	
	}
);
