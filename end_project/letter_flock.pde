class LetterFlock
{
  ArrayList<LetterBoid> letterBoids;
  
  LetterFlock() {
    letterBoids = new ArrayList<LetterBoid>();
  }



  void run(){
    for (LetterBoid lb : letterBoids) {
      lb.run(letterBoids);
    }
  }
  
  void addLetterBoid(LetterBoid lb) {
    lb.changeMode(true);
    letterBoids.add(lb);
  }
  
  void removeLetterBoid(LetterBoid lb) {
    lb.changeMode(false);
    letterBoids.remove(lb);
  }
  
  void printCount()
  {
    println(letterBoids.size());
  }

}
  
