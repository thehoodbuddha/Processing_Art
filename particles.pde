class Particles {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int radius;
  int c = 255;
  int opacity = 255;
  Particles(PVector _location,PVector _velocity, PVector _acceleration, int _radius) {
    location= _location;
    radius =_radius;
    velocity =_velocity;
    acceleration = _acceleration;
  }

  void display() {
    fill(c,opacity);
    ellipse(location.x, location.y, radius*2, radius*2);
  }
  void update(){
   location.add(velocity);
   velocity.add(acceleration);
   opacity -=0.5;
  }
  Boolean check(){
    boolean rCheck = false; 
    if(opacity <= 0)rCheck = true;
    if (location.x>width-radius||location.x<0+radius)rCheck = true;
    if (location.y>height-radius||location.y<0+radius)rCheck = true;
    return rCheck;
  }
  
}
