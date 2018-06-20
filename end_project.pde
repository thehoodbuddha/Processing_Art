IntDict count;
String words[];
int start_Xpos = 30; 
int end_Xpos = 400;
int start_Ypos;
ArrayList<TextBoid> boids;
  int currentX = 50;
  int currentY = 20;

void setup() {
  boids  = new ArrayList<TextBoid>();
  size(600, 600);
  count = new IntDict();
  splitToWords();
  add_boid();
}



void draw() {
  background(0);
  // wordToCount(words);
  //display();
  //text("test",255,250);
  //for(TextBoid b: boids){
  // b.update();
  // b.display();
  //}
  display();
}


void splitToWords()
{
  //TODO how about some try catch
  String[] lines = loadStrings("text.txt");
  String allthetext = join(lines, " ");
  words = splitTokens(allthetext, " ,.:;!");
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


void display() {

  int i = 0;
  PVector pos = new PVector(0, 0);
  while (currentY<height-50) {
    while (currentX<width-50) {
      text(words[i], currentX, currentY);
      currentX +=textWidth(words[i]);
      i++;
      if (currentX>width-50) {
        println(currentX);
        currentX = 50;
        currentY+=20;

        // constrain(i,0,150);
      }
    }
  }
}