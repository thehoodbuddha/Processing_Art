class LetterBoid
{
  PVector velocity;
  PVector position;
  PVector acceleration;
  char c;
  float delta;
  color col;
  float theta;
  float r; //we model each word as circles for now

  boolean flockMode;

  float maxforce;
  float maxspeed;


  LetterBoid(char _c, PVector _position, PVector _velocity, color _col)
  {
    acceleration = new PVector(0, 0);
    c = _c;
    velocity = _velocity;
    position = _position; 
    delta = 0.16;
    col = _col;
    r = 3;

    //here onwards is about flocking
    flockMode = false;
    maxspeed = 3;
    maxforce = 0.05;
  }


  void update()
  {

    velocity.add(acceleration);
    if (!flockMode)
    {
      velocity.mult(0.99);

      theta =  velocity.heading2D(); //TODO deprecated, update to new version
      position.add(velocity.copy().mult(delta));
    } else
    {
      velocity.limit(maxspeed);
      position.add(velocity);
      // Reset accelertion to 0 each cycle
      acceleration.mult(0);
    }
  }
  void display()
  { 
    textSize(12);
    fill(col);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    text(c, 0, 0);
    popMatrix();
  }



  void run(ArrayList<LetterBoid> boids) {
    flock(boids);
    update();
    borders();
    //display();
  }  

  void applyForce(PVector force)
  {
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<LetterBoid> letterboids) {
    PVector sep = separate(letterboids);   // Separation
    PVector ali = align(letterboids);      // Alignment
    PVector coh = cohesion(letterboids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }



  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<LetterBoid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (LetterBoid other : boids) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<LetterBoid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (LetterBoid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<LetterBoid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (LetterBoid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0, 0);
    }
  }


  void initFlockSpeed()
  {
    flockMode = true;
    velocity.x = random(-1, 1);
    velocity.y = random(-1, 1);
  }


  //become subparticles

  void updateColor(color newCol)
  {
    col = newCol;
  }

  boolean getFlockMode(){
    return flockMode;
  }

  PVector getPosition()
  {
    return position;
  }

  char getChar()
  {
    return c;
  }

  float getTheta()
  {
    return theta;
  }
}