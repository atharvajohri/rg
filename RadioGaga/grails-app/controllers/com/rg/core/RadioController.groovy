package com.rg.core

import grails.plugin.springsecurity.annotation.Secured

import org.apache.commons.codec.binary.Base64
import org.jsoup.Jsoup
import org.jsoup.nodes.Document

@Secured(['permitAll'])
class RadioController {

    def index() { }
	
	def getTrackGraphics(){
		log.info "needed graphics for \n $params.keywords"
		def keywords = params.keywords.split("::")
		
		def title = keywords[0]
		def artist = keywords[1]
		
		
		Document doc = Jsoup.connect("http://www.google.com/search?safe=off&site=&tbm=isch&source=hp&biw=1680&bih=882&q=iphone&oq=iphone&gs_l=img.3..0l10.501.1540.0.1690.6.3.0.3.3.0.136.289.2j1.3.0....0...1ac.1.29.img..0.6.303.HCIp-22JbRk#q=iphone&safe=off&tbm=isch&tbs=isz:l").get();
		log.info doc.html()
	}
	
	def testBing(){
		def s = "U9mQEJ9Ic9yQ9JhX88jckqPHLZwNXjS0slNRg+2R9Mw"
		def url = "https://api.datamarket.azure.com/Bing/Search/Web?format=json&Query=iphone&Market=en-us"
		String base64login = new String(Base64.encodeBase64(s.getBytes()));

		Document document = Jsoup
		    .connect(url)
		    .header("Authorization", "Basic " + base64login)
		    .get();
		log.info "\n ${document.html()}"
	}
}
