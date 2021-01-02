class Board{
  String filetxt;
  String[] lines;
  Integer t; //store error type
  Map<Integer, ArrayList<String>> records;
  boolean added = false;
  boolean enterEmpty = false;
  
  Board(String filetxt){
    this.filetxt = filetxt;
    //this.t = t;
    records = new HashMap<Integer, ArrayList<String>>();
  }
  
  void readRecord(){ //read the txt file
    records.clear();
    added = false;
    lines = loadStrings(filename);
    if (lines.length > 0){
      for (String line : lines)
      {
        //Split each line into name and score
        String [] splitted = split(line, ':');     
        String name = splitted[0];
        int score = int(splitted[1]);
        if (records.containsKey(score)){
          ArrayList<String> existed = records.get(score);
          existed.add(name);
          records.put(score, existed);
        } 
        else {
          ArrayList<String> innerNames = new ArrayList<String>(); //storing all names that have the score
          innerNames.add(name);
          records.put(score, innerNames); //prepare for scoreboard
        }
      }
    }
  }
  
  void writeRecord(String player, int playerScore){ //store new record and write all records
    if (added == true){
      return;
    }
    if (records.containsKey(playerScore)){
      ArrayList<String> existed = records.get(playerScore);
      existed.add(player);   
      Collections.reverse(existed);
      records.put(playerScore, existed);
    } 
    else {
      ArrayList<String> innerNames = new ArrayList<String>(); //storing all names that have the score
      innerNames.add(player);
      records.put(playerScore, innerNames); //prepare for scoreboard
    }
    File f = new File(dataPath(filename));
    if(!f.exists()){
      println("no file");
    }
    try {
      PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
      out.println(player + ":" + playerScore);
      out.close();
      added = true;
    }catch (IOException e){
      e.printStackTrace();
    } 
    return;
  }
  
  void showError(){
    if (enterEmpty == true){
      fill(255, 0, 0);
      if (t == 0){
        text("Do Not Leave Your Name Empty!", width/2, 240);    
      }  
      if (t == 1){
        text("Please enter letters for player name!", width/2, 240);    
      }
      if (t == 2){
        text("Player Name Cleared!", width/2, 240);    
      }
    } 
    fill(255);
  }
  
  /*void displayAll(){ //for debug, display all scores and player names in console
    for (Map.Entry view :records.entrySet()){
      println(view.getKey());
      println(view.getValue());
    }
  }*/
  
  void displayTopFive(int xpos, int ypos, int fontsize){
    textSize(fontsize);
    int count = 0;
    HashMap<String, Object> displayBoard = new HashMap<String, Object>();
    ArrayList<Integer> topscores = new ArrayList<Integer>(records.keySet()); // to store record scores from high to low
    Collections.reverse(topscores); // from high to low
    text("Top 5 High Scores", xpos, ypos);
    line(xpos - 180, ypos+24, xpos + 180, ypos+24);
    for (Object recordscore : topscores){
      for (int storedn = 0; storedn < records.get(recordscore).size(); storedn++){           
        if (count < 5){ // only store top 5, count from 0         
          String curname = records.get(recordscore).get(storedn).toString();
            displayBoard.put(curname, recordscore);
            count += 1;
          text(curname, xpos - 75, ypos + 10 + 35*count); 
          if ((int) recordscore > 9){ //print two digits in a pretty fashion
            text(recordscore.toString(), xpos + 75, ypos + 10 + 35*count);
          } else {
            text(recordscore.toString(), xpos + 75, ypos + 10 + 35*count);
          }             
        }
      }
    }
  }
}
