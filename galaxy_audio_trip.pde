import processing.sound.*;

Amplitude amp;
SoundFile sf;

color _c = color(255, 0, 255);
color _c2 = color(255, 0, 0);
TrippyCircle tc, tc2;
void setup() {
  size(400, 400);
  noiseDetail(8);
  tc = new TrippyCircle(_c, 150);
  tc2 = new TrippyCircle(_c2, 160);


  sf = new SoundFile(this, "Kiasmos.mp3");
  sf.play();
  amp = new Amplitude(this);
  amp.input(sf);
}

void draw() {
  
  background(0);
  fill(255);
  
  String fpsCount = "FPS: " + int(frameRate);
  text(fpsCount, 10, 10);

  float aa = amp.analyze() * 50;
  tc2.display();
  tc.updateAudioAmp(aa);
  tc.display();
  

}
