int size = 100;

int xDim = 1600;
int yDim = 900;

int delayTime = 150;

Tile[][] tiles;

boolean started = false;

class Tile{
  public int x, y, size;
  boolean alive;
  
  public Tile(int x, int y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
    
    alive = false;
  }
  
  public boolean isAlive(){
    return alive;
  }
  
  public void setAlive(boolean alive){
    this.alive = alive;
  }
  
  public void drawTile(){
    if(alive){
      fill(0);
    }else{
      fill(255);
    }
    rect(x, y, size, size);
  }
}

void drawTiles(){
  int numberOfColumns = xDim/size;
  int numberOfRows = yDim/size;
  
  for(int i=0;i<numberOfRows;i++){
    for(int j=0;j<numberOfColumns;j++){
      tiles[i][j].drawTile();
    }
  }
}

void keyPressed(){
  if(keyCode == 67){
    int numberOfColumns = xDim/size;
    int numberOfRows = yDim/size;
  
    for(int i=0;i<numberOfRows;i++){
      for(int j=0;j<numberOfColumns;j++){
        tiles[i][j].setAlive(false);
      }
    }
  }
  if(keyCode == 32){
    if(started){
      started = false;
    }else{
      started = true;
    }
  }
}

void transition(){
  int numberOfColumns = xDim/size;
  int numberOfRows = yDim/size;
  
  Tile[][] newTiles = new Tile[numberOfRows][numberOfColumns];
  
  for(int i=0;i<numberOfRows;i++){
    for(int j=0;j<numberOfColumns;j++){
      newTiles[i][j] = new Tile(tiles[i][j].x, tiles[i][j].y, tiles[i][j].size);
      
      int adjacentAliveTiles = 0;
      if(i!=0){
        adjacentAliveTiles = (tiles[i-1][j].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
        if(j!=0){
          adjacentAliveTiles = (tiles[i-1][j-1].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
        }
        if(j!=numberOfColumns-1){
          adjacentAliveTiles = (tiles[i-1][j+1].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
        }
      }
      
      if(j!=0){
        adjacentAliveTiles = (tiles[i][j-1].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
      }
      if(j!=numberOfColumns-1){
        adjacentAliveTiles = (tiles[i][j+1].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
      }
      
      if(i!=numberOfRows-1){
        adjacentAliveTiles = (tiles[i+1][j].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
        if(j!=0){
          adjacentAliveTiles = (tiles[i+1][j-1].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
        }
        if(j!=numberOfColumns-1){
          adjacentAliveTiles = (tiles[i+1][j+1].isAlive())?adjacentAliveTiles+1:adjacentAliveTiles;
        }
      }
      
      if(adjacentAliveTiles<2 || adjacentAliveTiles>3){
        newTiles[i][j].setAlive(false);
      }else if(adjacentAliveTiles == 3){
        newTiles[i][j].setAlive(true);        
      }else{
        newTiles[i][j] = tiles[i][j];
      }
      
    }
  }
  
  tiles = newTiles;
  
  if(!started){
    return;
  }
  delay(delayTime);
  //transition();
}

void tileClicked(int x, int y){
  int row = y / size;
  int column = x / size;
  
  if(tiles[row][column].isAlive()){
    tiles[row][column].setAlive(false);
  }else{
    tiles[row][column].setAlive(true);
  }
  
  //System.out.println(row+", "+column);
}

void mouseClicked(){
  if(!started){
    tileClicked(mouseX, mouseY);
  }
}

void draw(){
  drawTiles();
  if(started){
    transition();
  }
}

void setup(){
  size(1600, 900);
  
  int numberOfColumns = xDim/size;
  int numberOfRows = yDim/size;
  
  tiles = new Tile[numberOfRows][numberOfColumns];
  
  for(int i=0;i<numberOfRows;i++){
    for(int j=0;j<numberOfColumns;j++){
      Tile t = new Tile(j*size, i*size, size);
      tiles[i][j] = t;
    }
  }
}
