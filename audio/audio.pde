import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

AudioOutput out;
DingInstrument ding;
Integer filterFreq = 100;
LowPassFS lpf;
Minim minim;
float[] notes = { 440, 392, 349.23, 329.63, 293.66, 261.63, 246.94 };

void setup() {
  Noise noise;

  size(100, 100);

  minim = new Minim(this);
  out = minim.getLineOut();

  ding = new DingInstrument(440, out);

  // Create a noise oscillator
  // args:
  //    amp
  //    Noise.Tint(WHITE PINK RED BROWN)
  // noise = new Noise(1, Noise.Tint.BROWN);

  // Create a low pass filter
  // args: freq
  // lpf = new LowPassFS(filterFreq, out.sampleRate());

  // // Patch to output
  // noise.patch(lpf)
  //      .patch(out);
}

void draw() {
  background(0);
}

void keyPressed(){
  float note = notes[floor(random(0, notes.length))];
  out.playNote(0.0, 0.3, new DingInstrument(note, out));
}
