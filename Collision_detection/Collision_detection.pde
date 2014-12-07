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

int ellipseWidth  = 55; // Width of the ball
int ellipseHeight = 55; // Lenght of the ball

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

  physics.makeAttraction( mouse, b, 1000, 10 );
  physics.makeAttraction( mouse, c, 1000, 10 );
  physics.makeAttraction( b, c, -10000, 5 );

  Noise noise;
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw()
{
  mouse.position().set( mouseX, mouseY, 0 );
  handleBoundaryCollisions(b);
  handleBoundaryCollisions(c);
  physics.tick();

  float x1 = b.position().x();
  float y1 = b.position().y();
  float x2 = c.position().x();
  float y2 = c.position().y();

  background( 255 );

  stroke( 0 );
  noFill();
  ellipse(mouse.position().x(), mouse.position().y(), 35, 35 );

  Xcollisiondetection(x1, y1, x2, y2);

  fill( 0 );
  ellipse(x1, y1, ellipseWidth, ellipseHeight);

  fill( 0 );
  ellipse(x2, y2, ellipseWidth, ellipseHeight);
}

// really basic collision strategy:
// sides of the window are walls
// if it hits a wall pull it outside the wall and flip the direction of the
// velocity
// the collisions aren't perfect so we take them down a notch too
void handleBoundaryCollisions( Particle p )
{
  if ( p.position().x() < 0 || p.position().x() > width )
    p.velocity().set( -0.9*p.velocity().x(), p.velocity().y(), 0 );
  if ( p.position().y() < 0 || p.position().y() > height )
    p.velocity().set( p.velocity().x(), -0.9*p.velocity().y(), 0 );
  p.position().set( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 );
}
