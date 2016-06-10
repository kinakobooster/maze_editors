import controlP5.*;

/*
 *
 *    works by standard Processing. <br />
 */


//SVG lib import
 import processing.svg.*;
 import processing.pdf.*;
//maze setup
Maze maze;
String[][] menuItems;




//shape options

//WALL var
static final int WALL = 0;
static final int FLOOR = 1;
static final int OUTSIDE = 2;
static final int INSIDEWALL = 3;
static final int BLANK = 5;

// export options
PGraphics pgn;
PGraphics pv,pdef ;

PFont helv;



void setup(){
  size(800, 1052,P2D);

  helv = createFont("Helvetica",30);
  textFont(helv);

  pv = createGraphics(width,height);
  frameRate(30);
  smooth();
//  startMark = loadShape("svg/start.svg");
//  goalMark = loadShape("svg/goal.svg");
//  obj1 = loadShape("svg/biribiri.svg");

  maze = new Maze(mazex,mazey,wallWidth,floorWidth);
  uiSetup();
  maze.refresh();
}

void draw(){

  maze.refresh();

  // show edit mode
  if (keyPressed == true &&( key == 'a' || key == 'A'))  fill(0,80);
  else fill(200,80);
  noStroke();
  ellipse(mouseX,mouseY,30,30);

  // draw ui bg

}



void mouseDragged(){
 //edit maze
  if (keyPressed == false) maze.editMaze(FLOOR, mouseX, mouseY);
  if (keyPressed == true &&( key == 'a' || key == 'A'))maze.editMaze(OUTSIDE, mouseX, mouseY);
}
void mouseClicked(){
 //edit maze
  if (keyPressed == false) maze.editMaze(FLOOR, mouseX, mouseY);
  if (keyPressed == true &&( key == 'a' || key == 'A'))maze.editMaze(OUTSIDE, mouseX, mouseY);
}
