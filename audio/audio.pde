import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Integer filterFreq = 5000;
Minim minim;
MoogFilter lpf;

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
  noise = new Noise(1, Noise.Tint.PINK);

  // Create a low pass filter
  // args:
  //    freq
  //    resonance
  //    filter type
  lpf = new MoogFilter(filterFreq, 0.2, MoogFilter.Type.LP);

  // Patch to output
  noise.patch(lpf)
       .patch(out);
}

void draw() {
  filterFreq = filterFreq + 1;

  lpf.frequency = filterFreq;

  println(filterFreq);
  background(0);
}
