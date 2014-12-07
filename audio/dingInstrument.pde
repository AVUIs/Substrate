float[] notes = { 440, 392, 349.23, 329.63, 293.66, 261.63, 246.94 };

class DingInstrument implements Instrument
{
  ADSR ampEnv;
  AudioOutput out;
  Line pitchEnv;
  Oscil wave;
  float freq;

  DingInstrument(AudioOutput output) {
    out = output;
    freq = notes[floor(random(0, notes.length))];

    // Check the docks for these args. They are NOT ADSR... sigh
    ampEnv   = new ADSR(0.5, 0.03, 0.4, 0.1, 0.1);
    pitchEnv = new Line(0.02, freq * 2, freq);

    // Create a oscillator
    // args:
    //    pitch
    //    amp
    //    waveform
    wave = new Oscil(freq, 0.5, Waves.SQUARE);

    pitchEnv = new Line( 0.05, freq / 2, freq);
    pitchEnv.patch(wave.frequency);

    // patch the Oscil to the envelope
    wave.patch(ampEnv);
  }

  void noteOn(float dur) {

    pitchEnv.activate();
    ampEnv.noteOn();
    ampEnv.patch(out);
  }
  
  void noteOff() {
    ampEnv.unpatchAfterRelease(out);
    ampEnv.noteOff();
  }
}
