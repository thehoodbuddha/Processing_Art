IntDict count;
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
  count = new IntDict();    //initialize the IntDict class that is build-in 
  lf = new LetterFlock();
  //splitToWords();

  //  pos1 = new PVector(width/2, height/2);
  //  pos2 = new PVector(width/2, height*0.25);
  //  vel1 = new PVector(0, -5);
  //  vel2 = new PVector(0, 5);
  //  c1 = color(255, 0, 0);
  //  c2 = color(0, 0, 255);
  //  tb1 = new TextBoid("lorem", pos1, vel1, c1);
  //  tb2 = new TextBoid("ipsum", pos2, vel2, c2);



  tbs = new ArrayList<TextBoid>();
  lbs = new ArrayList<LetterBoid>();
    ps = new ArrayList<Particles>();
  /* 
   for (int i = 0; i<10; i++) {
   PVector loc = new PVector(random(width), random(height));
   PVector vel = new PVector(random(-1, 1), random(-1, 1));
   tbs.add(new TextBoid("text", loc, vel, 255));
   }
   */

  tc.splitToWords();
  tc.add_boids();
}



void draw() {
  background(0);
  lf.run();
  //tb1.update();
  //tb2.update();

  //boolean cc = tb2.collisionCheck(tb1); //cc: collision check
  //if (cc == true)
  //{
  //  tb1.explodeToLetters();
  //  tb2.explodeToLetters();
  //}

  //tb1.display();
  //tb2.display();
  //tc.display();
  //tc.update();

  for (TextBoid b : tbs) {
    b.display();
    b.update();
    b.borders();
    PVector force = new PVector(random(-0.01, 0.01), random(-0.01, 0.01));
    force.mult(2);
    b.addForce(force);

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
    for (LetterBoid lb : lbs)
  {
    lb.update();
    lb.display();
    PVector loc  = new PVector(mouseX, mouseY);
    lb.selected(loc);
    
    if(lb.fly()){
     PVector test = lb.getPosition();
     
     PVector test2 = new PVector(random(-1,1),random(-1,1));
     ps.add(new Particles(test, test2, 2)); 
    }
  }
}



void mousePressed() {
  for (LetterBoid lb : lbs)
  {
    PVector loc  = new PVector(mouseX, mouseY);
    lb.click(loc);
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
    matrixColors[1] = color(0, 59, 0);
    matrixColors[2] = color(0, 255, 65);

    int indice = int(random(0, 3));

    for (LetterBoid lb : lbs)
    {
      if (key == lb.getChar() && lb.getFlockMode() == false)
      {
        lb.updateColor(matrixColors[indice]);
        lf.addLetterBoid(lb);
      }
    }
  }
