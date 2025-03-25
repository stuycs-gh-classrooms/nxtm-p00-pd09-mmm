class FixedOrb extends Orb {

  FixedOrb(float x, float y, float s, float m) {
    super(x, y, s, m);
    c = color(255, 0, 0);
  }

  FixedOrb() {
    super();
    c = color(255, 0, 0);
  }

  void move(boolean bounce) {
    //do nothing
  }

}//fixedOrb
