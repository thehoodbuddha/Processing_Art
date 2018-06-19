IntDict count;
String words[];
int start_Xpos = 30; 
int end_Xpos = 400;
int start_Ypos;

void setup() {
  size(600, 600);
  count = new IntDict();
  splitToWords();
}



void draw() {
  background(0);
  // wordToCount(words);
  display();
  //text("test",255,250);
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
void display() {

  int i = 0;
  int currentX = 0;
  int currentY = 20;
  while (currentX<width) {
    
    text(words[i], currentX, currentY);
        currentX +=textWidth(words[i]);
    i++;
  // constrain(i,0,150);
      if(currentX>=width-10){
   println("check");
   currentX = 0;
   currentY+=20;
  }
  }

}