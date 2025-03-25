class OrbList {

  OrbNode front;

  /*===========================
   Contructor
   Does very little.
   You do not need to modify this method.
   =========================*/
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
   Add n randomly generated  orbs to the list,
   using addFront.
   If ordered is true, the orbs should all
   have the same y coordinate and be spaced
   SPRING_LEGNTH apart horizontally.
   =========================*/
  void populate(int n, boolean ordered) {
    front = null;
    OrbNode orb;
    for (int i = 0; i < n; i++) {
      if (ordered) {
        orb = new OrbNode(width/2 + ((float)i - (float)n/2 + 0.5) * SPRING_LENGTH, height/2, 
                          random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
      } else {
        orb = new OrbNode();
      } 
      addFront(orb);
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
