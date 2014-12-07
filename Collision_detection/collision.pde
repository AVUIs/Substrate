void Xcollisiondetection (float x1, float y1, float x2, float y2)
{
  Integer delta     = 0;
  Boolean collision = abs(x1 - x2) < ellipseWidth  + delta
                   && abs(y1 - y2) < ellipseHeight + delta;

  if (collision) {
    println("HIT!");
    println(x1, x2);
    println(y1, y2);

    delay(110000000);

    float note = notes[floor(random(0, notes.length))];
    out.playNote(0.0, 0.3, new DingInstrument(out));
  }
}
