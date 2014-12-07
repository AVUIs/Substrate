import traer.physics.*;

ParticleSystem physics;
Particle[][] particles;
int gridSizeX, gridSizeY;
int distance0 = 10;
int tick = 0;

Particle mouse;

float xstart,xnoise,ynoise;

void setup () {
  size(800,400);
  smooth();
  background(255);

  gridSizeX = int(width/distance0);
  gridSizeY = int(height/distance0);

  physics = new ParticleSystem(0,0.01);
  particles = new Particle[gridSizeX][gridSizeY];

  mouse = physics.makeParticle();
  mouse.makeFixed();

  // run a little faster
  physics.setIntegrator(ParticleSystem.MODIFIED_EULER);

 
  xstart = random(10);
  xnoise = xstart;
  ynoise = random(10);

  for (int j=0; j<gridSizeY; j++) {
    ynoise += 0.1;
    xnoise = xstart;

    int y = j*distance0;

    for (int i=0; i<gridSizeX; i++) {
      xnoise += 0.1;
      int x = i*distance0;

      particles[i][j] = makeParticle(x,y,noise(xnoise,ynoise));
      //physics.makeAttraction( mouse, particles[i][j], 5000, 50 ); 
    }      
  }
}


Particle makeParticle(float x, float y, float noiseFactor) {
  drawPoint(x,y,noiseFactor);  
  return physics.makeParticle(0.2, x, y, 0.0);
}

void mousePressed() {
  int numParticles = physics.numberOfParticles();
  for (int i=0; i<numParticles; i++) {
    physics.makeAttraction( mouse, physics.getParticle(i), 5000, 50 ); 
  }
}

void mouseReleased() {
  int numAttractions = physics.numberOfAttractions();
  for (int i=numAttractions-1; i>=0; i--) {
    physics.removeAttraction(i); 
  }
}



void draw()
{
  mouse.position().set( mouseX, mouseY, 0 );
  
  physics.tick();
  tick++;

  background( 255 );
  
  for (int j=0; j<gridSizeY; j++) {
    ynoise += 0.1;
    xnoise = xstart;

    for (int i=0; i<gridSizeX; i++) {
      xnoise += 0.1;

      Particle p = particles[i][j];
      drawPoint(p.position().x(), p.position().y(),
                1.0 // particle sizes remain the same
                //noise(xnoise,ynoise) //EXP1: change particle size at each tick
                //tick%10 == 0 ? noise(xnoise,ynoise) : 1.0 //EXP2: change particle size at every 10 ticks
                );
    }
  }
      
}



// void drawPoint(float x, float y, float noiseFactor) {
//   int alph = int(noiseFactor*255);
//   stroke(0,alph);
//   line(x,y,x+1,y+1);
// }


void drawPoint(float x, float y, float noiseFactor) {
  float len = 10 * noiseFactor;
  rect(x,y,len,len);
}



// void drawPoint(float x, float y, float noiseFactor) {
//   float len = 10 * noiseFactor;
//   ellipse(x,y,len,len);
// }



// void drawPoint(float x, float y, float noiseFactor) {
//   pushMatrix();
//   translate(x,y);
//   rotate(noiseFactor*radians(360));
//   stroke(0,150);
//   line(0,0,20,0);
//   popMatrix();
// }


