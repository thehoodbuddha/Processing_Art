IntDict count;
String words[];
ArrayList<TextBoid> boids;
String[] lines;

void setup() {
  size(600, 600);
  boids  = new ArrayList<TextBoid>();
  count = new IntDict();    //initialize the IntDict class that is build-in 
  splitToWords();
  add_boids();
}



void draw() {
  background(0);
  
  for (TextBoid b : boids) {
    b.display();
  }
  
  if (mouseX>width/2) {
    for (TextBoid b : boids) {
      b.update();
      PVector force = new PVector(random(-0.01,0.01),random(-0.01,0.01));
      
      b.addForce(force);
    }
  }
}


void splitToWords() {
  try {
    lines = loadStrings("text.txt");  //try to load the data,  the text file should be in the data folder
  }
  catch(Exception e) {
    println(e);
    lines = null;
  } 
  if (lines != null) {
    String allthetext = join(lines, " ");
    words = splitTokens(allthetext, " ,.:;/'()[]!");            //take out the unnecessary characters. 
  }
}

void wordToCount(String[] words_Array) {
  for (int i = 0; i<words_Array.length; i ++) {
    count.increment(words_Array[i].toLowerCase());
  }
  String[] word= count.keyArray();
  for ( int i = 0; i<word.length; i++) {
    int test =count.get(word[i]);
    println(word[i], test);
  }
}
void add_boid() {
  for (int i = 0; i<words.length; i++) {
    PVector loc = new PVector(random(width), random(height));
    PVector vel = new PVector(random(-1, 1), random(-1, 1));
    boids.add(new TextBoid(words[i], loc, vel, 255));
  }
}

void add_boids() {
  int currentX = 50;         //setting the starting X-point 
  int currentY = 50;         //setting the sarting Y-point
  int i = 0;                    
  while (currentY<height-100) {
    while (currentX<width-100 && i<=words.length-1) {
      PVector loc = new PVector(currentX, currentY);
      PVector vel = new PVector(0,0);
      boids.add(new TextBoid(words[i], loc, vel, 255));    
      currentX += textWidth(words[i]);                  //calculate the width of each word
      currentX+= textWidth(" ");
      i++;
      println(i);
    }
    currentX = 50;
    currentY+=20;
  }
}