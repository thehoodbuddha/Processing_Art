IntDict count;
String words[];
TextCluster tc;
String[] lines;

ArrayList<TextBoid> tbs;
ArrayList<LetterBoid> lbs;

PVector pos1, pos2;
PVector vel1, vel2;
color c1, c2;

TextBoid tb1, tb2;
void setup() {
  size(600, 600);
  background(255);
  smooth(4);
  tc = new TextCluster("text.txt");
  count = new IntDict();    //initialize the IntDict class that is build-in 
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
    PVector force = new PVector(random(-0.001, 0.001), random(-0.001, 0.001));

    b.addForce(force);
    //b.explodeToLetters();
    b.display();
  }


  if (mouseX>width/2) {
    for (TextBoid b : tbs) {
      if (b.collisionCheck(tbs)) {

        b.explodeToLetters(lbs);
        //println("trying to remove");
        //tbs.remove(0);
        //println("success!");
        
      }
    }
    
    
  }
  for (LetterBoid lb : lbs)
    {
      lb.update();
      lb.display();
    }
}