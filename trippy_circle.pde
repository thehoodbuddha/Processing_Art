class TrippyCircle
{
  float resolution; // how many points in the circle
  float rad;
  float x;
  float y;
  float t; // time passed
  float tChange; // how quick time flies
  float circularTime;

  float nVal; // noise value
  float nInt; // noise intensity
  float nAmp; // noise amplitude

  boolean filled;
  color currentColor;
  PVector origin;

  float audioAmp;

  TrippyCircle(color _initColor, float _rad)
  {
    resolution = 100; // how many points in the circle
    rad = _rad;
    x = 1;
    y = 1;
    t = 0; // time passed
    tChange = .02; // how quick time flies

    nInt = 1; // noise intensity
    nAmp = 1; // noise amplitude

    currentColor = _initColor;
    origin = new PVector(width/2, height/2);

    audioAmp = 0;
  }

  void display()
  {

    /*
    pushMatrix();
     translate(width/2, height/2);
     popMatrix();
     */
    fill(0);
    stroke(currentColor);



    nInt = map(mouseX, 0, width/2, 0.1, 30); // map mouseX to noise intensity
    nAmp = map(mouseY, 0, height/2, 0.0, 1.0); // map mouseY to noise amplitude

    nInt = 15;
    nAmp = 0.5;

    float nFinalInt = nInt + audioAmp;





    beginShape();
    for (float a=0; a<=TWO_PI; a+=TWO_PI/resolution) {
      nVal = map(noise( cos(a)*nFinalInt+1, sin(a)*nFinalInt+1, t ), 0.0, 1.0, nAmp, 1.0); // map noise value to match the amplitude
      //nVal = map(noise( cos(a)*nInt+1, sin(a)*nInt+1, t ), 0.0, 1.0, nAmp, 1.0); // map noise value to match the amplitude

      x = cos(a)*rad *nVal + origin.x;
      y = sin(a)*rad *nVal + origin.y;

      vertex(x, y);
    }
    endShape(CLOSE);

    t += tChange;
    circularTime += tChange;
    if (circularTime > TWO_PI) circularTime = 0;
    ellipse(cos(circularTime)*rad *nVal + origin.x, sin(circularTime)*rad *nVal + origin.y, 10, 10);
  }

  void updateAudioAmp(float inAmp)
  {
    audioAmp = inAmp;
  }
}
