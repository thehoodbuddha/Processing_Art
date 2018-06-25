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
  
  //change the letter boid's mode to flock and add it to the flock
  void addLetterBoid(LetterBoid lb) {
    lb.changeMode(true);
    letterBoids.add(lb);
  }
  
  //change the letter boid's mode to nonflock and remove from the flock
  void removeLetterBoid(LetterBoid lb) {
    lb.changeMode(false);
    letterBoids.remove(lb);
  }
  
}
  