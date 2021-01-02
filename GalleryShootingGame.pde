import java.util.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import processing.sound.*;
int state = 0;
String playerName = "";
String filename;
ArrayList<PVector> clicks = new ArrayList();
ArrayList<Cross> crosses = new ArrayList();
ArrayList<Snowman> snowmans = new ArrayList();
ArrayList<Tree> trees = new ArrayList();
color blue1 = color(71, 132, 191);
color green1 = color(155, 188, 127);
color orange1 = color(255, 157, 57);
color purple1 = color(228, 215, 234);
color white1 = color(200);
Board board = new Board(filename);
Button displaystart = new Button(400, 400, false, color(255, 142, 3), "Start Game");
Button displayins = new Button(400, 500, false, color(151, 119, 222), "See Rules (1)");
Button displaysb = new Button(400, 600, false, color(145, 178, 135), "See High Scores (2)");
Button displayhome = new Button(400, 550, false, color(71, 132, 160), "Go Back");
Button displayrestart = new Button(400, 680, false, color(71, 132, 160), "Restart");
Timer timer;
boolean isPause = false; //pause timer for game
boolean muted = false; //control gun shot sound
Score score;
SoundFile song;
SoundFile sound;
Button bsound = new Button(110, 40, false, color(218, 218, 218), "MUTE SOUND");

void setup() { 
  size(800, 800);
  textSize(24); 
  filename = "allrecords.txt";
  board.readRecord();
  song = new SoundFile(this,"Bells.wav");
  sound = new SoundFile(this, "shooting.mp3");
  song.loop();
}
 
void draw() {
  background(0);
  textSize(28);
  textAlign(CENTER);
  fill(255);
  text("Gallery Shooting Game", width/2, 50);
  bsound.drawButton();
  bsound.check();
  switch (state){
  case 0: //welcome scene
  textSize(22);
  fill(247, 232, 62);
  text ("Please enter your name to start \n (Hit enter or the button below ↓ \n Hit 0 to clear input)", width/2, 160); 
  fill(138, 235, 245);
  text("\n"+playerName, 360, 270);
  fill(255);
  addTargets();
  timer = new Timer(15);
  score = new Score(10);   
  displaystart.check();
  displaystart.drawButton();
  displayins.check();
  displayins.drawButton();
  displaysb.check();
  displaysb.drawButton();
  board.showError();
  break;
  
  case 1: //playing scene
  stroke(255);
  strokeWeight(2); 
  line(120, 240, 680, 240); //draw the three horizontal white lines
  line(80, 400, 720, 400);
  line(40, 560, 760, 560);
  stroke(0);
  for ( int j = 0; j < crosses.size(); j++){
    crosses.get(j).display(); // display all crosses
  }
  for ( int k = 0; k < snowmans.size(); k++){
    snowmans.get(k).display(); // display all crosses
    snowmans.get(k).move();
  }
  for ( int m = 0; m < trees.size(); m++){
    trees.get(m).display(); // display all crosses
  }
  
  // reticle
  strokeWeight(1);
  noFill();
  stroke(240);
  ellipse(mouseX, mouseY, 50, 50); //outer circle
  line(mouseX-24, mouseY, mouseX+24, mouseY);
  line(mouseX, mouseY-24, mouseX, mouseY+24);
  fill(255, 0, 0); //fil inner circle
  ellipse(mouseX, mouseY, 15, 15);
  // draw aim, the red dots
  for( int i = 0; i < clicks.size(); i++){
    ellipse(clicks.get(i).x, clicks.get(i).y, 15, 15);
  } 
  score.display();
  if (score.tries == 0){ //no more tries 
    state = 2;
  } 
  if (timer.second() == 0){ //times up
    state = 2;
  }
  break;
  
  case 2: //result scene
  if (score.correct == 12){
    score.end();
  }
  else if (score.tries == 0){ //no more tries
    score.noMoreTries();  
  }
  else if (timer.second() == 0){ //times up
    score.noMoreTime();
    timer.done = true;
  } else if (timer.done){
    score.noMoreTime();
  }
  board.displayTopFive(width/2, 330, 20);
  displayrestart.drawButton();
  displayrestart.check();
  break;
  
  case 3: //display high scores from welcome scene
  fill(93, 255, 170);
  board.displayTopFive(width/2, 200, 24);
  displayhome.drawButton();
  displayhome.check();
  break;
  
  case 4: //display instructions from welcome scene
  textSize(20);
  fill(93, 255, 170);
  text("There will be a total of nine targets to shoot. \n Each movable target account for two points  \n while each stable target is worth one point.", width/2, 150);
  text("During the game, you can press the down \n arrow to pause and start or press the \n up arrow key to restart the game. ", width/2, 360);
  fill(191);
  text("There is a 15 second timer for each round. \n You will be ranked by the points you got.", width/2, 260);
  text("You can see tries left, points earned, \n and time remaining in the bottom.", width/2, 460);
  displayhome.check();
  displayhome.drawButton();
  break;
  }
}

