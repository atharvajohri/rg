define(["frameworks/knockout"],
	function(ko){
	
		var Radio = function(){
			var self = this;
			
			self.power = ko.observable(false); // (true || false)
			self.relayer = ko.observable(new Relayer()); 
			self.state = ko.observable(new RadioState()); //maintains current state of radio
			self.turnOn = function(){
				//sync the radio
				self.syncRadioState();
			}

			self.turnOff = function(){
				
			}
			
			self.syncRadioState = function(){
				//ask for song information
				var message = new Message("sync");
				self.relayer().communicator().push("sync");
			}
			
		}
	
		var RadioState = function(){
			var self = this;
			
			self.currentTrack = ko.observable();
			self.synced = ko.observable(false);
		}
//		{"class":"com.rg.core.Track","id":520,"active":true,"album":"Clarity","artist":"Zedd","artwork":null,"dateCreated":"2013-05-03T11:40:50Z",
//			"details":null,"fromSite":"8tracks","genre":null,"length":null,"likes":null,"link":"http://dtp6gm33au72i.cloudfront.net/tf/038/788/123/S8XdcN.48k.v3.m4a","recommended":false,"suggestions":null,
//			"title":"Hourglass (feat. LIZ)","type":"song","forceReset":true,"currentTime":17.753379,"playing":true}
		
		var Track = function(){
			var self = this;
			
			self.id = ko.observable();
			self.fromSite = ko.observable();
			self.title = ko.observable();
			self.artist = ko.observable();
			self.album = ko.observable();
			self.link = ko.observable();
			self.currentTime = ko.observable(0); //in milliseconds
		}
		
		var Relayer = function(){
			this.socket = ko.observable();
			this.communicator = ko.observable();
		}
		
		var Message = function(body){
			this.body = body;
			this.timestamp;
		}
		
		return {
			Radio: Radio,
			Track: Track,
			Relayer: Relayer,
			Message: Message
		}
	}
);

