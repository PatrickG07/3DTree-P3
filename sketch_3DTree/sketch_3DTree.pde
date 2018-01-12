import peasy.*;

Tree tree;

PeasyCam cam;

float min_dist = 5;
float max_dist = 200;

float timeperiode = 0;
boolean winter = false;

// creates an scene with = 600, height = 900 and 3D
// PeasyCam is for moovment in the 3D Space
void setup() {
  size(600, 900, P3D);
  cam = new PeasyCam(this, 500);
  tree = new Tree();
}

// drawing the Tree / Leafs and Branches
void draw() {
  timeperiode += 0.0001;
  //println(timeperiode);
  
  
  // if the Branch has Reacht all Leafs the Leafs will random fall
  if(tree.number >= 4000){

    float x = random(0, 100);
    int index = int(random(0, tree.leaves.size()));
    
    // if the Leaf is on the tree and it is the chousen one it will start to fall
    if(x < 10 && tree.leaves.get(index).ground == false && winter == false){
      tree.leaves.get(index).gravY = abs(map(tree.leaves.get(index).pos.y, tree.leaves.get(index).startY, height / 2, 1, 4));  
      tree.leaves.get(index).falling = true;
    }
    
    // if it is winter all Leafs will fall
    if(winter == true){
      for (Leaf l : tree.leaves) {
        x = random(0, 20);
        if(l.ground == false && x <= 1){
          l.gravY = abs(map(l.pos.y, l.startY, height / 2, 1, 4));
          l.falling = true;
        }
      }
    }
  }
  
  // timeperiode for an Year Leafs Sommer = falling / Winter = no leafs on Tree
  if(timeperiode >= 1.2){
    background(#7F7FFF);
    timeperiode = 0;
    winter = false;
  }else if(timeperiode >= 0.9){
    winter = true;
    background(#ffffff);
  }else{
    background(#7F7FFF);
  }
  
  tree.show();
  tree.grow();
  
  // when the Leaf hits the ground to stop the leaf
  for (Leaf l : tree.leaves) {
    if(l.pos.y >= height / 2){
      l.gravY = 0;
      l.ground = true;
      l.falling = false;
    }
  }
  
  float x = random(0, 2);
  int index = int(random(0, tree.leaves.size()));
  
  // if the Leaf is on the ground to set the Leaf back up to its original position
  if(x < 10 && tree.leaves.get(index).ground == true && winter == false || timeperiode <= 0.3 && x <= 1 && tree.leaves.get(index).ground == true){
    tree.leaves.get(index).pos.x = tree.leaves.get(index).startX;
    tree.leaves.get(index).pos.y = tree.leaves.get(index).startY;
    tree.leaves.get(index).pos.z = tree.leaves.get(index).startZ;
    tree.leaves.get(index).ground = false;
    tree.leaves.get(index).falling = false;
    tree.leaves.get(index).red = 0;
    tree.leaves.get(index).green = random(50, 255);
    tree.leaves.get(index).blue = 0;
  }
  
  // wind for every Leaf that is falling
  for (Leaf l : tree.leaves) {
    if(l.falling == true){
      l.windX = random(-3, 3);
      l.windZ = random(-3, 3);
    }
  }
}