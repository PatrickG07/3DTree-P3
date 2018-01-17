import peasy.*;

Tree tree;

PeasyCam cam;

ArrayList<Snow> flakes = new ArrayList<Snow>();

float min_dist = 5;
float max_dist = 200;

float timeperiode = 0.85;
boolean winter = false;

// creates an scene with = 600, height = 900 and 3D
// PeasyCam is for moovment in the 3D Space
void setup() {
  size(600, 900, P3D);
  cam = new PeasyCam(this, 500);
  tree = new Tree();
  snwing();
}

void snwing(){
  for (int i = 0; i < 2000; i++) {
      flakes.add(new Snow());
      flakes.get(i).rotat = random(0, TWO_PI);
      flakes.get(i).r = random(5, 20);
      //leaves.get(i).grav = 20;
    }
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
    // if the Snow is in the air and it is the chousen one it will start to fall
    if(x < 10 && !tree.leaves.get(index).ground && !winter){
      tree.leaves.get(index).gravY = abs(map(tree.leaves.get(index).pos.y, tree.leaves.get(index).startPos.y, height / 2, 1, 4));  
      tree.leaves.get(index).falling = true;
    }else if(x < 10 && !flakes.get(index).ground && winter){
      flakes.get(index).gravY = abs(map(flakes.get(index).pos.y, tree.leaves.get(index).startPos.y, height / 2, 1, 4));  
      flakes.get(index).falling = true;
    }
    
    // if it is winter all Leafs will fall
    if(winter){
      for (Leaf l : tree.leaves) {
        x = random(0, 20);
        if(l.ground == false && x <= 1){
          l.gravY = abs(map(l.pos.y, l.startPos.y, height / 2, 1, 4));
          l.falling = true;
        }
      }
    }
  }
  
  // timeperiode for an Year, Sommer = Leafs falling and no Snow / Winter = no leafs on Tree and Snow falling
  if(timeperiode >= 1.2){
    background(#7F7FFF);
    timeperiode = 0;
    winter = false;
  }else if(timeperiode >= 0.9){
    winter = true;
    tree.snowing = true;
    background(#dddddd);
  }else{
    winter = false;
    tree.snowing = false;
    background(#7F7FFF);
  }
  // show all Snow particle
  for (Snow s : flakes) {
    s.show();
  }
  tree.show();
  tree.grow();
  
  int hei = height / 2;
  
  // when the Leaf or Snow hits the ground to stop the leaf
  for (Leaf l : tree.leaves) {
    if(l.pos.y >= hei){
      l.gravY = 0;
      l.ground = true;
      l.falling = false;
    }
  }
  for (Snow s : flakes) {
    if(s.pos.y >= hei){
      s.gravY = 0;
      s.ground = true;
      s.falling = false;
    }
  }
  
  float x = random(0, 2);
  int index = int(random(0, 2000));
  
  // if the Leaf or Snow is on the ground to set the Leaf back up to its original position
  if(x < 10 && tree.leaves.get(index).ground && !winter || timeperiode <= 0.3 && x <= 1 && tree.leaves.get(index).ground){
    tree.leaves.get(index).pos.x = tree.leaves.get(index).startPos.x;
    tree.leaves.get(index).pos.y = tree.leaves.get(index).startPos.y;
    tree.leaves.get(index).pos.z = tree.leaves.get(index).startPos.z;
    tree.leaves.get(index).ground = false;
    tree.leaves.get(index).falling = false;
    tree.leaves.get(index).red = 0;
    tree.leaves.get(index).green = random(50, 255);
    tree.leaves.get(index).blue = 0;
  }else if(x < 10 && flakes.get(index).ground && winter || timeperiode >= 0.9 && x <= 1.5 && flakes.get(index).ground){
    flakes.get(index).pos.x = flakes.get(index).startPos.x;
    flakes.get(index).pos.y = flakes.get(index).startPos.y;
    flakes.get(index).pos.z = flakes.get(index).startPos.z;
    flakes.get(index).ground = false;
    flakes.get(index).falling = false;
  }
  
  // wind for every Leaf and Snow that is falling
  for (int i = 0; i < 2000; i++) {
    if(tree.leaves.get(i).falling){
      tree.leaves.get(i).windX = random(-3, 3);
      tree.leaves.get(i).windZ = random(-3, 3);
    }
    if(tree.leaves.get(i).falling){
      flakes.get(i).windX = random(-3, 3);
      flakes.get(i).windZ = random(-3, 3);
    }
  }
}