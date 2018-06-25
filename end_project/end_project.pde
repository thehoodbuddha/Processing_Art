/* Code written by Anil Özen & Jan-Paul Konijn. 
Build & run in processing 3.3.7
........ NEEDS DESCRIBTION ....... */
import java.util.Iterator;
String words[];
TextCluster tc;
String[] lines;
ArrayList<TextBoid> tbs;
ArrayList<LetterBoid> lbs;
ArrayList<Particles> ps;
LetterFlock lf;

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
  particles_Run();
}



void particles_Run() {                 

  Iterator<Particles> part = ps.iterator(); //display & update all the particles
  while (part.hasNext()) {                          
    Particles ps = part.next();
    ps.display();
    ps.update();
    
    if (ps.check()) {  //check if a particle is at it end of its life and remove
      part.remove();
    }
  }
}

//initilialize function calls the splitTowords function and the add_boid function. 
//The function take all the words and add them to the arraylist
void initialize() {  
  tc.splitToWords();
  tc.add_boids();
}

void Text_Run() {
  for (TextBoid b : tbs) {
    b.display();
    b.update();
    b.borders();
    PVector tpos = b.getPosition();
    //b.addForce(force);
    b.addOpacity(noise(tpos.x, tpos.y));
    //b.explodeToLetters();
    b.display();
  }

  if (mouseX >= width/3 && mouseX <= 2*(width/3)) {
    for (TextBoid b : tbs) {

      PVector force = new PVector(random(-0.01, 0.01), random(-0.01, 0.01));
      force.mult(2);
      b.addForce(force);
    }
  } else if (mouseX> 2*(width/3)) {
    for (TextBoid b : tbs) {
      int collisionID = b.collisionCheck(tbs);
      if (collisionID > 0) {

        b.explodeToLetters(lbs);
        tbs.get(collisionID).explodeToLetters(lbs);
        //remove both collided items
        tbs.remove(b);
        tbs.remove(tbs.get(collisionID-1)); //since b is removed every index is 1 less
        break;
        //println("success!");
      }
    }
  }
}

void add_Particle(boolean check) {         //get the check if the collide
  if (check) {                               //add 20 particles to the array
    for (int i =0; i<20; i++) {
      PVector test = new PVector(random(-2, 2), random(-2, 2));
      PVector loc=  new PVector(mouseX, mouseY);
      ps.add(new Particles(loc, test, 2, (int)random(0, 6)));
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
  color[] matrixColors;
  matrixColors = new color[3];
  matrixColors[0] = color(0, 143, 17);
  matrixColors[1] = color(32, 194, 14);
  matrixColors[2] = color(0, 255, 65);

  int indice = int(random(0, 3));


  //find the characters by key press, if they are not part of flock add it to the flock. 
  //if they are already in flock, remove from the flock
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