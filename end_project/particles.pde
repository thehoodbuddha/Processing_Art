class Particles {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int radius;
  int c = 255;
  int opacity = 255;
  float delta = 0.16;
  String str; 
  int i;
  
  Particles(PVector _location,PVector _velocity,  int _radius, int _char) {
    str = "./';8&";
    i = _char;
    location= _location;
    radius =_radius;
    velocity =_velocity;
  }

  void display() {
    fill(c,opacity);
    noStroke();
    pushMatrix();

    translate(location.x,location.y);
    text(str.charAt(i),0,0);
    popMatrix();
  }
  void update(){
   location.add(velocity.copy().mult(delta));
   //velocity.add(acceleration);
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
