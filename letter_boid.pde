class LetterBoid
{
  PVector velocity;
  PVector position;
  PVector acceleration;
  char text;
  float delta;
  color c;
  float theta;
  float radius; //we model each word as circles for now
  LetterBoid(char _text, PVector _position, PVector _velocity, color _c)
  {
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

    velocity.add(acceleration);
    theta =  velocity.heading2D(); //TODO deprecated, update to new version
    position.add(velocity.copy().mult(delta));
  }
  void display()
  { 
    textSize(12);
    fill(c);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    text(text, 0, 0);
    popMatrix();
  }

  
  //become subparticles

  PVector getPosition()
  {
    return position;
  }
  
  char getChar()
  {
    return text;
  }
  
  float getTheta()
  {
    return theta;
  }
}