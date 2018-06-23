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
  
  TextBoid(String _text, PVector _position, PVector _velocity, color _c)
  {
    wordMode = true;
    acceleration = new PVector(0, 0);
    text = _text;
    velocity = _velocity;
    position = _position; 
    delta = 0.16;
    radius = 10;
    opacity = 0;
    
    c = _c;
    
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
      color alphaColor = color(c, opacity);
      fill(alphaColor);
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      text(text, 0, 0);
      popMatrix();

    }
    
  }
  void addForce(PVector Force) {
    acceleration.add(Force.mult(delta));  
    acceleration.limit(2);
  }

  /*
  void addRotation(float deltaTheta)
  {
    theta += deltaTheta;
  }
  */
  
  void addVelocity(PVector velocity)
  {
  
  }

  int collisionCheck(ArrayList<TextBoid> other)
  {
    int collisionID = -1;
    
    for (int i = 0; i < other.size(); i++) {
      float dist = PVector.dist(position, other.get(i).position);
      //PVector distance = position.copy().sub(other.position);
      if ((dist>0) && dist <= 2 * radius)
      {
        collisionID = i;
      }
    }
    
    /*
    for (TextBoid tb : other ) {
      float dist = PVector.dist(position, tb.position);
      //PVector distance = position.copy().sub(other.position);
      if ((dist>0) && dist <= 2 * radius)
      {
        collided = true;
      }
    }
    */
    return collisionID;
  }
  void borders() {
    if (position.x>width-radius||position.x<0+radius)velocity = new PVector(velocity.x*-1, velocity.y);
    if (position.y>height-radius||position.y<0+radius)velocity = new PVector(velocity.x, velocity.y*-1);
  }

  //become subparticles
  void explodeToLetters(ArrayList<LetterBoid> leBods)
  {
    if (wordMode)
    {
      for (int i = 0; i < text.length(); i++)
      {
        PVector lpos = position.copy().add(random(-5, 5), random(-5, 5));
        PVector lv = velocity.copy().rotate(random(0, TWO_PI));
        leBods.add(new LetterBoid(text.charAt(i), lpos, lv, c)) ;
      }
      wordMode = false;
      radius = 0;
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
  
  void addOpacity(float op)
  {
    opacity += op;
    if (opacity > 255)
      opacity = 255;
  }

  PVector getPosition()
  {
    return position;
  }
}