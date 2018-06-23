String words[];
TextCluster tc;
String[] lines;
ArrayList<TextBoid> tbs;
ArrayList<LetterBoid> lbs;
ArrayList<Particles> ps;
LetterFlock lf;
PVector pos1, pos2;
PVector vel1, vel2;
color c1, c2;
TextBoid tb1, tb2;

void setup() {
  fullScreen(P2D);
  background(255);
  smooth(4);
  tc = new TextCluster("text.txt");
  lf = new LetterFlock();
  tbs = new ArrayList<TextBoid>();
  lbs = new ArrayList<LetterBoid>();
  ps = new ArrayList<Particles>();
  initialize();
}



void draw() {
  background(0);
  lf.run();
  Text_Run();
  Letter_Run();
  
  for (Particles p : ps) {
    p.display();
    p.update();
  }
}

void initialize() {
  tc.splitToWords();
  tc.add_boids();
}
void Text_Run() {
  for (TextBoid b : tbs) {
    b.display();
    b.update();
    b.borders();
    PVector force = new PVector(random(-0.01, 0.01), random(-0.01, 0.01));
    force.mult(2);
    PVector tpos = b.getPosition();
    b.addForce(force);
    b.addOpacity(noise(tpos.x, tpos.y));
    //b.explodeToLetters();
    b.display();
  }


  if (mouseX>width/2) {
    for (TextBoid b : tbs) {
      int collisionID = b.collisionCheck(tbs);
      if (collisionID > 0) {

        b.explodeToLetters(lbs);
        tbs.get(collisionID).explodeToLetters(lbs);
        //println(collisionID);
        //remove both collided items
        tbs.remove(b);
        tbs.remove(tbs.get(collisionID-1)); //since b is removed every index is 1 less
        break;
        //println("success!");
      }
    }
  }
}

void add_Particle(boolean check) {
  if (check) {
    for (int i =0; i<20; i++) {
      PVector test = new PVector(random(-2, 2), random(-2, 2));
      PVector loc=  new PVector(mouseX, mouseY);
      ps.add(new Particles(loc, test, 2,(int)random(0,6)));
    }
  }
}

void Letter_Run() {


  for (LetterBoid lb : lbs)
  {
    lb.update();
    lb.display();
    PVector loc  = new PVector(mouseX, mouseY);
    lb.selected(loc);
  }
}


void mousePressed() {
  PVector loc  = new PVector(mouseX, mouseY);
  for (LetterBoid lb : lbs)
  {

    lb.click(loc);
   add_Particle(lb.clicked());
  }

}
void mouseReleased() {
  for (LetterBoid lb : lbs)
  {
    lb.returnClick();
     
    
  }
}
void keyPressed()
{
  //color c = color(random(0,255),random(0,255),random(0,255));
  color[] matrixColors;
  matrixColors = new color[3];
  matrixColors[0] = color(0, 143, 17);
  matrixColors[1] = color(32, 194, 14);
  matrixColors[2] = color(0, 255, 65);

  int indice = int(random(0, 3));

  for (LetterBoid lb : lbs)
  {
    if (key == lb.getChar() && lb.getFlockMode() == false)
    {
      lb.updateColor(matrixColors[indice]);
      lf.addLetterBoid(lb);
    } else if (key == lb.getChar() && lb.getFlockMode() == true) //stop flocking
    {
      lb.updateColor(255);
      lf.removeLetterBoid(lb);
    }
  }
}
