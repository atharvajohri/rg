package com.rg.core

import grails.converters.JSON

import org.atmosphere.cpr.ApplicationConfig
import org.atmosphere.cpr.AtmosphereRequest
import org.atmosphere.cpr.AtmosphereResource
import org.atmosphere.cpr.AtmosphereResourceEvent
import org.atmosphere.cpr.AtmosphereResourceFactory
import org.atmosphere.cpr.AtmosphereResponse

class RadioRelayerService {

	static atmosphere = [mapping: '/atmosphere/radioRelayer']
	
    @Override
	public void onRequest(AtmosphereResource r) throws IOException {
		 AtmosphereRequest req = r.getRequest();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			r.suspend();
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			def data = req.getReader().readLine().trim()
			if (data == "ins_player"){
				def player = Player.findByCurrent(true)
				String uuid = (String)req.getAttribute(ApplicationConfig.SUSPENDED_ATMOSPHERE_RESOURCE_UUID);
				player.uuid = uuid
				log.info "[Relay] --> A player ${uuid} is instantiated."
			}
			else if (data == "sync"){
				log.info "[Relay] --> A client ${r.uuid} has connected & requests sync."
				def player_uuid = Player.findByCurrent(true).uuid
				AtmosphereResource playerResource = AtmosphereResourceFactory.getDefault().find(player_uuid)
				AtmosphereResponse playerResponse = playerResource.getResponse();
				
				playerResponse.getWriter().write("syncRequest")
			}
			else if(data.toString().indexOf("syncResponse")>-1){
				log.info "[Relay] --> Player sends a sync response ${data} for broadcast"
				r.getBroadcaster().broadcast(data);
			}
		}
	}	

	@Override
	public void onStateChange(AtmosphereResourceEvent event) throws IOException {
		AtmosphereResource r = event.getResource();
		AtmosphereResponse res = r.getResponse();
		
		if (r.isSuspended()) {
			res.getWriter().write(event.getMessage().toString());
//			if (flushResponse){
//				res.getWriter().flush();
//				flushResponse = false;
//			}
//			switch (r.transport()) {
//				case JSONP:
//				case LONG_POLLING:
//					event.getResource().resume();
//					break;
//				case WEBSOCKET :
//				case STREAMING:
//					res.getWriter().flush();
//					break;
//			}
		} else if (!event.isResuming()){
			log.info ("Shutting Down..")
//			event.broadcaster().broadcast("Shutting Down..").toString();
		}
	}
	
	@Override
	public void destroy() {
	
	}
}
