class Snowman {
  float x, y;
  color c;
  float eyex, eyey;
  float hatx, haty;
  float dir;
  float start, end, angle, anglehat;
  float angleChange = 1.2;
  float t = 1.5; //control horizontal movement
  boolean found = false;
  boolean canCheck = true;
  boolean moving = true;

  Snowman (float x, float y, color c, float end){
    this.x = x;
    this.y = y;
    this.c = c;
    this.eyex = 0;
    this.eyey = 0;
    this.hatx = 0;
    this.haty = 0;
    this.dir = 0.5;
    this.angle = 0;
    this.anglehat = 15;
    this.start = x;
    this.end = end;
  }
  
  void display(){
    fill(c);
    strokeWeight(0.001);
    rectMode(RADIUS); //half width and height
    ellipse(x, y, 40, 40); //top
    ellipse(x, y+40, 50, 50); //bottom   
    drawEyes();
    anglehat += angleChange;
    pushMatrix();
    drawHat(); 
    if (anglehat > 30 || anglehat < -20){
      angleChange = -angleChange;
      anglehat += angleChange;
    }
    popMatrix();
    line(x-5, y+9, x+5, y+9);
  }
  
  void drawEyes(){
    pushMatrix();
    translate(x, y);
    fill(0); //black
    ellipse(eyex-6, eyey, 10, 10);
    ellipse(eyex+6, eyey, 10, 10);
    fill(250); //white
    ellipse(eyex-7, eyey-2, 4, 4);
    ellipse(eyex+7, eyey-2, 4, 4);
    popMatrix();
    eyex += cos(radians(angle)) * dir;
    eyey += sin(radians(angle)) * dir;
    angle -= 6;
  }
  
  void drawHat(){
    pushMatrix();
    translate(x, y);
    rotate(radians(anglehat));
    fill(111, 101, 101); //brown
    strokeWeight(2);
    stroke(111, 101, 101);
    line(-30, -20, +30, -20);
    arc(0, -20, 30, 30, PI, 2*PI); //hat  
    popMatrix();
  }
  
  void move(){ //move horizontally
    if (moving == true){
      x += t;
      if (x >= end){
        x = end;
        t -= 1.5;
      } else if (x < start){
        x = start;
        t = 1.5;
      }
    }
  }
  
  void checkMouseClick(int mx, int my){
    if ((found == false) & (canCheck == true)){
      if (dist(mx, my, x, y) < 40){
        score.correct += 1;
        found = true;
        canCheck = false;
        moving = false;
      }
      else if (dist(mx, my, x, y+40) < 50){
        score.correct += 1;
        found = true;
        canCheck = false;
        moving = false;
      }
    }
  }
}
