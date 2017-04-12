
class Vehicle { 
  // All of our regular motion stuff
  PVector location;
  PVector velocity;
  PVector acceleration;

  // Arbitrary damping to slow down autocar
  float damping = 0.995;
  float topspeed = 20;

  // Variable for heading!
  float heading = 0;

  // Size
  float r = 32;

  // Are we thrusting (to color boosters)
  boolean thrusting = false;

  Vehicle() {
    location = new PVector(width/2, height/1.2);
    velocity = new PVector();
    acceleration = new PVector();
  } 

  // Standard Euler integration
  void update() { 
    velocity.add(acceleration);
    velocity.mult(damping);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Newton's law: F = M * A
  void applyForce(PVector force) {
    PVector f = force.get();
    //f.div(mass); // ignoring mass right now
    acceleration.add(f);
  }

  // Turn changes angle
  void turn(float a) {
    heading += a;
  }

  // Apply a thrust force
  void thrust() {
    // Offset the angle since we drew the autocar vertically
    float angle = heading - PI/2;
    // Polar to cartesian for force vector!
    PVector force = new PVector(cos(angle), sin(angle));
    force.mult(8.0);
    applyForce(force); 
    // To draw booster
    thrusting = true;
    if (keyPressed) {
      if (key == CODED && keyCode == LEFT) {
        autocar.turn(-0.03);
      } else if (key == CODED && keyCode == RIGHT) {
        autocar.turn(0.03);
      } 
      if (key == 'z' || key == 'Z') {
        acceleration.mult(0);
        velocity.limit(7);
      }
    }
  }
  void wrapEdges() {
    float buffer = r*2;
    //  if (location.x > width +  buffer) location.x = -buffer;
    //  else if (location.x <    -buffer) location.x = width+buffer;
    if (location.y > height + buffer) location.y = -buffer;
    else if (location.y <    -buffer) location.y = height+buffer;
  }

  void reset() {
    location.set(width/2, height/1.2);
    acceleration.mult(0);
  }

  void boundaryDetect() {
    if (location.x <0 || location.x >width) {
      reset();
    }
  }

  // Draw the autocar
  void display() { 
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(location.x, location.y+r);
    rotate(heading);
    fill(175);
    if (keyPressed == true) fill(255, 0, 0);
    // Booster rockets
    rect(-r/2, r, r/3, r/2);
    rect(r/2, r, r/3, r/2);
    fill(#08799b);
    stroke(255);
    strokeWeight(1);
    //A triangle
    beginShape();
    vertex(-r, r);
    vertex(0, -r);
    vertex(r, r);
    endShape(CLOSE);
    rectMode(CENTER);
    //rect(0, r, r, -2*r);
    popMatrix();

    thrusting = false;
  }
}