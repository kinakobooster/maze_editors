
class Maze{

  //grid size
  int x;
  int y;

  //widths
  int wallwidth;
  int floorwidth;

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
        if( i % 2 == 0 && j % 2 == 0) cell[i][j] = BLANK;
        else if(i % 2 == 0) cell[i][j] = BLANK;
        else if (j % 2 == 0) cell[i][j] = BLANK;
        else cell[i][j] = OUTSIDE;
      }
    }


  //init widths
  this.wallwidth = ww;
  this.floorwidth = fw;

  //init offsets
  this.makeoffsets();


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

    //draw maze
    int tmpw,tmph,posx,posy;
    tmpw = 0;
    tmph = 0;
    posx = offsetx;
    posy = offsety;

    //draw texts

    pg.textFont(helv, floorwidth* 0.7);
    pg.textAlign(CENTER,CENTER);

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

        //outside fill gray
        if(isEdited == false){
          if (cell[i][j] == OUTSIDE) {
            pg.noStroke();
            pg.fill(200); // test
            pg.rect(posx,posy,tmpw,tmph);
          }
        }
        if (cell[i][j] == FLOOR) {
          pg.noStroke();
          pg.fill(255); // test
          pg.rect(posx,posy,tmpw,tmph);
        }

        posx += tmpw;
      }
      posx = offsetx;
      posy += tmph;
    }

    //draw tensen
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

                if (cell[i][j] == INSIDEWALL) {
                  pg.noFill();
                  pg.stroke(200);
                  pg.strokeWeight(wallwidth/2);
                  pg.strokeCap(ROUND);


                  //点を始点・終点を含めdash個うつ
                  float dash = 9;
                  int    l = 0;    //破線制御用
                  String hasen = "01"; //破線パターン
                  float  bx, by;   //直前座標記録用
                  float x1 = posx;
                  float x2 = posx + tmpw;
                  float y1 = posy;
                  float y2 = posy + tmph;

                  bx = x1;
                  by = y2;

                  for( int k = 0; k <= dash; k++ ){
                    float px = lerp( x1, x2, k/dash );
                    float py = lerp( y1, y2, k/dash );

                    //破線パターンが1の場合は線で結ぶ
                    String ptn = hasen.substring(l,l+1);
                    l++;
                    //パターンの終端まで来たら、最初に戻る
                    if( l >= hasen.length() ){ l = 0; }

                    if( ptn.equals("1") == true ){
                      //線で結ぶ
                      pg.line( bx, by, px, py );
                    } else {
                      //点を打つ
                        // point( px, py );
                    }

                    //直前の座標を更新
                    bx = px;
                    by = py;


                  }
                }

        posx += tmpw;
      }
      posx = offsetx;
      posy += tmph;
    }



    //draw Walls
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

    //floor space cannnot be WALL
    if (mousestate == WALL && numx % 2 == 1 && numy % 2 == 1) return;

    //WALL space cannot be FLOOR etc.
    if (mousestate != WALL && ( numx % 2 == 0 || numy % 2 ==0 ))return;

    cell[numx][numy] = mousestate;
    isEdited = true;
    calcWalls();

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

  //aim : calcurate wall around floor
  void calcWalls(){
    //odd number CELL can be floor
    for(int i = 0 ; i < x ; i++ ){
      for(int j = 0; j < y ; j++ ){
        if(cell[2 * i + 1][2 * j + 1] == OUTSIDE ){
          cell[2 * i + 1][2 * j] = BLANK;
          cell[2 * i + 1][2 * j + 2] = BLANK;
          cell[2 * i][2 * j + 1] = BLANK;
          cell[2 * i + 2][2 * j+ 1] = BLANK;
        }
      }
    }



    for(int i = 0 ; i < x ; i++ ){
      for(int j = 0; j < y ; j++ ){
        if(cell[2 * i + 1][2 * j + 1] == FLOOR ){
          //check four angles
            //right Cell
            if( i == x ){
              cell[2 * i + 2][2 * j + 1] = WALL;
            }else{
              if(cell[2 * i + 3][2 * j + 1] == OUTSIDE ){
                cell[2 * i + 2][2 * j + 1] = WALL;
              }else{
                cell[2 * i + 2][2 * j + 1] = INSIDEWALL;
              }
            }

            //left Cell
            if(i == 0){
                cell[2 * i][2 * j + 1] = WALL;
            }else{ // 左端
              if(cell[2 * i - 1][2 * j + 1] == OUTSIDE ){
                cell[2 * i][2 * j + 1] = WALL;
              }else{
                cell[2 * i][2 * j + 1] = INSIDEWALL;
              }

            }


            //below Cell
            if(j == y){
              cell[2 * i + 1][2 * j + 2] = WALL;
            }else{
              if(cell[2 * i + 1][2 * j + 3] == OUTSIDE ){
                cell[2 * i + 1][2 * j + 2] = WALL;
              }else{
                cell[2 * i + 1][2 * j + 2]  = INSIDEWALL;
              }
            }
            //upper Cell
            if(j == 0){
                cell[2 * i + 1][2 * j] = WALL;
            }else{
                if(cell[2 * i + 1][2 * j - 1] == OUTSIDE ){
                  cell[2 * i + 1][2 * j] = WALL;
                }else{
                  cell[2 * i + 1][2 * j] = INSIDEWALL;
                }
              }
            }
          }
        }
    }





  //get position return cellnumber
  int cellNumber(float pos){
    int num;
    int t;
    int k ; // atari hantei supporter

    int w = this.wallwidth;
    int f = this.floorwidth;
    if ( f < 8 ) k = 8 - f;
    else k = 8;

    t =floor(( pos - k / 2) / f );


      if ((pos > t * f) && (pos < t * f + k) )
        num = t * 2 ;
      else num =  t * 2 + 1;
    return num;


  }

// UI options
  void xCallback(int value){
    this.x = value ;
    isEdited = false;
  }
  void yCallback(int value){
    this.y = value ;
    isEdited = false;
  }
  void wwCallback(int value){
    this.wallwidth = int(value) ;
  }
  void fwCallback(int value){
    this.floorwidth = int(value) ;
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
