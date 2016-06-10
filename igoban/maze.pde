static final int BLACK = 10;
static final int WHITE = 11;


class Maze{

  //grid size
  int x;
  int y;

  //widths
  int wallwidth;
  int floorwidth;
  int stoneSize;
  float stoneStroke;

  //wall var
  int cell[][];

  int offsetx;
  int offsety;

  boolean isEdited = false;
  //fonts


  Maze(int x,int y, int ww, int fw){
    //init cells
    this.x = x;
    this.y = y;
    this.cell = new int[2 * mazeCellsDefault + 1 ][2 * mazeCellsDefault + 1];
    for (int i = 0; i < 2 * mazeCellsDefault + 1 ; i++){
      for(int j = 0; j < 2 * mazeCellsDefault + 1 ; j++){
        if(i % 2 == 0) cell[i][j] = WALL;
        else if (j % 2 == 0) cell[i][j] = WALL;
        else cell[i][j] = FLOOR;
      }
    }


  //init widths
  this.wallwidth = ww;
  this.floorwidth = fw;
  this.stoneSize = DstoneSize;
  this.stoneStroke = DstoneStroke/10;

  //init offsets
  this.makeoffsets();


  }

  void putStone(){
    //put stone on mouse

    int status = 0;
    //change maze state at (0,0),(0,2),(2,2),,,
     editMaze(0,mouseX,mouseY);


    }


  // aim : adjust maze position
  void makeoffsets(){
    // maze centering offset
    int mazewidth  = int(x * floorwidth + wallwidth);
    int mazeheight = int(y * floorwidth + wallwidth);

    offsetx = int((width  - mazewidth ) /2);
    offsety = int((height - mazeheight) /2);
    //println("offx is "+ offsetx + ", offy is" +offsety );
  }



  void refresh(){
    refreshxn(1);
    image(pv,0,0);
    uibg();
  }

  void refreshxn(int n){
    refreshpg(n,pv);
    image(pv,0,0);
  }


  //refresh maze
  void refreshpg(int n, PGraphics pg){ // n means xn resolution

    pg.beginDraw();

    //refresh All
    pg.background(255);

    makeoffsets();

    //draw grids
    int tmpw,tmph,posx,posy;
    //draw Walls

    // init vars
    tmpw = 0;
    tmph = 0;
    posx = offsetx;
    posy = offsety;
    for(int j = 0; j < 2 * y + 1 ; j++){
      for (int i = 0; i < 2 * x + 1 ; i++){
        //val wall
        if(j % 2 == 0) tmph = 0;
        else tmph = int(this.floorwidth * n);

        //col wall
        if (i % 2 == 0) tmpw = 0 ;
        else tmpw = int(this.floorwidth * n);

          //if wall draw line
          if (cell[i][j] == WALL) {
            // stroke congifuration
            pg.noFill();
            pg.stroke(0);
            pg.strokeWeight(wallwidth);
            pg.strokeCap(PROJECT);

            pg.line(posx,posy,posx+tmpw,posy+tmph);
        }
        posx += tmpw;
      }
      posx = offsetx;
      posy += tmph;
    }
    //draw texts



    //draw CELLS


    // init vars
    tmpw = 0;
    tmph = 0;
    posx = offsetx;
    posy = offsety;


    for(int j = 0; j < 2 * y + 1 ; j++){
      for (int i = 0; i < 2 * x + 1 ; i++){
        //val wall
        if(j % 2 == 0) tmph = 0; //int(this.wallwidth * n);
        else tmph = int(this.floorwidth * n);

        //col wall
        if (i % 2 == 0) tmpw = 0 ;//int(this.wallwidth * n);
        else tmpw = int(this.floorwidth * n);

        if (cell[i][j] == BLACK){
          pg.beginDraw();
          pg.fill(0);
          pg.stroke(0);
          pg.ellipse(posx,posy, DstoneSize,DstoneSize);
          pg.noStroke();
          pg.endDraw();
        }

        if (cell[i][j] == WHITE){
          pg.beginDraw();
          pg.fill(255);
          pg.stroke(0);
          pg.strokeWeight(stoneStroke);
          pg.ellipse(posx,posy, DstoneSize,DstoneSize);
          pg.noStroke();
          pg.endDraw();
        }

        posx += tmpw;
      }
      posx = offsetx;
      posy += tmph;
    }

    pg.dispose();
    pg.endDraw();


  }


  void editMaze(int mousestate,float mouseX,float mouseY){
    //save cell num
    int numx,numy;
    //get mousePos and return cellnum
    numx = cellNumberx(mouseX);
    numy = cellNumbery(mouseY);

    if (numx < 0 || numx > 2 * x + 1) return;
    if (numy < 0 || numy > 2 * y + 1) return;

    if(cell[numx][numy] == WALL) mousestate = BLACK;
        else if (cell[numx][numy] == BLACK) mousestate = WHITE;
        else if (cell[numx][numy] == WHITE) mousestate = WALL;
        else  return;

    cell[numx][numy] = mousestate;
    isEdited = true;

    refresh();
    //println("mouse is now "+ numx + "," + numy + "cell ,it becomes" + mousestate);
    //println(cell[2][2]+ "," + cell[2][3] + "," + cell[2][4]);


  }

  int cellNumberx(float pos){
    pos -= float(this.offsetx);
    return cellNumber(pos);
  }

  int cellNumbery(float pos){
    pos -= float(this.offsety);
    return cellNumber(pos);
  }

  //get position return cellnumber
  int cellNumber(float pos){
    int num;
    int t;
    int w = this.wallwidth;
    int f = this.floorwidth;

    pos += f/2;
    t =floor( pos  / int(w + f));


    return 2 * t ;

  }


  // UI options
    void xCallback(int value){
      this.x = value ;
    }
    void yCallback(int value){
      this.y = value ;
    }
    void wwCallback(int value){
      this.wallwidth = int(value) ;
    }
    void fwCallback(int value){
      this.floorwidth = int(value) ;
    }

    void ssCallback(int value){
      this.stoneSize= int(value) ;
    }
    void ststCallback(int value){
      this. stoneStroke = value / 10 ;
    }

  void reset(int x,int y, int ww, int fw){

      //init cells
      this.x = x;
      this.y = y;
      this.cell = new int[2 * mazeCellsDefault + 1 ][2 * mazeCellsDefault + 1];
      for (int i = 0; i < 2 * mazeCellsDefault + 1 ; i++){
        for(int j = 0; j < 2 * mazeCellsDefault + 1 ; j++){
          if( i % 2 == 0 && j % 2 == 0) cell[i][j] = BLANK;
          else if(i % 2 == 0) cell[i][j] = BLANK;
          else if (j % 2 == 0) cell[i][j] = BLANK;
          else cell[i][j] = OUTSIDE;
        }
      }
      isEdited = false;

    //init widths
    this.wallwidth = ww;
    this.floorwidth = fw;
    //init offsets
    this.makeoffsets();

  }

  void changeMazeType(int mazeType){
    switch (mazeType){
    case 0: //ww002teduMaze
          break;

    case 1: //ww005dokunuma
        break;
    case 2: //ww006biribiri
    break;

    case 3: //ww009mihariMaze
    break;
    case 4: //ww014icecave
    break;

    default:
      }
    refresh();


  }




}
