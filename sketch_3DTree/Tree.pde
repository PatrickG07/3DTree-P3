class Tree {
  
  boolean snowing;
  
  int number = 0;
  ArrayList<Branch> branches = new ArrayList<Branch>();
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();

  Tree() {
    // creates the Leaf object with a random rotat = rotation, r = ratius and a green color
    for (int i = 0; i < 2000; i++) {
      leaves.add(new Leaf());
      leaves.get(i).rotat = random(0, TWO_PI);
      leaves.get(i).r = random(5, 20);
      leaves.get(i).green = random(50, 255);
      //leaves.get(i).grav = 20;
    }
    
    // creates the first Brach at the bottom
    // saves the Branch in an Array and creates an new Branch that is the current
    Branch root = new Branch(new PVector(0, height/2), new PVector(0, -1));
    branches.add(root);
    Branch current = new Branch(root);

    // if a Branch is close enough to a Leaf it will create an new Branch adding it to Array and saves that as current
    while (!closeEnough(current)) {
      Branch trunk = new Branch(current);
      branches.add(trunk);
      current = trunk;
    }
  }

  // checks each leaf if is close enough
  boolean closeEnough(Branch b) {
    for (Leaf l : leaves) {
      float d = PVector.dist(b.pos, l.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  // 
  void grow() {
    // checks each Leaf
    for (Leaf l : leaves) {
      // if the Leaf was not reached jet
      if (!l.reached) {
        Branch closest = null;
        PVector closestDir = null;
        float record = -1;
        
        // check each Branche
        for (Branch b : branches) {
          PVector dir = PVector.sub(l.pos, b.pos);
          float d = dir.mag();
          // if min distance true then change the Leaf reached to true and break out to the next Leaf
          if (d < min_dist) {
            l.reached();
            closest = null;
            break;
          }
          // if it is to far away check the next Branch
          else if (d > max_dist) {
            
          }
          // if no Leaf is not close by or distace betwen Leaf and Branch is smaler then record
          // then set that this Branche is close to an Leaf 
          else if (closest == null || d < record) {
            closest = b;
            closestDir = dir;
            record = d;
          }
        }
        
        // if a Leaf is close by then pull that Brach to that Leaf and cout it up
        if (closest != null) {
          closestDir.normalize();
          closest.dir.add(closestDir);
          closest.count++;
        }
      }
    }
    
    // go through all Leaf and if that Leaf is reached then count the number up
    for (Leaf l : leaves) {
      if(l.reached == true){
        number++;
      }
    }

    // go through every element in the Array branches
    for (int i = branches.size()-1; i >= 0; i--) {
      Branch b = branches.get(i);
      // if Branch number is bigger then 0 then create a New Branch
      if (b.count > 0) {
        b.dir.div(b.count);
        PVector rand = PVector.random2D();
        rand.setMag(0.3);
        b.dir.add(rand);
        b.dir.normalize();
        Branch newB = new Branch(b);
        branches.add(newB);
        b.reset();
      }
    }
  }

  // creates the Leafs
  void show() {
    for (Leaf l : leaves) {
      l.show();
    }
    
    // creates each Branch
    //for (Branch b : branches) {
    for (int i = 0; i < branches.size(); i++) {
      Branch b = branches.get(i);
      if (b.parent != null) {
        float sw = map(i, 2, branches.size(), 6, 0);
        strokeWeight(sw);
        stroke(#614126);
        line(b.pos.x, b.pos.y, b.pos.z, b.parent.pos.x, b.parent.pos.y, b.parent.pos.z);
      }
    }
  }
}