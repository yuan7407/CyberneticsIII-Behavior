class PassengerOld {
  PVector location;
  PVector velocity;
  float r;

  PassengerOld() {
    location = new PVector(width, height/3-20);
    velocity = new PVector(-2, 0);
    r = 40;
  }

  void display() {
    fill(255);
    ellipse(location.x, location.y, r, r);
    fill(0);
    text("OLD",location.x, location.y);
  }

  void update() {
    location.add(velocity);
  }

  void boundaryDetect() {
    if (location.x < 0) {
      reset();
    }
  }
  void reset() {
    location.set(width, height/3-20);
  }
}