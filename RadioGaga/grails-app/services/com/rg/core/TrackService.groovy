package com.rg.core

class TrackService {

    def getNextTrack(listenedTracks, rnd){
		def curOff = 0;
		def track = ""
		if (rnd){
			Random rand = new Random();
			int  n = rand.nextInt(Track.count());
			track = Track.list(max:1, offset:n)[0];
		}else{
			if (listenedTracks){
				def tracks = Track.list(max:30, offset:curOff);
				tracks.each { t ->
					if (!(t.id in listenedTracks)){
						track = t
						return
					}
				}
			}else{
				track = Track.list(max:1, offset:curOff)[0];
			}
		}

		return track
	}
}
