// rectangular button
class Button{
  float x;
  float y;
  float w;    
  float h;    
  boolean hoverRect;
  color c1;
  String message;
  
  Button(float x, float y, boolean hoverRect, color c1, String message){
    this.x = x;
    this.y = y;
    this.w = 105;
    this.h = 30;
    this.hoverRect = hoverRect;
    this.c1 = c1;
    this.message = message;
  }
  
  void drawButton() {
    if (this.hoverRect){
      fill(101);
    }
    else {
      fill(this.c1);
    }
    //fill(218);
    stroke(141);
    //textAlign(CENTER);
    rectMode(RADIUS);
    rect(x, y, w, h, 10);
    textSize(22);
    textAlign(CENTER, CENTER);
    fill(0);
    text(message, x, y);
  }
  
  void UpdateText(){
    if (message == "MUTE SOUND"){
      //println("muting");
      muted = true;
      message = "UNMUTE SOUND";
    } 
    else if (message == "UNMUTE SOUND") {
      //println("unmuting");
      muted = false;
      message = "MUTE SOUND";
    }
  }
  
  // check where mouse is, if above button, change value 
  void check(){
    if (rectCheck(this.x, this.y)){
      this.hoverRect = true;
    }
    else{
      this.hoverRect = false;
    }
  }
  
  // check if mouse is over rectangle
  boolean rectCheck(float x, float y){
    if (mouseX >= (x-w) && mouseX <= (x+w) 
    && mouseY >= (y-h) && mouseY <= (y+h)){
      return true;
    }
    else{
      return false;
    }
  }
}
