
class OrbList {

  OrbNode front;

  OrbList() {
    //front = null;
  }//constructor

  /*===========================
   addFront(OrbNode o)
   
   Insert o to the beginning of the list.
   =========================*/
  void addFront(OrbNode o) {
    o.next = front;
    front = o;
  }//addFront

  /*===========================
   populate(int n, boolean ordered)
   
   Clear the list.
   Add n orbs to the list,
   using addFront.
   GRAVITYSIM: line them up along the left side of the center planet, make initial upward velocity to orbit.
   SPRINGSIM:  line them up horizontally along the center of the screen, make initial downward vel.
   DRAGSIM:    place them around the left center of the screen, above water level, initial rightward vel.
   BUOYSIM:    place them randomly.
   COMBOSIM:   line them up horizontally along the center of the screen.
   =========================*/
  void populate(int n, int simType) {
    front = null;
    OrbNode orb;

    if (simType == GRAVITYSIM) {
      float acc;
      for (int i = 0; i < n; i++) {
        orb = new OrbNode(width/2/n*i, height/2,
          random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
        acc = planet.mass * G_CONSTANT/pow(orb.center.dist(planet.center), 2);
        orb.velocity = new PVector(0, - 13 * sqrt(acc * orb.center.dist(planet.center)));
        addFront(orb);
      }
    } else if (simType == SPRINGSIM) {
      for (int i = 0; i < n; i++) {
        orb = new OrbNode(width/2 + ((float)i - (float)n/2 + 0.5) * SPRING_LENGTH, height/2,
          random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
        orb.velocity = new PVector(0, 10);
        addFront(orb);
      }
    } else if (simType == DRAGSIM) {
      //for (int i = 0; i < n; i++) {
      //  orb = new OrbNode(width/2 + ((float)i - (float)n/2 + 0.5) * SPRING_LENGTH, height/2,
      //    random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
      //  addFront(orb);
      //}

      for (int i = 0; i < n; i++) {
        orb = new OrbNode(
          random(width/4),
          random(height/4, height/2 - 20),
          random(MIN_SIZE, MAX_SIZE),
          random(MIN_MASS, MAX_MASS)
          );
        orb.velocity = new PVector(random(5, 10), 0);
        addFront(orb);
      }
    } else if (simType == BUOYSIM) {
      for (int i = 0; i < n; i++) {
        orb = new OrbNode();
        addFront(orb);
      }
    } else {
      for (int i = 0; i < n; i++) {
        orb = new OrbNode(width/2 + ((float)i - (float)n/2 + 0.5) * SPRING_LENGTH, height/2,
          random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
        addFront(orb);
      }
    }
  }//populate

  void display() {
    OrbNode curr = front;
    while (curr != null) {
      curr.display();
      curr = curr.next;
      //println("orb");
    }
  }//display

  void applySprings(int springLength, float springK) {
    OrbNode curr = front;
    while (curr != null) {
      curr.applySprings(springLength, springK);
      curr = curr.next;
    }
  }//applySprings

  void applyGravity(Orb other, float gConstant) {
    OrbNode curr = front;
    PVector grav;
    while (curr != null) {
      grav = curr.getGravity(other, gConstant);
      curr.applyForce(grav);
      curr = curr.next;
    }
  }//applySprings

  void applyBuoyancy(Orb other, float gConstant, float waterP, float waterL) {
    OrbNode curr = front;
    PVector buoy;
    while (curr != null) {
      buoy = curr.getBuoyancy(other, gConstant, waterP, waterL);
      curr.applyForce(buoy);
      curr = curr.next;
    }
  }//applySprings

  void applyDrag(float level) {
    OrbNode curr = front;
    while (curr != null) {
      //which drag coef to use based on position
      float dragCoef = (curr.center.y > height - level) ? WATER_DRAG_COEF : AIR_DRAG_COEF;

      PVector dragForce = curr.getDragForce(dragCoef);
      curr.applyForce(dragForce);
      curr = curr.next;
    }
  }

  void run(boolean bounce) {
    OrbNode curr = front;
    while (curr != null) {
      curr.move(bounce);
      curr = curr.next;
    }
  }//applySprings

  void removeFront() {
    if (front != null) {
      front = front.next;
    }
  }//removeFront

  OrbNode getSelected(float x, float y) {
    OrbNode curr = front;
    while (curr != null && !curr.isSelected(x, y)) {
      curr = curr.next;
    }//keep going until curr isSelected
    return curr;
  }//getSelected

  void removeNode(OrbNode o) {
    OrbNode curr = front;
    if (front == o) {
      front = curr.next;
      if (front != null) {
        front.previous = null;
      }
      println("front");
    } //if o is at the front
    else {
      while (curr.next != o) {
        curr = curr.next;
      }//find the OrbNode whose next is o
      println(curr.center);
      if (curr.next.next != null) {
        curr.next = curr.next.next;
        curr.next.previous = curr;
        println("other");
      } //if curr is not at the back nor the front
      else {
        curr.next = null;
        println("back");
      }//if o is at the back
    }
  }//removeNode
}//OrbList
