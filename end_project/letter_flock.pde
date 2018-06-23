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
    lb.initFlockSpeed();
    letterBoids.add(lb);
  }
  
  //void removeLetterBoid()
  
  void printCount()
  {
    println(letterBoids.size());
  }

}
  