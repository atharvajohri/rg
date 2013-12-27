<!doctype html>
<html>
	<head>
		<title>Music Player</title>
		<g:javascript plugin="jquery" library="jquery"></g:javascript>
		<script data-main="/js/main.js" src="/js/frameworks/require.min.js"></script>
		<style>
			body {background:#fafafa;margin:0;padding:0;font-family:arial;color:#6d6d6d;overflow:hidden}
			.main-container {overflow:hidden;}
			#track-list-container {padding:20px;overflow-y: scroll; }
			#track-list-container th {text-align: left;}
			#track-list-container td {font-size:12px;}
			.info-box {width:250px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;}
			.pc-inner {float:left;}
			.pc-track-details {font-size:15px;}
			.player-container {padding:20px;height:120px;border-bottom:1px solid #9d9d9d; box-shadow:0px 0px 10px 0px #9d9d9d;}
			.pc-inner-container {overflow:auto;}
			.pc-search {margin-left:20px;padding:10px;padding-top:0px}
			.pc-search-box-main {border-radius:5px;height:30px;width:280px;border:1px solid #9d9d9d;font-size:16px;color:#888;}
			.player-button {border-radius:5px;background:#777;color:#fff;border:1px solid #777;padding:5px;font-size:15px;cursor:pointer} 
			
			#link-generator-popup {width:800px;max-height:600px;display:none}
			#screen-overlay {z-index:10000;position:fixed;top:0px;left:0px;width:100%;height:100%;opacity:0.5;background:#888;display:none}
			
			.player-popup {overflow:auto;position:fixed;box-shadow:0px 0px 12px 0px #555;border-radius:5px;background:#fff;z-index:10090;}
			.player-popup-close {position:absolute;top:5px;right:5px;width:40px;padding:5px;border-radius:40px;background:#bdbdbd;font-size:12px;text-align:center;cursor:pointer;}
			.player-popup-title {font-size:15px;color:#444;font-weight:bold;padding:15px 10px;border-bottom:2px solid #bdbdbd}
			.player-popup-content {padding:15px 10px;font-size:12px;overflow:auto;}
			.popup-textbox {border:1px solid #888;width:210px;padding:2px; color:#888}
			.player-popup-content-container {float:left;padding:10px}
			#results-container {border-left: 2px solid #dedede;margin-left: 20px;border-bottom: 2px solid #dedede;width: 370px;}
			#results-container-content {margin-top:10px}
			#tried-links {height:330px;overflow-y:auto;}
			.final-link-label {border:none;border-left:1px solid #bdbdbd;padding-left:10px;width:200px;word-wrap:break-word;font-weight:bold;}
			.tested-link-container {width:250px;word-wrap:break-word;}
		</style>
		<r:layoutResources/>
	</head>	
	<body>
		<div id="screen-overlay"></div>
		<div id="link-generator-popup" class="player-popup">
			<div onClick="openGenerator(true)" class="player-popup-close">Close</div>
			<div class="player-popup-title">Link Generator</div>
			<div class="player-popup-content">
				<div class="player-popup-content-container" id="song-link-generation-form">
					<table>
						<tr>
							<th>Field</th><th>Value</th><th>RND</th>
						</tr>
						<tr>
							<td>Protocol</td>
							<td><input type="text" class="popup-textbox" data-bind="value: protocol" /></td>
							<td><input type="checkbox" class='cb-rnd' id="protocol-cb-rnd"/></td>
						</tr><tr>
							<td>Sub Domain</td>
							<td><input type="text" class="popup-textbox" data-bind="value: subDomain" /></td>
							<td><input type="checkbox" class='cb-rnd' id="subDomain-cb-rnd"/></td>
						</tr><tr>
							<td>Domain</td>
							<td><input type="text" class="popup-textbox" data-bind="value: domain" /></td>
							<td><input type="checkbox" class='cb-rnd' id="domain-cb-rnd"/></td>
						</tr><tr>
							<td>Variable 1</td>
							<td><input type="text" class="popup-textbox" data-bind="value: var1" /></td>
							<td><input type="checkbox" class='cb-rnd' id="var1-cb-rnd"/></td>
						</tr><tr>
							<td>Variable 2</td>
							<td><input type="text" class="popup-textbox" data-bind="value: var2" /></td>
							<td><input type="checkbox" class='cb-rnd' id="var2-cb-rnd"/></td>
						</tr><tr>
							<td>Variable 3</td>
							<td><input type="text" class="popup-textbox" data-bind="value: var3" /></td>
							<td><input type="checkbox" class='cb-rnd' id="var3-cb-rnd"/></td>
						</tr><tr>
							<td>Variable 4</td>
							<td><input type="text" class="popup-textbox" data-bind="value: var4" /></td>
							<td><input type="checkbox" class='cb-rnd' id="var4-cb-rnd"/></td>
						</tr><tr>
							<td>Variable 5</td>
							<td><input type="text" class="popup-textbox" data-bind="value: var5" /></td>
							<td><input type="checkbox" class='cb-rnd' id="var5-cb-rnd"/></td>
						</tr><tr>
							<td>Song Type</td>
							<td><input type="text" class="popup-textbox" data-bind="value: songType" /></td>
							<td><input type="checkbox" class='cb-rnd' id="songType-cb-rnd"/></td>
						</tr><tr>
							<td>Max Tries</td>
							<td><input type="text" class="popup-textbox" data-bind="value: maxApChangeCount" /></td>
							<td></td>
						</tr><tr>
							<td>Final Link</td>
							<td><div class="popup-textbox final-link-label" data-bind="text: generatedLink" ></div></td>
						</tr><tr>
							<td colspan="2" align="center">
								<input type="button" value="Check" class="player-button" data-bind="click: check" id="check-generation">
								<input type="button" value="Auto Generator" class="player-button" data-bind="click: generate" id="generate-auto">
								<input type="button" value="Stop Log" class="player-button" data-bind="click: lockSearch">
							</td>
						</tr>
					</table>
				</div>
				<div class="player-popup-content-container" id="results-container">
					<div id="results-container-title">
						Results:
					</div>
					<div id="results-container-content">
						<audio controls id='testPlayer' type="audio/m4a" oncanplay="playSuccess()" onloadeddata="loadSuccess()" onerror="songError()">
						</audio>
					</div>
					<div id="tried-links">
						<table>
						    <thead>
						        <tr><th>Link URL</th><th>Success</th></tr>
						    </thead>
						    <tbody data-bind="foreach: triedLinks">
						        <tr>
						            <td align="center">
						            	<div class="tested-link-container" data-bind="text: linkURL"></div>
						            </td>
						            <td align="center" data-bind="text: success">
						            
						            </td>
						        </tr>
						    </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class='main-container'>
			<div class='player-container'>
				<table style="width: 100%">
					<tr>
						<td valign="top">
							<div class="pc-inner-container">
								<div class="pc-controller pc-inner">
									<audio controls id='audioPlayer' type="audio/m4a" >
									</audio>
									<br>
									<input type="button" id="play-btn" value="Play" disabled="disabled"/>
									<input type="button" id="next-btn" value="Next"/>
									<input type="button" id="rnd-btn" value="Random"/>
									<g:if test="${allowRecommend }">
										<input type="button" id="rec-btn" value="Recommend"/>
									</g:if>
								</div>
								<div class="pc-inner pc-search">
									<input type="text" class="pc-search-box-main" />
									<input type="button" value="Search" class="pc-search-btn-main player-button">
									<input type="button" value="Generate" class="player-button" onClick="openGenerator()">
									<input type="button" value="Open Broadcast!" class="player-button" id="pc-open-broadcast">
								</div>
							</div>
							<br>
							<div class="pc-track-details pc-inner">
								<b>Now Playing:</b>
								<table style="width: 50%">
									<tr>
										<td><div class='info-box' id='cur-track-title'></div></td>
										<td><div class='info-box' id='cur-track-artist'></div></td>
										<td><div class='info-box' id='cur-track-album'></div></td>
										<td><div class='info-box' id='cur-track-fromsite'></div></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div id='track-list-container'>
				<table>
					<thead>
						<tr>
							<th>Title</th><th>Artist</th><th>Album</th><th></th>
						</tr>			
					</thead>
					<tbody id="track-list-table">
					
					</tbody>
				</table>
			</div>
		</div>
<%--		<script type="text/javascript" src="/js/frameworks/knockout.js" ></script>--%>
<%--		<script type="text/javascript" src="/js/models/linkViewModel.js" ></script>--%>
<%--		<g:javascript library="atm"/>--%>
<%--		<g:javascript library="models"/>--%>
<%--		<g:javascript library="relayer"/>--%>
<%--		<script type="text/javascript" src="/js/application/player.js" ></script>--%>
		
		<r:layoutResources/>
	</body>
</html>