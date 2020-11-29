ArrayList<PVector> clicks = new ArrayList();
ArrayList<Cross> crosses = new ArrayList();
ArrayList<Snowman> snowmans = new ArrayList();
ArrayList<Tree> trees = new ArrayList();
color blue1 = color(71, 132, 191);
color green1 = color(155, 188, 127);
color orange1 = color(255, 157, 57);
color purple1 = color(228, 215, 234);
color white1 = color(200);
Timer timer;
boolean isPause = false;
Score score;

void setup() { 
  size(800, 800);
  textSize(24);
  crosses.add(new Cross(160, 165, blue1, 2));
  crosses.add(new Cross(500, 165, green1, -1.5));
  crosses.add(new Cross(140, 480, orange1, -1));
  snowmans.add (new Snowman(120, 290, white1, 500));
  snowmans.add (new Snowman(640, 290, purple1, 680));
  snowmans.add (new Snowman(300, 450, white1, 500));
  trees.add(new Tree(300, 130));
  trees.add(new Tree(580, 290));
  trees.add(new Tree(660, 450));
  timer = new Timer(15);
  timer.start();
  score = new Score(10);
}
 
void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  line(120, 200, 680, 200);
  line(80, 360, 720, 360);
  line(40, 520, 760, 520);
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
  
  // draw aim
  for( int i = 0; i < clicks.size(); i++){
    ellipse(clicks.get(i).x, clicks.get(i).y, 15, 15);
  }
  
  score.display();
  if (score.tries == 0){
    score.end();
    text("You have used up all of your tries", 220, 150);
  }
  text("Gallery Shooting Game", 260, 50);
  
  // timer
  text("Seconds remaining: " + nf(timer.second(), 3), 80, 700);
  if (timer.second() == 0){
    score.end();
  }
}
 
void mouseClicked() {
  clicks.add( new PVector( mouseX, mouseY, millis() ) );
  for ( int j = 0; j < crosses.size(); j++){ // check crosses mouse clicks
    crosses.get(j).checkMouseClick(mouseX, mouseY);
  }
  for ( int k = 0; k < snowmans.size(); k++){ // check crosses mouse clicks
    snowmans.get(k).checkMouseClick(mouseX, mouseY);
  }
  for ( int m = 0; m < trees.size(); m++){ // check crosses mouse clicks
    trees.get(m).checkMouseClick(mouseX, mouseY);
  }
  score.tries -= 1;
}

void keyReleased(){
  if (key == CODED) {
    if (keyCode == DOWN) {
      if (isPause == false){
        score.pause(); //disable any mouse clicking on targets
        timer.stop();
        isPause = true;
      } else if (isPause == true){
        score.resume();
        timer.resume(); 
        isPause = false;
      }
    }
    if (keyCode == RIGHT){
      loop();
      clicks.clear();
      crosses.clear();
      snowmans.clear();
      trees.clear();
      crosses.add(new Cross(160, 165, blue1, 2));
      crosses.add(new Cross(500, 165, green1, -1.5));
      crosses.add(new Cross(140, 480, orange1, -1));
      snowmans.add (new Snowman(120, 290, white1, 500));
      snowmans.add (new Snowman(640, 290, purple1, 680));
      snowmans.add (new Snowman(300, 450, white1, 500));
      trees.add(new Tree(300, 130));
      trees.add(new Tree(580, 290));
      trees.add(new Tree(660, 450));
      timer = new Timer(15);
      timer.start();
      score = new Score(10);
    }
  }
}
