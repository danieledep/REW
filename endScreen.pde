
class EndScreen {
  
  
  // Constructor
  EndScreen() {
  }
  
  void update() {
    display();
  }
  
  void display() {
    
  /*  textSize(48);
    textAlign(CENTER);
    fill(255);
    text("Game Over", width/2, height/2);*/
   
    
  }
  
  void doKeyEvent() {
    if (keyCode == 10) {
      resetGame();
    }
  }
  
  void doMouseEvent() {
    
  }
}
