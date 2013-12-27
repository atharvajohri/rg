$(document).ready(function(){
	setupEnvironment($("#environment"));
	exampleTest1();
});

var world;

function setupEnvironment(container){
	world = container ? container : $("body");
}

function get_random_color() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.round(Math.random() * 15)];
    }
    return color;
}

function exampleTest1(){
	var physics = new Physics();
	physics.integrator = new Verlet();

	// Design some behaviours for particles
	var avoidMouse = new Attraction();
	var pullToCenter = new Attraction();

	// Allow particle collisions to make things interesting
	var collision = new Collision();

	// Use Sketch.js to make life much easier
	var example = Sketch.create({ container: world[0]});
	world.find("canvas").attr("height", world.height());
	world.find("canvas").attr("width", world.width());

	// Create a physics instance which uses the Verlet integration method
	example.setup = function() {

	    for ( var i = 0; i < 300; i++ ) {

	        // Create a particle
	        var particle = new Particle( 2 * Math.random() );
	        var position = new Vector( random( world.width() ), random( world.height() ) );
	        particle.setRadius( particle.mass * 3 );
	        particle.moveTo( position );
	        particle.fillStyle = get_random_color();
	        // Make it collidable
	        collision.pool.push( particle );

	        // Apply behaviours
	        particle.behaviours.push( avoidMouse, pullToCenter, collision );

	        // Add to the simulation
	        physics.particles.push( particle );
	    }

	    pullToCenter.target.x = world.width() / 2;
	    pullToCenter.target.y = world.height() / 2;
	    pullToCenter.strength = 120;

	    avoidMouse.setRadius( 120 );
	    avoidMouse.strength = -500;

//	    example.fillStyle = get_random_color();
	}

	example.draw = function() {

	    // Step the simulation
	    physics.step();

	    // Render particles
	    for ( var i = 0, n = physics.particles.length; i < n; i++ ) {

	        var particle = physics.particles[i];
	        example.beginPath();
	        example.arc( particle.pos.x, particle.pos.y, particle.radius, 0, Math.PI * 2 );
	        example.fillStyle = particle.fillStyle;
	        example.fill();
	    }
	}
	
//	AttractionDemo.prototype.setup = function(full) {
//	    var attraction, bounds, collide, i, max, min, p, repulsion, _i, _results;
//
//	    if (full == null) {
//	      full = true;
//	    }
//	    AttractionDemo.__super__.setup.call(this, full);
//	    min = new Vector(0.0, 0.0);
//	    max = new Vector(this.width, this.height);
//	    bounds = new EdgeBounce(min, max);
//	    this.physics.integrator = new Verlet();
//	    attraction = new Attraction(this.mouse.pos, 1200, 1200);
//	    repulsion = new Attraction(this.mouse.pos, 200, -2000);
//	    collide = new Collision();
//	    max = full ? 400 : 200;
//	    _results = [];
//	    for (i = _i = 0; 0 <= max ? _i <= max : _i >= max; i = 0 <= max ? ++_i : --_i) {
//	      p = new Particle(Random(0.1, 3.0));
//	      p.setRadius(p.mass * 4);
//	      p.moveTo(new Vector(Random(this.width), Random(this.height)));
//	      p.behaviours.push(attraction);
//	      p.behaviours.push(repulsion);
//	      p.behaviours.push(bounds);
//	      p.behaviours.push(collide);
//	      collide.pool.push(p);
//	      _results.push(this.physics.particles.push(p));
//	    }
//	    return _results;
//	  };


	example.mousemove = function() {
	    avoidMouse.target.x = example.mouse.x;
	    avoidMouse.target.y = example.mouse.y;
	}
}