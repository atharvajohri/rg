<!DOCTYPE html>
<html>
	<head>
		<title>Radio GaGa!</title>
		<link href='http://fonts.googleapis.com/css?family=Share+Tech+Mono' rel='stylesheet' type='text/css'>
		<style>
			body {padding:0;margin:0;font-family:"arial";font-size:18px;}
			#header-container {background:#222;padding:10px;height:95px;}
				#controls-container {float:left}
					#power-control {position:relative;display:inline-block;float:left;}
						#power-control img {cursor:pointer;width:100px;}
				#now-playing-container {border-radius:5px;background:#555;height:85px;width:750px;margin:auto;padding:5px}
					#title-container {background:url('/images/logos/title.png');height: 30px;background-size: contain;background-repeat: no-repeat;width: 180px;margin: auto;}
					#track-info-container {
						font-family: 'Arial', sans-serif;font-size:15px;color:#000;position:relative;
						height:17px;margin-top:10px;text-align: center;
					}
					.track-info {white-space: nowrap;overflow:hidden;display:inline-block;background:#777;padding:5px;border-radius:5px;}
					#volume-container {width:542px;margin:5px auto;}
						.volume-label {float:left;line-height:15px;margin:0px 5px;text-align:center}
						#volume-trigger {background:#888;width:500px;height:15px;float:left}
		</style>
		<g:javascript plugin="jquery" library="jquery"></g:javascript>
		<script type="text/javascript" src="/js/utilities/utils.js"></script>
		<script data-main="/js/main.js" src="/js/frameworks/require.min.js"></script>
<%--		<g:javascript library="ko"/>--%>
<%--		<g:javascript library="atm"/>--%>
<%--		<g:javascript library="models"/>--%>
<%--		<g:javascript library="relayer"/>--%>
<%--		<g:javascript library="radio"/>--%>
		<r:layoutResources/>
	</head>
	<body>
		<div id="main-container">
			<audio id='audioPlayer' type="audio/m4a" ontimeupdate="timeUpdateTrigger()">
			</audio>
			<div id="header-container">
				<div id="controls-container">
					<div id="power-control">
						<img src="/images/icons/power-off.png">			
					</div>
				</div>
				<div id="now-playing-container">
					<div id="title-container">
						
					</div>
					<div id="track-info-container">
						<div class="track-info">
						
						</div>
					</div>
					<%--<div id="volume-container">
						<div class="volume-label">-</div><div id="volume-trigger"></div><div class="volume-label">+</div>
					</div>--%>
				</div>
			</div>
		</div>
		<r:layoutResources/>
	</body>
</html>