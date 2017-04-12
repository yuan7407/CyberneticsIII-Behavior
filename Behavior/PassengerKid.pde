class PassengerKid {
  PVector location;
  PVector velocity;
  float r;

  PassengerKid() {
    location = new PVector(0, height/3);
    velocity = new PVector(3, 0);
    r = 40;
  }

  void display() {
    fill(255);
    ellipse(location.x, location.y, r, r);
    fill(0);
    text("KID", location.x, location.y);
  }

  void update() {
    location.add(velocity);
  }

  void boundaryDetect() {
    if (location.x >width) {
      reset();
    }
  }
  void reset() {
    location.set(0, height/3);
  }
}