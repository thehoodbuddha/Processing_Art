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
    }
  }
  void display()
  { 
    if (wordMode)
    {
      textSize(12);
      fill(c);
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      text(text, 0, 0);
      popMatrix();
    } else
    {
      for (LetterBoid lit : lbs)
      {
        textSize(12);
        fill(c);
        PVector lpos = lit.getPosition();
        pushMatrix();

        translate(lpos.x, lpos.y);
        rotate(lit.getTheta());
        text(lit.getChar(), 0, 0);
        popMatrix();
      }
    }
  }

  void addForce(PVector Force) {
    acceleration.add(Force);  
    acceleration.limit(2);
  }

  boolean collisionCheck(TextBoid other)
  {
    boolean collided = false;

    PVector distance = position.copy().sub(other.getPosition());
    if (distance.mag() <= 2 * radius)
    {
      collided = true;
      wordMode = false;
    }
    return collided;
  }

  //become subparticles
  void explodeToLetters()
  {
    lbs = new LetterBoid[text.length()];
    for (int i = 0; i < text.length(); i++)
    {
      PVector lpos = position.copy().add(random(-5, 5), random(-5, 5));
      PVector lv = velocity.copy().rotate(random(0, TWO_PI));
      lbs[0] = new LetterBoid(text.charAt(i), lpos, lv, c);
    }
  }

  PVector getPosition()
  {
    return position;
  }
}
