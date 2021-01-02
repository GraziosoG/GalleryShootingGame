class Score {
  int correct = 0; //points earned
  int tries; //used to count tries left
  int total_tries; //tries available to players
  int crossget = 0;
  int snowmanget = 0;
  int treeget = 0;

  Score (int tries){
    this.tries = tries;
    this.total_tries = tries;
  }
  
  void display(){
    textSize(20);
    fill(255);
    text("Tries Left: " + nf(score.tries), 550, 700);
    text("Points Earned: " + nf(score.correct), 550, 730);
    fill(255);
    text("Seconds remaining: " + nf(timer.second(), 3), 200, 730);
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
    text("Press down arrow to continue the game", width/2, 90);
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
    if (!board.added){
      board.writeRecord(playerName, correct);
    }
    fill(255);
    fill(138, 235, 245);
    textSize(24);
    text("Player:  " + playerName, width/2, 95);
    text("You used " + (total_tries - tries) + " tries and earned " + correct + " points", width/2, 140);
    text("Targets Captured  Crosses: " + crossget + "  Snowmen: " + snowmanget + "  Tree: " + treeget, width/2, 170);
    textSize(22);
    fill(255, 0, 0);
    if (correct == 12){
      text("Congratulations! You won the game!", width/2, 245);
    } else {
      text("Sorry you did not get all the targets, nice try!", width/2, 245);
    }
    textSize(20);
    fill(247, 232, 62);
    text("Press the up arrow to start a new game", width/2, 590);    
    fill(255);
    textSize(20);
  }
  
  void noMoreTries(){   
    end();
    textSize(20);
    text("You have used up all of your tries", width/2, 200);
  }
  
  void noMoreTime(){   
    end();
    textSize(20);
    text("You ran out of time", width/2, 200);
  }
}
