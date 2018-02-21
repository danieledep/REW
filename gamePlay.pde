class gamePlay {
  
 color [] colArray = { color(224,129,37), 
                       color(221,220,31),
                       color(24,160,219), 
                       color(59,180,73), 
                       color(135,92,166),
                       color(89,193,166),
                       color(219,45,42) };        //Colour variables
  int colorRound;
  
  float w = 25;      //size of the wheel
  float w2 = 35;    // size of the wheel when jumping
  float radius = w/2;
  int wheelTime = 3500; // time of regeneration of wheels 3000 millisecond 
  int [][] posArray = {{40,300}, // starting point of the wheels
                       {400,40}, 
                       {760,300},
                       {400, 500}};
  int pos;              // counter for posArray
  int runner;      // the index of the wheel moving
  float totDist;   // total lenght of tape
  
  
  Timer timer; 
  Wheel [] wheels = {};
  int gameStart;
  int gameStarted = 0; // check if the ball ever started moving
  
  // 0 : player hasn't moved yet
  // 1 : game is started
  
  
  Tape [] tapes = {};
  int section; // where the ball cross the tape
  int tapeState;
  
  // 0 : stopped
  // 1 : moving
  
  int crossed;
  
  // 0 : tape not crossed
  // 1 : tape crossed
  
  
  Timer levelUp;          // control the level of the game going up
  int levelTime = 15000;   // new level every 10 seconds
  int level=0;
  int wRect = 81;
  int hRect = 16;
  float loseIndex;        // index counting if you're making it
  float loseBar;             // bar showing progress
  float remaining;
  float timeIndex;
  
  
   gamePlay () {
    
    }
    
   void startGame () {
     
      colorRound = colArray [(int) random (0,4)];
      tint(colorRound);
      image (blankStrt, 0, 0);
     
      
      timer = new Timer(wheelTime);
      levelUp = new Timer (levelTime);
      level = 1;
      gameStart=millis();
      timer.start();
      levelUp.start();
      loseIndex=0;
      
      gameStarted = 0;
      totDist = 0;
      runner =0;
      pos = 0;
      wheels = new Wheel[0];
      tapes = new Tape[0];
      tapeState = 0;
      createTape ();
      createWheel ();
           
      
      }
  
  void update () {
    
       if (levelUp.isFinished()) {
                               
                               level++;
                               }
    
    
    if (timer.isFinished()) {
                
                wheels[runner].stopBall();  //stop the wheel when time runs out
                tapeState = 0;              //stop moving tape
                createWheel ();             // and create a new one
             
                }
     
                   
      display();
      
  
  }
  
  
  void display () {
    
      if (wheels[0].y < 520-w) gameStarted = 1;
    tint(colorRound);
    if (gameStarted == 0) image (blankStrt, 0, 0);
    else  {
      
      image (blankScr, 0, 0);
      strokeWeight (2);
      noFill();
      rect(359, 539, wRect, hRect);
    }
    
  
     image (wheelz,80, 518 ); 
    image (wheelz, 690, 518);
    
    textSize (20);
    fill (0);
    text (level, 303, 555);
    
    for (int i = 0; i < wheels.length; i++) {
      
     runner=i;
     wheels[i].move();
     wheels[i].display();
     checkBoundaries();
     checkHit();
     if (wheels[i].state == 1 && tapeState == 0)checkCross();
     if (tapeState == 1 && wheels[i].state == 1) movePoint(section);
     drawLine();
     
       //CHECK CODE
     /*
     for (int u = 0; u<tapes.length; u++) {
     textSize (10);
      textAlign (CENTER);
      fill (255);
       text (level,600, 50+u*10); 
      text (loseIndex,700, 50+u*10);
      text (levelUp.passedTime,750, 50+u*10);}*/
    
  }
  
       
  
  
  }
  
  void createWheel () {
  
 if (gameStarted == 0) {
    Wheel newWheel = new Wheel(400,555);
    wheels = (Wheel[]) append(wheels, newWheel);
     }
     
    else {
      
      for (int r = 0; r<wheels.length-1;r++) {
        
        if ((wheels[r].x == posArray[pos][0]) && (wheels[r].y == posArray[pos][1]))  {
                                                                                      pos++;
                                                                                       if (pos == 4) pos = 0;   }  }    // if a slot is still occupied go to the next
       
      Wheel newWheel = new Wheel(posArray[pos][0],posArray[pos][1]);
      wheels = (Wheel[]) append(wheels, newWheel);
      pos++;
      if (pos == 4) pos = 0;
      
      
    }
    
  }
  
  void createTape () {
    
        
    
    Tape firstPoint = new Tape (100, 530);            //initial and final points of the tape
    tapes = (Tape[]) append (tapes, firstPoint);
    Tape lastPoint = new Tape (700, 530);
    tapes = (Tape[]) append (tapes, lastPoint);
    
    
    }
      void drawLine () {   
       
        totDist = 0;  
        
      for (int k = 0; (k< tapes.length-1); k++) {
      
             // calculation trigonometry
      float dst = (dist(tapes[k].x, tapes[k].y, tapes[k+1].x, tapes[k+1].y))/2;
      float angle = atan2(( tapes[k+1].y-tapes[k].y),(tapes[k+1].x-tapes[k].x)) ;
      float angle2 = acos ((radius)/dst);
      
      totDist += dst;    // total lenght of the tape
     
      
      
      
      strokeWeight (1.5);
        
       if (tapes[k].cross == 0 && tapes[k+1].cross == 0) {
        
             //  TANGENT ABOVE
              
              float x1 = tapes[k].x+sin(angle)*radius;
              float y1 = tapes[k].y-cos(angle)*radius;
              float x2 = tapes[k+1].x+sin(angle)*radius;
              float y2 = tapes[k+1].y-cos(angle)*radius;
              
           
            line (x1, y1, x2, y2 );      
           
             }       
       
       else if (tapes[k].cross == 0 && tapes[k+1].cross == 1) {
        
             //  TANGENT UP / DOWN 
              
                  float x3 = tapes[k].x + cos(angle-angle2)*radius;
                  float y3 = tapes[k].y + sin(angle-angle2)*radius;
                  float x4 =  tapes[k+1].x - cos(angle-angle2)*radius;
                  float y4 =  tapes[k+1].y - sin(angle-angle2)*radius;
    
           
            line (x3, y3, x4, y4 );      
           
             }  
        
        else if (tapes[k].cross == 1 && tapes[k+1].cross == 0) {
        
             //  TANGENT DOWN / UP 
              
              
                  float x5 = tapes[k].x + cos(angle+angle2)*radius;
                  float y5 = tapes[k].y + sin(angle+angle2)*radius;
                  float x6 =  tapes[k+1].x - cos(angle+angle2)*radius;
                  float y6 =  tapes[k+1].y - sin(angle+angle2)*radius;
    
           
            line (x5, y5, x6, y6 );      
                 
             }  
        
             else if (tapes[k].cross == 1 && tapes[k+1].cross == 1) {
        
             //  TANGENT BELOW
              
              
                  float x7 = tapes[k].x - sin(angle)*radius;
                  float y7 = tapes[k].y + cos(angle)*radius;
                  float x8 =  tapes[k+1].x - sin(angle)*radius;
                  float y8 =  tapes[k+1].y + cos(angle)*radius;
           
            line (x7, y7, x8, y8 );      
            
             }    
         
        }
        
               
                                                //DISTANCE BASED COUNTER
        if (gameStarted == 1) {
           fill(0);
            timeIndex = wRect-((wRect*levelUp.passedTime)/levelTime);
        rect(359, 539,  timeIndex, hRect);
         remaining = (400*level)-totDist;
       if (remaining < 0) {
                           loseIndex = 0;
                           //rect(359, 539,  loseIndex, hRect);            // rectangle containing the losing bar
                            }
       else {  
                if ((levelUp.isFinished()) && totDist<(400*level)) lateGame();
                loseIndex = (remaining * wRect)/(400*level);
                //rect(359, 539,  loseIndex, hRect);            // rectangle containing the losing bar
                 }
           }
      
      
     
   
      }  

  
  void  doKeyEvent () {
    
  wheels[runner].setDirection();
  }
  
  
    void endGame() {
    
    gameState = 2;
    
  }
  
  void lateGame () {
    
    gameState = 3;
    }
  
  // check the ball doesn`t go off the screen
   void checkBoundaries () {
   
   if ((gameStarted == 1 ) && (
       (wheels[runner].x>width-w) || 
       (wheels[runner].x<w) ||
       (wheels[runner].y> 530-w) || 
       (wheels[runner].y<w))) endGame();
   
   
   }   
   
   
   void checkHit () {
     
    
     float d;
     
     if (wheels[runner].state == 1) {
     for (int j = 0; j< wheels.length; j++) {
       
       d = dist(wheels[runner].x,wheels[runner].y,wheels[j].x,wheels[j].y);    //calculate distance of the wheel from each one of them
       if ((d<wheels[runner].w) && (runner != j))  endGame();
       }
     }
     
     }
 
 
  void checkCross () {
  
  for (int l = 0; (l< tapes.length-1); l++) {  
  
    crossed= 0;
  
    // Translate everything so that line segment start point to (0, 0)
  float a = (tapes[l+1].x-tapes[l].x); // Line segment end point horizontal coordinate
  float b = (tapes[l+1].y-tapes[l].y); // Line segment end point vertical coordinate
  float c = wheels[runner].x-tapes[l].x; // Circle center horizontal coordinate
  float d = wheels[runner].y-tapes[l].y; // Circle center vertical coordinate
 

  // Collision computation
   if ((d*a - c*b)*(d*a - c*b) <= radius*radius*(a*a + b*b)) {
    
    if ( ((c*a + d*b >= 0) && (c*a + d*b <= a*a + b*b)) || ((a-c)*(a-c) + (b-d)*(b-d) <= radius*radius) || (c*c + d*d <= radius*radius) ){
     
      section = l;
            
       // orientation computation
 if (d*a - c*b < 0) {
    // Circle center is on left side looking from (x0, y0) to (x1, y1)
      crossed = 1;
      /*  CHECK CROSS
      
      textSize (50);
      textAlign (CENTER);
      fill (255);
      text ("circleSideIsRight", width/2, height/2 );
      */
      
  }
  
  if (tapeState == 0) addPoint (section, crossed);
   
     
    }
  }      
  
    }
    
    
    
    
    }
 
 void addPoint (int z, int cr) {
   
   
   Tape movingPoint = new Tape (wheels[runner].x, wheels[runner].y);
   //Tape lastPoint = new Tape (tapes[tapes.length-1].x, tapes[tapes.length-1].y);


   tapes = (Tape []) splice(tapes, movingPoint,z+1);
   tapes[z+1].cross = cr;
   tapeState = 1;
     
   }
 

 void movePoint (int s) {
 
// Tape movingPoint = new Tape (wheels[runner].x, wheels[runner].y);
 
  tapes[s].x = wheels[runner].x;
  tapes[s].y = wheels[runner].y;
    
  }
 
 void release () {            // when wheels jumps the tape is released
   
   
   if (tapeState == 1) {
     
     /*  ARRAYCOPY NOT WORKING WITH OBJECTS
     
     Tape [] dstCopy = {};
     arrayCopy (tapes, section+1,dstCopy, 0, tapes.length-section-1);
     Tape [] newSrc ={};
     arrayCopy (tapes, 0, newSrc, 0, section-1);
     tapes = (Tape []) concat(newSrc, dstCopy);
     tapes = (Tape[]) shorten (tapes);
      */ 
     
     for (int g = section; g<tapes.length-1; g++ )  tapes[g]=tapes[g+1]; 
       
     tapes = (Tape[]) shorten (tapes);
     tapeState = 0;
     
     
     }
   
   }
 
  
 
  }
