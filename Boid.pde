class TextBoid
{
  PVector velocity;
  PVector position;
  PVector acceleration;
  String text;
  float delta;
  color c;
  float theta;
  float radius; //we model each word as circles for now
  boolean wordMode; //the mode, 1 is word mode, 0 is letters mode
  float opacity;
  
  LetterBoid[] lbs;
  TextBoid(String _text, PVector _position, PVector _velocity, color _c)
  {
    wordMode = true;
    acceleration = new PVector(0, 0);
    text = _text;
    velocity = _velocity;
    position = _position; 
    delta = 0.16;
    c = _c;
    radius = 10;
  }
  void update()
  {
    if (wordMode)
    {
      velocity.add(acceleration);
      theta =  velocity.heading2D(); //TODO deprecated, update to new version
      position.add(velocity.copy().mult(delta));
    } else
    {
      for (LetterBoid lit : lbs)
      {
        lit.update();
      }
    }
  }
  void display()
  { 
    if (wordMode)
    {
      textSize(12);
      fill(c,opacity);
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      text(text, 0, 0);
      popMatrix();
    } else
    {
      for (LetterBoid lit : lbs)
      {
        lit.display();
      }
    }
  }
  void addForce(PVector Force) {
    acceleration.add(Force);  
    acceleration.limit(2);
  }

  boolean collisionCheck(ArrayList<TextBoid> other)
  {
    boolean collided = false;
    for (TextBoid tb : other ) {
      float dist = PVector.dist(position, tb.position);
      //PVector distance = position.copy().sub(other.position);
      if ((dist>0) && dist <= 2 * radius)
      {
        collided = true;
      }
    }
    return collided;
  }
  void borders() {
    if (position.x>width-radius||position.x<0+radius)velocity = new PVector(velocity.x*-1, velocity.y);
    if (position.y>height-radius||position.y<0+radius)velocity = new PVector(velocity.x, velocity.y*-1);
  }

  //become subparticles
  void explodeToLetters()
  {
    if (wordMode)
    {
      println("exploding words!");
      lbs = new LetterBoid[text.length()];
      for (int i = 0; i < text.length(); i++)
      {
        PVector lpos = position.copy().add(random(-5, 5), random(-5, 5));
        PVector lv = velocity.copy().rotate(random(0, TWO_PI));
        lbs[i] = new LetterBoid(text.charAt(i), lpos, lv, c);
      }
      wordMode = false;
    }
  }
  
  boolean fade(float amount){
    boolean remove = false;
    opacity-=amount;
    if(amount<=0){
     remove = true; 
    }
    return remove;
  }
  

  PVector getPosition()
  {
    return position;
  }
}
