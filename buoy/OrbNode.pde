class OrbNode extends Orb {

  OrbNode next;
  OrbNode previous;

  OrbNode() {
    next = previous = null;
  }//default constructor
  OrbNode(float x, float y, float s, float m) {
    super(x, y, s, m);
    next = previous = null;
  }//constructor

  void display() {
    super.display();
    if (next != null) {
      float dnext = this.center.dist(next.center);
      if (dnext < SPRING_LENGTH) { stroke(0, 255, 0); }
      else if (dnext > SPRING_LENGTH) { stroke(255, 0, 0); }
      else { stroke(0); }
      line(this.center.x, this.center.y+2, next.center.x, next.center.y+2);
    }//next spring

    if (previous != null) {
      float dprev = this.center.dist(previous.center);
      if (dprev < SPRING_LENGTH) { stroke(0, 255, 0); }
      else if (dprev > SPRING_LENGTH) { stroke(255, 0, 0); }
      else { stroke(0); }
      line(this.center.x, this.center.y-2, previous.center.x, previous.center.y-2);
    }//next spring
  }//drawSpring

  void applySprings(int springLength, float springK) {
    if (next != null) {
      PVector sforce = getSpring(next, springLength, springK);
      applyForce(sforce);
    }
    if (previous != null) {
      PVector sforce = getSpring(previous, springLength, springK);
      applyForce(sforce);
    }
  }///applySprings



}//OrbNode
