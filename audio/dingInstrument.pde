class DingInstrument implements Instrument
{
  Oscil wave;
  AudioOutput out;

  DingInstrument(Integer freq, AudioOutput output) {
    out = output;

    // Create a oscillator
    // args:
    //    pitch
    //    amp
    //    waveform
    wave = new Oscil(freq, 0.5, Waves.TRIANGLE);
    // patch the Oscil to the output
    wave.patch(out);
  }

  void noteOn(float dur) {
  }
  
  void noteOff() {
  }
}
