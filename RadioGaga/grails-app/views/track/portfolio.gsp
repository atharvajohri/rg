<!doctype html>
<html>
	<head>
		<title>Atharva Johri: Portfolio</title>
		<link href='http://fonts.googleapis.com/css?family=Gochi+Hand|Lemon|Titan+One|Electrolize' rel='stylesheet' type='text/css'>
		<style>
			body {
				margin:0;padding:0;font-family:arial;font-size:18px; background:url("/images/backgrounds/bg1.jpg"); background-repeat: no-repeat;
				background-size:cover; color:#555;
			}
			#main-container {
				width:1000px;margin:auto;box-shadow:0px 0px 12px 0px #000;background:#fff;padding:15px;margin-top:20px;opacity:0.9;
				border-radius:5px;cursor:default;position:relative;
			}
			
			.ff-lemon {font-family: 'Lemon', cursive;}
			.ff-titan-one{font-family: 'Titan One', cursive;}
			.ff-electrolize{font-family: 'Electrolize', sans-serif;}
			.ff-gochi-hand{font-family: 'Gochi Hand', cursive;}
			
			.bold {font-weight:bold}
			
			#main-container canvas {position:absolute;top:0px; left:0px}
				#salut-container {font-size:65px;color:#222}
				#p1-container {font-size:25px;}
					#p1-wd {color:#000;font-size:50px}
					#p1-bs {color:#000}
		</style>
	</head>
	<body>
		<div id="main-container">
			<div id="salut-container" class="ff-gochi-hand">Hello!</div>
			<p id="p1-container">
				I am a <span class="ff-electrolize" id="p1-wd">Web Developer</span>, and I <span id='p1-bs' >Build Stuff</span>.
			</p>
			<p>
				I truly believe that anything that involves creation is a form of art. 
			</p>
			<p>
				Music and drawing are the common ones. But I believe that football, code and cooking are also!
			</p>
			<p>
				In fact, life itself is a painting with the canvas being your environment, and the paint is your thought.
			</p>
			<p>My favourite canvas is the browser</p>
			<p>
				It allows me to build applications and reach out to the Whole Wide World!
			</p>
			<p>
				I also think building Web Sites and Applications is fun. Java, Groovy on Grails, HTML/CSS, Javascript
			</p>
			<p>
				I don't think I'm the usual Geek because I also enjoy drawing &amp; sketching, travelling, reading, listening to awesome music and I also love to play my Guitar.
			</p>
			<p>
				I am also a guilty lover of the Sciences like Physics, Chemistry and Philosophy.
			</p>
			<p>
				I truly believe everyone has a different potential and vary in interests. It is not feasible to compare two people at all!<br>
				Thus of my favourite quotes comes from the master of modern physics. Albert Einstein said:
			</p>
			<p>
				Everybody is a genius. But if you judge a fish by its ability to climb a tree, it will live its whole life believing that it is stupid.
			</p>
		</div>
		<g:javascript library="jquery" plugin="jquery"></g:javascript>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'frameworks/physics.min.js') }"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'frameworks/sketch.min.js') }"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'controllers/animator.js') }"></script>
	</body>
</html>