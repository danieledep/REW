class Wheel {
  float x;
  float y;
  float speed;
  int direction = 0;
  
  
  // 1: left
  // 2: up
  // 3: right
  // 4: down
  
  
  float w = 25;      //size of the wheel
  float w2 = 35;    // size of the wheel when jumping
  int state=0;
    
  // 0: never moved
  // 1: moving
  // 2: stopped
  // 3: jumping
  
  
   int jumpTime = 300;
  Timer jumping;


  Wheel (float x, float y) {
    this.x = x;
    this.y=y;
    this.speed = 1+(gamePlay.level);
    
  }
  
  
  void move() {
 
 if (this.state == 3) {  
 if (jumping.isFinished()) this.state = 1;     //after jump back to normal moving
 }
 
 if (this.state==1 || this.state == 3) {   
    switch (this.direction) {
        
        case 1 : this.x = this.x-this.speed;
                 break;
        case 2 : this.y = this.y-this.speed;
                 break;
        case 3 : this.x = this.x+this.speed;
                 break;
        case 4 : this.y = this.y+this.speed;
                 break;           
        default: break;
        
        }
    }
    // AWSD arrows controllers for the wheel
    
    
    }
  
  
  
  void display() {
    fill(0);
    if (this.state==3) {
                        //ellipse(this.x, this.y, this.w2, this.w2);
                        image (wheelBg, this.x-this.w2/2, this.y-this.w2/2);
                        gamePlay.release ();          // release tape when jumping
                        }
    else {
         // ellipse(this.x, this.y, this.w, this.w);
         image (wheelIm, this.x-this.w/2, this.y-this.w/2);
         }
  }
  
  
  void setDirection() {
    
     if (this.state == 0 || this.state == 1) {
      switch (keyCode) {
        
        case LEFT : this.direction = 1;
                   this.state=1;
                   break;
        case UP : this.direction = 2;
                   this.state=1;
                   break;
        case RIGHT : this.direction = 3;
                   this.state=1;
                   break;
        case DOWN : this.direction = 4;
                   this.state=1;
                   break; 
        case 'B' : this.state = 2;
                   break;
        case ' ' : if (this.state==1) {                  // if you are already moving 
                   this.state = 3;                        // start jump
                   jumping = new Timer (jumpTime);        // timer one second
                   jumping.start();
                   }
                   break;        
        default: break;
        
        }
    
    // AWSD arrows controllers for the wheel
    
    }
    }
    
    void stopBall () {
      
      this.state=2;
    }
    
    
    
}
