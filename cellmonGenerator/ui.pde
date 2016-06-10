import controlP5.*;
import java.util.*;
import java.text.SimpleDateFormat;






// dafault input values
int mazex = 6;
int currentMaze = 0;
int mazey = 6;
int mazeCellsDefault = 80;

int wallWidth = 5;
int floorWidth = 45;

int CEBUNUMBER = 1;

String mazename = "setmazename";
String mazeType;

ControlP5 cp5;

DropdownList d1;
Textlabel madedatelabel,howToUselabel;


void uiSetup(){

  cp5 = new ControlP5(this);

    cp5.begin();

    cp5.getTab("default")
     .activateEvent(true)
     .setLabel("save option")
     .setId(1)
     ;

    cp5.addTab("config")
     .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
    cp5.addTab("howtouse")
     .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
      cp5.addTab("hide")
     .setColorBackground(color(0,0))
     ;

    // save button
    cp5.addButton("saveSVG")
     .setBroadcast(false)
     .setPosition(0,20)
     .setSize(80,30)
     .setValue(1)
     .setBroadcast(true)
     .setLabel("save")
     .getCaptionLabel().align(CENTER,CENTER)
     ;


  // maze type
 // maze createdate

 //maze name
    PFont font = createFont("Helvetica",18);
  cp5.addTextfield("mazename")
     .setPosition(0,55)
     .setSize(200,30)
     .setFocus(false)
     .setFont(createFont("Helvetica",18))
     .setColor(color(255))
     .setText(mazename)
     .setLabelVisible(false)
     ;


  List l = Arrays.asList("ww026spreadFlooring", "ym002areacut");
    /* add a ScrollableList, by default it behaves like a DropdownList */



  cp5.addScrollableList("mazeType")
     .setPosition(0, 90)
     .setSize(200, 200)
     .setBarHeight(10)
     .setItemHeight(30)
     .addItems(l)
     // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
     ;




  //CONFIG
  // x
    cp5.addSlider("mazex")
     .setBroadcast(false)
     .setRange(0,60)
     .setLabel("x")
     .setValue(mazex)
     .setPosition(0,20)
     .setSize(220,20)
     .setBroadcast(true)
     .moveTo("config");
     ;
  // y
      cp5.addSlider("mazey")
     .setBroadcast(false)
     .setRange(0,60)
     .setLabel("y")
     .setValue(mazey)
     .setPosition(0,50)
     .setSize(220,20)
     .setBroadcast(true)
     .moveTo("config");
  // wallwidth
     cp5.addSlider("wallWidth")
     .setBroadcast(false)
     .setRange(3,20)
     .setLabel("wall")
      .setValue(wallWidth)
     .setPosition(0,80)
     .setSize(220,20)
     .setBroadcast(true)
     .moveTo("config");
  // floorwidth
     cp5.addSlider("floorWidth")
     .setBroadcast(false)
     .setLabel("floor")
     .setValue(floorWidth)
     .setRange(5,200)
     .setPosition(0,110)
     .setSize(220,20)
     .setBroadcast(true)
     .moveTo("config");

   cp5.addButton("reset")
    .setBroadcast(false)
    .setPosition(0,150)
    .setSize(80,20)
    .setValue(1)
    .setBroadcast(true)
    .setLabel("reset")
    .moveTo("config")
    .getCaptionLabel().align(CENTER,CENTER)
    ;






  //how to use texts
       howToUselabel = cp5.addTextlabel("label")
                    .setText(" drag to draw whitespace \n press A and drag to draw outside   \n saved file is on the same directory")
                    .setPosition(0,50)
                    .setColorValue(50)
                    .setFont(createFont("Georgia",12))
                    .moveTo("howtouse");
                    ;
      cp5.end();

}




void uibg(){
  if(!cp5.getTab("hide").isActive()){
    noStroke();
    fill(0,80);
    rect(0,0, 250,250);


    }
  }







//callbacks
void mazeType(int n) {
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "mazeType").getItem(n).get("name"));
  mazeType = (String)cp5.get(ScrollableList.class, "mazeType").getItem(n).get("name");
  maze.changeMazeType(n);
  if ( n > 5 ){
    CEBUNUMBER = n - 4;
  }

  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable
   */
  //mazeType = cp5.get(ScrollableList.class, "dropdown").getItem(n).get("name");

}
void mazex(int value){
    mazex = value;
    maze.xCallback(value);
}

void mazey(int value){
    mazey = value;
    maze.yCallback(value);
}

void wallWidth(int value){
    wallWidth = value;
    maze.wwCallback(value);
}

void floorWidth(int value){
    floorWidth = value;
    maze.fwCallback(value);
}
void mazename(String value){
    mazename = value;
}

void reset(){
  mazex = 6;
  currentMaze = 0;
  mazey = 6;
  mazeCellsDefault = 80;

  wallWidth = 5;
  floorWidth = 45;

  int CEBUNUMBER = 1;

  String mazename = "setmazename";
  maze.reset(mazex,mazey,wallWidth,floorWidth);
}



void saveSVG(){
  String filename = getDateFormed() + "_" + mazeType + "_" + mazex + "x" + mazey + "_" +  cp5.get(Textfield.class,"mazename").getText() + ".svg";
  println(filename + "saved");
  pgn = createGraphics(width, height, SVG, filename);
  maze.refreshpg(1,pgn);

}

String getDateFormed(){

        Calendar c = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
        return sdf.format(c.getTime());

}
