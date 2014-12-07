class DingInstrument implements Instrument
{
  Oscil wave;
  AudioOutput out;
  ADSR adsr;

  DingInstrument(Integer freq, AudioOutput output) {
    out = output;

    // Create a oscillator
    // args:
    //    pitch
    //    amp
    //    waveform
    wave = new Oscil(freq, 0.5, Waves.TRIANGLE);

    // Check the docks for these args. They are NOT ADSR... sigh
    adsr = new ADSR(0.5, 0.01, 0.05, 0.5, 0.5);

    // patch the Oscil to the envelope
    wave.patch(adsr);
  }

  void noteOn(float dur) {
    println(dur);
    adsr.noteOn();
    adsr.patch(out);
  }
  
  void noteOff() {
    println("off");
    adsr.unpatchAfterRelease(out);
    adsr.noteOff();
  }
}
