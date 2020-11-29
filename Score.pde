class Score {
  int correct = 0;
  int tries;

  Score (int tries){
    this.tries = tries;
  }
  
  void display(){
    textSize(20);
    fill(255);
    text("Tries Left: " + nf(score.tries), 500, 700);
    text("Correct: " + nf(score.correct), 500, 730);
  }
  
  void pause(){
    noLoop();
    for ( int j = 0; j < crosses.size(); j++){ // check crosses mouse clicks
      crosses.get(j).canCheck = false;
    }
    for ( int k = 0; k < snowmans.size(); k++){ // check crosses mouse clicks
      snowmans.get(k).canCheck = false;
    }
    for ( int m = 0; m < trees.size(); m++){ // check crosses mouse clicks
      trees.get(m).canCheck = false;
    }
    text("Press down arrow to continue the game", 200, 100);
  }
  
  void resume(){
    loop();
    for ( int j = 0; j < crosses.size(); j++){ // check crosses mouse clicks
      if (crosses.get(j).found == false){
        crosses.get(j).canCheck = true;
      }    
    }
    for ( int k = 0; k < snowmans.size(); k++){ // check crosses mouse clicks
      if (snowmans.get(k).found == false){
        snowmans.get(k).canCheck = true;
      } 
    }
    for ( int m = 0; m < trees.size(); m++){ // check crosses mouse clicks
      if (trees.get(m).found == false){
        trees.get(m).canCheck = true;
      }    
    }
  }
  
  void end(){
    noLoop();  
    background(200);
    fill(0);
    text("Gallery Shooting Game", 260, 50);
    text("Press the right arrow to start a new game", 200, 100);
    //print if won or not (got all targets)
    //print game statistics
    //keyboard function to start new game maybe do it in keyReleased in main
     
  }
}
