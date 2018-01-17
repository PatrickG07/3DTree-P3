class Snow{
  PVector startPos;
  PVector pos;
  
  float gravY = 0;
  float windX = 0;
  float windZ = 0;
  float r;
  float rotat;
  
  boolean ground = false;
  boolean falling = false;
  boolean k = false;
  boolean winter = false;
  
  // creates an Snow flake at a random Position with a random height
  Snow(){
    pos = PVector.random3D();
    startPos = PVector.random3D();
    pos.mult(random(width));
    pos.y -= height;
  }
  
  // it will show the Snow flakes
  void show() {
    pos.y += gravY;
    pos.x += windX;
    pos.z += windZ;
  
    // adds gravitiy while falling
    if(gravY > 0 && !ground && falling){
      rotat = random(0, TWO_PI);
      // saves the position
      if(!k){
        startPos.x = pos.x;
        startPos.y = pos.y;
        startPos.z = pos.z;
        k = true;
      }
    }
    // no wind while not falling
    if(!falling){
      windX = 0;
      windZ = 0;
    }
    
    // if it is witer and the flake is falling and on the ground it will be drawn
    if(tree.snowing && falling || tree.snowing && ground){
      fill(255, 255, 255);
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      rotateX(rotat);
      rotateY(rotat);
      //sphere(r);
      ellipse(0,0, r, r);
      popMatrix();
    // if it is not winter / snowing and the flake is on the ground it will set back up and it will diapear
    }else if(!tree.snowing && ground){
      ground = false;
      pos = startPos;
      fill(0);
    }
  }
}