class Cross {
  float x, y;
  color c;
  float angle = 0;
  float speed;
  boolean found = false;
  boolean canCheck = true;
  
  Cross (float x, float y, color c, float speed){
    this.x = x;
    this.y = y;
    this.c = c;
    this.speed = speed;
  }
  
  void display(){
    fill(c);
    strokeWeight(0.01);
    angle += speed;
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    rectMode(RADIUS); //half width and height
    rect(0, 0, 15, 30);
    rect(0, 0, 30, 15);
    popMatrix();
  }
  
  void checkMouseClick(int mx, int my){
    if ((found == false) & (canCheck == true)){
      if ((my < y + 15) & (my > y - 15)){
        if ((mx < x + 30) & (mx > x - 30)){
          score.correct += 1;
          found = true;
          canCheck = false;
          speed = 0;
        }
      } 
      else if ((my < y + 30) & (my > y - 30)){
        if ((mx < x + 15) & (mx > x - 15)){
          score.correct += 1;
          found = true;
          canCheck = false;
          speed = 0;
        }
      }
    }
  }
}
