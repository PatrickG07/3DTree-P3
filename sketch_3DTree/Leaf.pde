class Leaf{

  PVector startPos;
  PVector pos;
  
  float gravY = 0;
  float windX = 0;
  float windZ = 0;
  float rotat;
  float r;
  float red = 0;
  float green = 0;
  float blue = 0;
  
  boolean ground = false;
  boolean reached = false;
  boolean falling = false;
  boolean k = false;
  
  int ranR = 0;
  int ranG = 0;
  int ranB = 0;

  // creates an Leaf at a random Position with a random height
  Leaf() {
    pos = PVector.random3D();
    startPos = PVector.random3D();
    pos.mult(random(width/2));
    pos.y -= height/4;
  }

  // has the Branch reached the Leaf
  void reached() {
    reached = true;
  }

  // showing the Leaf and its movement
  void show() {
    pos.y += gravY;
    pos.x += windX;
    pos.z += windZ;
    
    // when it is falling its rotating randomli
    if(gravY > 0 && ground == false && falling == true){
      rotat = random(0, TWO_PI);
      // saves the position and it creates an random Brown collor with RGB only once
      if(!k){
        ranR = int(random(43, 146));
        ranG = int(random(29, 98));
        ranB = int(random(17, 57));
        startPos.x = pos.x;
        startPos.y = pos.y;
        startPos.z = pos.z;
        k = true;
      }

      // when it is falling it will change the color from green to a random Brown while it is falling 
      red = map(pos.y, startPos.y, height / 2, 0, ranR);
      green = map(pos.y, startPos.y, height / 2, green, ranG);
      blue = map(pos.y, startPos.y, height / 2, 0, ranB);
    }
    
    // when it is not Falling the wind will be 0
    if(falling == false){
      windX = 0;
      windZ = 0;
    }
    
    // creates the Leaf with fill = color, translate = set the center to that Leaf, rotate = rotation, ellipse = flat round object
    // sphere is to Laggy
    noStroke();
    fill(red, green, blue);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(rotat);
    rotateY(rotat);
    //sphere(r);
    ellipse(0,0, r, r);
    popMatrix();
  }
}