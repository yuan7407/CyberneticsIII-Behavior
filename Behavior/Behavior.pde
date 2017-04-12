//MichaelYuan 17.04.01
//Behavior Visualization
// Mover object

Vehicle autocar;
PassengerKid kid;
PassengerOld old;
boolean bGameOver;

void setup() {
  size(240, 960);
  autocar = new Vehicle();
  kid = new PassengerKid();
  old = new PassengerOld();

  bGameOver = true;
}

void draw() {

  if (bGameOver) {
    background(30);
    fill(255);
    textAlign(CENTER);
    text(" AUTONOMOUS CAR ETHICAL PARADOX", width/2-2, height/2-20);
    text(" Press [X] To Start", width/2, height/2);
    text("'Z' to break", width/2, height/2+20);
    text("'Left' & 'Right' to change direction", width/2+20, height/2+40);
  } else {
    background(12, 13, 31);
    // Update location
    autocar.update();
    // Wrape edges
    autocar.wrapEdges();
    //autocar.reset();
    autocar.boundaryDetect();
    // Draw autocar
    autocar.display();
    autocar.thrust(); 

    boolean kDeadth = deathDetect(autocar.location, kid.location, autocar.r, kid.r);
    boolean oDeadth = deathDetect(autocar.location, old.location, autocar.r, old.r);
    if (kDeadth) {
      bGameOver = true;
      gameReset();
    }
    if (oDeadth) {
      bGameOver = true;
      gameReset();
    }
    kid.update();
    kid.boundaryDetect();
    kid.display(); 
    kid.boundaryDetect();

    old.update();
    old.boundaryDetect();
    old.display(); 
    old.boundaryDetect();
    //fill(0);
  }
}

void keyReleased() {
  if (key == 'x') {
    bGameOver = false;
  }
}

boolean deathDetect(PVector pos1, PVector pos2, float r1, float r2) {
  float dis = PVector.dist(pos1, pos2);
  if (dis-10 < (r1+r2)/2) {
    return true;
  } else {
    return false;
  }
}

void gameReset() {
  autocar = new Vehicle();
  kid.reset();
  old.reset();
  bGameOver = true;
}