void mouseClicked(){
  if (state == 0){ //welcome scene
    if (displaysb.hoverRect){ //go to display scoreboard/ top 5 scores
      state = 3;
      displaysb.hoverRect =false;
    }
    if (displayins.hoverRect){ //go to display instructions/ rules
      state = 4;
      displayins.hoverRect =false;
    }
    if (displaystart.hoverRect){ //check player name before starting game
      if (int(playerName.length()) > 0){
        state = 1;
        displaystart.hoverRect =false;
        timer.start(); 
        board.enterEmpty = false;   
      } else {
        board.t = 0; //show error message of empty player name
        board.enterEmpty = true;        
      }          
    }
  }
  if (state == 2){ //result scene with go back function
    if (displayrestart.hoverRect){
      state = 0;
      playerName = "";  
      displayrestart.hoverRect = false;
      board.added = false;
    }
  }
  if (state == 3){ //display high scores from welcome scene
    if (displayhome.hoverRect){
      state = 0;
      displayhome.hoverRect = false;
    }
  }
  if (state == 4){ //display instructions from welcome scene
    if (displayhome.hoverRect){
      state = 0;
      displayhome.hoverRect = false;
    }
  }
}
 
void mouseReleased() { 
  if (isPause){
    return;
  }
  if (state == 1){ //add and check clicks, check score in playing scene
    if (bsound.rectCheck(100, 40)!=true){ //if not click on mute sound
      muteGunShot();
      clicks.add( new PVector( mouseX, mouseY, millis() ) );
      score.tries -= 1;
    }
    for ( int j = 0; j < crosses.size(); j++){ // check crosses mouse clicks
      crosses.get(j).checkMouseClick(mouseX, mouseY);
    }
    for ( int k = 0; k < snowmans.size(); k++){ // check crosses mouse clicks
      snowmans.get(k).checkMouseClick(mouseX, mouseY);
    }
    for ( int m = 0; m < trees.size(); m++){ // check crosses mouse clicks
      trees.get(m).checkMouseClick(mouseX, mouseY);
    }
    if (score.correct == 12){ //terminate the game once player got all targets
      state = 2;
    }
  }
  if (bsound.rectCheck(100, 40)==true) { //check toggle music
    if ( song.isPlaying() ) //click on toggle music when playing
    {
      muted = true; //mute music
      song.pause();
      bsound.UpdateText();
    }
    else
    {    
      muted = false;
      song.loop(); //unmute music
      bsound.UpdateText();
    }
  }
}

void keyReleased(){ 
  if (state == 1){ //allow pause the game during game
    if (key == CODED) { 
      if (keyCode == DOWN) { //down arrow to pause the game
        if (isPause == false){
          score.pause(); //disable any mouse clicking on targets
          song.pause();
          muted = true;
          timer.stop();
          isPause = true;
        } else if (isPause == true){
          score.resume();
          song.loop(); 
          muted = false;
          timer.resume(); 
          isPause = false;
        }
      }
    }
  }
  
  if ((state == 1) | (state == 2)){ //allow restart during game and after game
    if (key == CODED) { 
      if (keyCode == UP){ // start new game
        loop();    
        board.enterEmpty = false;
        state = 0;
        board.added = false;
        playerName = "";   
      }
    }
  }
  
  if (state == 0){
    if (key==ENTER||key==RETURN) { //make sure player name typed before starting game
      if (int(playerName.length()) > 0){
        state++;
        timer.start();        
      } else{        
        board.t = 0;  
        board.enterEmpty = true; 
      }
    } else {
      if ((state == 0) & (key == CODED)){ //display error message of typed not allowed character
        board.t = 1;   
        playerName = "";
        board.enterEmpty = true; 
      } 
      else if (key == '0'){ //clear playername typed
        playerName = "";
        board.t = 2;   
        board.enterEmpty = true; 
      }
      else if (key == '1'){ //display rules
        state = 4; //rules
      }
      else if (key == '2'){ // display high scores
        state = 3; //high scores
      }
      else {
        board.enterEmpty = false; 
        playerName = playerName + key;      
      }
    }
  } 
}

void addTargets(){
  clicks.clear();
  crosses.clear();
  snowmans.clear();
  trees.clear();
  crosses.add(new Cross(160, 205, blue1, 2));
  crosses.add(new Cross(500, 205, green1, -1.5));
  crosses.add(new Cross(140, 520, orange1, -1));
  snowmans.add (new Snowman(120, 330, white1, 500));
  snowmans.add (new Snowman(640, 330, purple1, 680));
  snowmans.add (new Snowman(300, 490, white1, 500));
  trees.add(new Tree(300, 170));
  trees.add(new Tree(580, 330));
  trees.add(new Tree(660, 490));
}

void muteGunShot(){
  if (muted == false){
    sound.play(0.8, 0.5);
  }
}
