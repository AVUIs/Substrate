import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

AudioOutput out;
DingInstrument ding;
Integer filterFreq = 100;
LowPassFS lpf;
Minim minim;

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
  // filterFreq = round(filterFreq * 1.005);

  // lpf.setFreq(filterFreq);

  background(0);
}

void keyPressed(){
  out.playNote(0.0, 0.3, new DingInstrument(440, out));
}
