class Tree {
  float x, y;
  boolean found = false;
  boolean canCheck = true;
  
  Tree (float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void display(){
    strokeWeight(0.01);
    pushMatrix();
    translate(x, y);
    fill(137, 100, 90);  //stump
    rect(0, 60, 8, 6); 
    fill(255, 0, 0);
    
    fill(60, 100, 58); //bottom
    arc(0, 0, 110, 110, radians(60), radians(120));
    
    fill(78, 118, 75); //middle
    arc(0, 0, 80, 80, radians(50), radians(130));
    
    fill(108, 160, 105); ///top
    arc(0, 0, 50, 50, radians(40), radians(140));
    popMatrix();
  }
  
  void checkMouseClick(int mx, int my){
    if ((found == false) & (canCheck == true)){
      if ((my > y + 50) & (my < y + 65)){ // check click on stump
        if ((mx < x + 5) & (mx > x - 5)){
          score.correct += 1;
          found = true;
          canCheck = false;
        }
      }
      else if ((my > y) & (my < y + 20)){
        if (dist(mx, my, x, y) < 20){
          score.correct += 1;
          found = true;
          canCheck = false;
        }
      }
      else if ((my > y) & (my < y + 40)){
        if (dist(mx, my, x, y) < 40){
          score.correct += 1;
          found = true;
          canCheck = false;
        }
      }
      else if ((my > y) & (my < y + 60)){
        if (dist(mx, my, x, y) < 60){
          score.correct += 1;
          found = true;
          canCheck = false;
        }
      }
    }
  }
}
