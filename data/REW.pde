gamePlay gamePlay;
startScreen startScreen;
EndScreen endScreen;

PImage startImg;
PImage endImg;
PImage blankScr;
PImage blankStrt;
PImage wheelIm;
PImage wheelBg;
PImage wheelz;
PImage lateScr;
PFont fonts;

int gameState = 0;


// 0 - start screen
// 1 - game play
// 2 - end screen
// 3 - slow end

import ddf.minim.*;
Minim minim;
AudioPlayer theme;
AudioPlayer end;


void setup() {
  size(800, 600);
  
  startScreen = new startScreen ();
  gamePlay = new gamePlay();
  endScreen = new EndScreen();
   
  startImg = loadImage ("startscreen.png");
  endImg = loadImage ("endscreen.png");
  blankStrt = loadImage ("whitescreenStart.png");
  blankScr = loadImage ("whitescreen.png");
  wheelIm = loadImage ("wheel.png");
  wheelBg = loadImage ("wheelBg.png");
  wheelz = loadImage ("wheel2.png");
  lateScr = loadImage ("latescreen.png");
 //fonts = loadFont("FedraMono-Normal.otf");
 
 //song = minim.loadFile("mysong.wav");
  minim = new Minim(this);
 end = minim.loadFile ("rewind.mp3", 2048);
 
 minim = new Minim(this);
 theme = minim.loadFile ("mission.mp3", 2048);

  
}
 
void draw() {

   
   if (gameState == 0)  { 
                          theme.play();
                          startScreen.display();
                          background (startImg);
        }      
        
   else if (gameState == 1) { 
                             theme.play();
                             gamePlay.update();
       
    }
    else if (gameState == 2) {
                            endScreen.update();
                            background (endImg);
                            end.play();
    }
    else if (gameState == 3) {
                            endScreen.update();
                            background (lateScr);
                            end.play();
    }
  
   
  
}



void keyPressed () {
   
  if (gameState == 0 ) { startScreen.doKeyEvent();
   
    }
  else if (gameState == 1 ) { gamePlay.doKeyEvent();
    }
    else if (gameState == 2) {
    endScreen.doKeyEvent();
  } else if (gameState == 3) {
    endScreen.doKeyEvent();
  }

   
   }


 void startGame () {    //tell the game to start
    gameState = 1; 
    gamePlay.startGame();
    
    }
    
 void resetGame() {
  gameState = 0;
}
  
