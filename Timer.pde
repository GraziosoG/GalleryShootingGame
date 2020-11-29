class Timer {
  int countdown;
  int startTime = 0, stopTime = 0, past = 0;
  boolean running = false; 
  boolean resume = false;
  
  Timer (int countdown){
    this.countdown = countdown;
  }
  
  void start() {
    startTime = millis();
    running = true;
  }
  
  void resume(){
    //running = true;  
    resume = true;
    startTime = millis();
  }
  
  void stop() {
    stopTime = millis();
    past += stopTime - startTime;
    running = false;
    resume = false;
  }
  
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    } else if (resume){
      //elapsed = (past); 
      elapsed = ((millis() - startTime) + past);

    }
    else {
      elapsed = (past);
    }
    return elapsed;
  }
  
  int second() {
    return (countdown - (getElapsedTime() / 1000) % 60); //get second remainder
  }
  
  int minute() {
    return (getElapsedTime() / (1000*60)) % 60; // get minute remainder
  }
}
