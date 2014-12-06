import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Integer filterFreq = 100;
Minim minim;
LowPassFS lpf;

void setup() {
  Oscil wave;
  Noise noise;

  size(100, 100);

  minim = new Minim(this);
  AudioOutput out = minim.getLineOut();

  // Create a oscillator
  // args:
  //    pitch
  //    amp
  //    waveform
  // wave = new Oscil( 440, 0.5, Waves.TRIANGLE );
  // patch the Oscil to the output
  // wave.patch( out );

  // Create a noise oscillator
  // args:
  //    amp
  //    Noise.Tint(WHITE PINK RED BROWN)
  noise = new Noise(1, Noise.Tint.BROWN);

  // Create a low pass filter
  // args: freq
  lpf = new LowPassFS(filterFreq, out.sampleRate());

  // Patch to output
  noise.patch(lpf)
       .patch(out);
}

void draw() {
  filterFreq = round(filterFreq * 1.005);

  lpf.setFreq(filterFreq);

  println(filterFreq);
  background(0);
}
