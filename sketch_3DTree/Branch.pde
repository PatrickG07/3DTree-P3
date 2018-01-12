class Branch {
  Branch parent;
  PVector pos;
  PVector dir;
  int count = 0;
  PVector saveDir;
  float len = 5;
  
  // creates the first Branch by given position and direction
  Branch(PVector v, PVector d) {
    parent = null;
    pos = v.copy();
    dir = d.copy();
    saveDir = dir.copy();
  }
  
  // creates the Branch with the last Brand Position as Parent
  // and go forward by dir (direction) from parents dir
  Branch(Branch p) {
    parent = p;
    pos = parent.next();
    dir = parent.dir.copy();
    saveDir = dir.copy();
  }

  // for each the Branch change the count to 0 and copy the direction
  void reset() {
    count = 0;
    dir = saveDir.copy();
  }

  // moving forwart to an positon wiht the direction
  PVector next() {
    PVector v = PVector.mult(dir, len);
    PVector next = PVector.add(pos, v);
    return next;
  }
}