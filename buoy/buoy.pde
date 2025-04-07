int NUM_ORBS = 8;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;
float AIR_DRAG_COEF = 0.01;
float WATER_DRAG_COEF = 0.1;
float WATER_DENSITY = (MAX_MASS + MIN_MASS)/(PI*pow((MAX_SIZE + MIN_SIZE)/2, 2));
float WATER_VOLUME = 0; //*amount* of water in the simulation, in pixels
float WATER_LEVEL = 0; //*height* of water in the simulation

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

FixedOrb planet;

OrbList slinky;

void setup() {
  size(600, 600);

  planet = new FixedOrb(width/2, height/2, 10, 300);

  slinky = new OrbList();
  setSim(GRAVITYSIM, 8, 0);
  toggles[GRAVITY] = true;
}//setup

void draw() {
  background(255);
  displayMode();
  
  displaceWater(WATER_VOLUME);
  //println("water level: " + WATER_LEVEL + " volume: " + WATER_VOLUME);
  fill(64, 164, 223, 150);
  noStroke();
  rect(0, height - WATER_LEVEL, width, WATER_LEVEL);
  
  planet.display();
  slinky.display();

  if (toggles[MOVING]) {
    
    if (toggles[SPRINGS]) {
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }

    if (toggles[GRAVITY]) {
      slinky.applyGravity(planet, G_CONSTANT);
    }
    
    if(toggles[DRAGF]) {
       slinky.applyDrag(WATER_LEVEL); 
    }
    
    if(toggles[BUOYANCY]) {
      slinky.applyBuoyancy(planet, G_CONSTANT, WATER_DENSITY, WATER_LEVEL);
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
  if (key == 'f') { toggles[BUOYANCY] = !toggles[BUOYANCY]; }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
  }
  if (key == '-') {
    slinky.removeFront();
  }
  if (key == '1') {
    planet = new FixedOrb(width/2, height/2, 10, 300);
    setSim(GRAVITYSIM, 8, 0);
    toggles[GRAVITY] = true;
  }
  if (key == '2') {
    planet = new FixedOrb(width/2, height + 20000, 1, 30000);
    setSim(SPRINGSIM, 10, 0);
    toggles[SPRINGS] = true;
    toggles[BOUNCE] = true;
  }
  if (key == '3') {
    planet = new FixedOrb(width/2, height + 20000, 1, 30000);
    setSim(DRAGSIM, 4, 180000);
    toggles[DRAGF] = true;
  }
  if (key == '4') {
    planet = new FixedOrb(width/2, height + 20000, 1, 30000);
    setSim(BUOYSIM, 6, 240000);
    toggles[BUOYANCY] = true;
    toggles[GRAVITY] = true;
    toggles[BOUNCE] = true;
  }
  if (key == '5') {
    planet = new FixedOrb(width/2, height + 20000, 1, 30000);
    setSim(COMBOSIM, 8, 270000);
    toggles[GRAVITY] = true;
    toggles[SPRINGS] = true;
    toggles[BUOYANCY] = true;
  }
  if (keyCode == UP) {
    WATER_VOLUME += 4800;
  }
  if (keyCode == DOWN) {
    WATER_VOLUME -= 4800;
  }
}//keyPressed

void setSim(int simType, int orbCount, float vol) {
  WATER_VOLUME = vol;
  displaceWater(vol);
  NUM_ORBS = orbCount;
  for (int i = 0; i < simulation.length; i++) {
    simulation[i] = false;
  }
  for (int i = 0; i < toggles.length; i++) {
    toggles[i] = false;
  }
  simulation[simType] = true;
  slinky.populate(NUM_ORBS, simType);
}

void displaceWater(float vol) {
  WATER_LEVEL = vol / width;
  OrbNode curr = slinky.front;
  //println(vol);
  while(curr != null) {
    vol += curr.getDisplacement(WATER_LEVEL);
    //println(curr.getDisplacement(WATER_LEVEL));
    //println(vol);
    curr = curr.next;
  }
  WATER_LEVEL = vol / width;
}

void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int x = 0;
  //text("Water Density: " + WATER_DENSITY, 0, 40);
  
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
