int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.05;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int SPRINGS = 3;
int DRAGF = 4;
int BUOYANCY = 5;

int GRAVITYSIM = 0;
int SPRINGSIM = 1;
int DRAGSIM = 2;
int BUOYSIM = 3;
int COMBOSIM = 4;

boolean[] toggles = new boolean[6];
boolean[] simulation = new boolean[5];
String[] modes = {"Moving", "Bounce", "Gravity", "Springs", "Drag", "Buoyancy"};
String[] sims = {"Gravity", "Spring", "Drag", "Buoyancy", "Combo"};

FixedOrb earth;

OrbList slinky;

void setup() {
  size(600, 600);

  //earth = new FixedOrb(width/2, height * 200, 1, 20000);

  slinky = new OrbList();
  simulation[GRAVITYSIM] = true;
  toggles[GRAVITY] = true;
  slinky.populate(NUM_ORBS, GRAVITYSIM);
}//setup

void draw() {
  background(255);
  displayMode();

  slinky.display();

  if (toggles[MOVING]) {

    slinky.applySprings(SPRING_LENGTH, SPRING_K);

    if (toggles[GRAVITY]) {
      OrbNode sun = slinky.front;
      while (sun.next != null) {
        sun = sun.next;
      }
      slinky.applyGravity(sun, GRAVITY);
    }
    slinky.run(toggles[BOUNCE]);
  }//moving
}//draw

void mousePressed() {
  OrbNode selected = slinky.getSelected(mouseX, mouseY);
  if (selected != null) {
    slinky.removeNode(selected);
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') { toggles[MOVING] = !toggles[MOVING]; }
  if (key == 'g') { toggles[GRAVITY] = !toggles[GRAVITY]; }
  if (key == 'b') { toggles[BOUNCE] = !toggles[BOUNCE]; }
  if (key == 'd') { toggles[DRAGF] = !toggles[DRAGF]; }
  if (key == 's') { toggles[SPRINGS] = !toggles[SPRINGS]; }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
  }
  if (key == '-') {
    slinky.removeFront();
  }
  if (key == '1') {
    setSim(GRAVITYSIM);
    toggles[GRAVITY] = true;
  }
  if (key == '2') {
    setSim(SPRINGSIM);
    toggles[SPRINGS] = true;
    toggles[BOUNCE] = true;
  }
  if (key == '3') {
    setSim(DRAGSIM);
    toggles[DRAGF] = true;
  }
  if (key == '4') {
    setSim(BUOYSIM);
    toggles[BUOYANCY] = true;
  }
  if (key == '5') {
    setSim(COMBOSIM);
    toggles[GRAVITY] = true;
    toggles[SPRINGS] = true;
    toggles[BUOYANCY] = true;
  }
}//keyPressed

void setSim(int simType) {
  for (int i = 0; i < simulation.length; i++) {
    simulation[i] = false;
  }
  for (int i = 0; i < toggles.length; i++) {
    toggles[i] = false;
  }
  simulation[simType] = true;
  slinky.populate(NUM_ORBS, simType);
}

void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) { fill(0, 255, 0); }
    else { fill(255, 0, 0); }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
  x = 0;
  for (int m=0; m<sims.length; m++) {
    //set box color
    if (simulation[m]) { fill(0, 255, 0); }
    else { fill(255, 0, 0); }

    float w = textWidth(sims[m]);
    rect(x, 20, w+5, 20);
    fill(0);
    text(sims[m], x+2, 22);
    x+= w+5;
  }
}//display
