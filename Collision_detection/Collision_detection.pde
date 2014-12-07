import traer.physics.*;

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Particle mouse, b, c;
ParticleSystem physics;

AudioOutput out;
DingInstrument ding;
Integer filterFreq = 100;
LowPassFS lpf;
Minim minim;
float[] notes = { 440, 392, 349.23, 329.63, 293.66, 261.63, 246.94 };

int ellipseWidth= 5; //Width of the ball
int ellipseHeight=5; //Lenght of the ball

int i=0;

void setup()
{
  size( 400, 400 );
  frameRate( 24 );
  smooth();
  ellipseMode( CENTER );
  noStroke();
  noCursor();
  
  physics = new ParticleSystem();
  mouse = physics.makeParticle();
  mouse.makeFixed();
  b = physics.makeParticle( 1.0, random( 0, width ), random( 0, height ), 0 );
  c = physics.makeParticle( 1.0, random( 0, width ), random( 0, height ), 0 );
  
  physics.makeAttraction( mouse, b, 10000, 10 );
  physics.makeAttraction( mouse, c, 10000, 10 );
  physics.makeAttraction( b, c, -10000, 5 );

  Noise noise;
  minim = new Minim(this);
  out = minim.getLineOut();
  ding = new DingInstrument(440, out);
}

void draw()
{
  mouse.position().set( mouseX, mouseY, 0 );
  handleBoundaryCollisions( b );
  handleBoundaryCollisions( c );
  physics.tick();

  background( 255 );
  
  stroke( 0 );
  noFill();
  ellipse( mouse.position().x(), mouse.position().y(), 35, 35 );

  
  fill( 0 );
  ellipse( b.position().x(), b.position().y(), ellipseWidth, ellipseHeight );
   
  fill( 0 );
  ellipse( c.position().x(), c.position().y(), ellipseWidth, ellipseHeight );
  Xcollisiondetection(b.position().x(), c.position().x(), b.position().y(), c.position().y());
  
  
}

// really basic collision strategy:
// sides of the window are walls
// if it hits a wall pull it outside the wall and flip the direction of the velocity
// the collisions aren't perfect so we take them down a notch too
void handleBoundaryCollisions( Particle p )
{
  if ( p.position().x() < 0 || p.position().x() > width )
    p.velocity().set( -0.9*p.velocity().x(), p.velocity().y(), 0 );
  if ( p.position().y() < 0 || p.position().y() > height )
    p.velocity().set( p.velocity().x(), -0.9*p.velocity().y(), 0 );
  p.position().set( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 ); 
}

/*Function that calculates the collision between two particles*/
void Xcollisiondetection ( float e, float r, float g, float a )
{
  //Two particles collision formula |x1 - x2| + |y1 - y2|
  
 // print("b position= " + e);  // Printing a String
 //println("c position= " + r);  // Printing a String
  float coll= round(abs((e-r) + (g-a)));

  println(coll);
  
  if (coll < ellipseWidth + 1 )
  {
    i= i + 1;
    println("collision= " + i);

    float note = notes[floor(random(0, notes.length))];
    out.playNote(0.0, 0.3, new DingInstrument(note, out));
  }
}





