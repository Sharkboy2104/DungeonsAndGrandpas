room[][] rooms;  //<>//
bullet[] bullets;
entity player = new entity();
int difficulty=0;
int objects = 3;
int PlayerSpeed = 2;
boolean playerHit = false;
boolean isInvincible = false;
boolean gameOver = false;

int enemyDamage = 10;
boolean gameStarted = false;
boolean doorsOpen = true;
int roomsize=10;
int roomLimit = 8;
int currentRoomX;
int currentRoomY;

int numFrames = 30;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];

class room {
  int x, y, w, h;
  enemy[] enemies;
  obstacle[] obstacles;
  String[] doors;
  item[] items;
  //room[][] neighbours;
  boolean isEnd;
  boolean beenTo;
  int killCount =0;
}


class item {
  int x, y;
}



void setup() {
  frameRate(60);
  player.health = 100;
  background(0);
  size(1000, 1000);
  rooms = new room[roomsize][roomsize];
  roomCount();
  //enemys = new enemy[0];

  createDungeon();
  println("finished setup()");
  makeRooms();
  createDoor();
  bullets= new bullet[0];
  bullets=(bullet[])append(bullets, new bullet());

  images[0]  = loadImage("boy_down_1.png");
  images[1]  = loadImage("boy_down_2.png"); 
  images[2]  = loadImage("boy_left_2.png");
  images[3]  = loadImage("boy_left_2.png"); 
  images[4]  = loadImage("boy_right_2.png");
  images[5]  = loadImage("boy_right_2.png"); 
  images[6]  = loadImage("boy_up_2.png");
  images[7]  = loadImage("boy_up_2.png");

  images[8] = loadImage("fireball_down_1.png");
  images[9] = loadImage("fireball_left_1.png");
  images[10] = loadImage("fireball_right_1.png");
  images[11] = loadImage("fireball_up_1.png");

  //doors
  images[12] = loadImage("BottomDoor_Closed.png");
  images[13] = loadImage("BottomDoor_Open.png");
  images[14] = loadImage("LeftDoor_Closed.png");
  images[15] = loadImage("LeftDoor_Open.png");
  images[16] = loadImage("RightDoor_Closed.png");
  images[17] = loadImage("RightDoor_Open.png");
  images[18] = loadImage("TopDoor_Closed.png");
  images[19] = loadImage("TopDoor_Open.png");

  images[20] = loadImage("oldman_down_1.png");
  images[21] = loadImage("oldman_down_2.png");
  images[22] = loadImage("oldman_left_1.png");
  images[23] = loadImage("oldman_left_2.png");
  images[24] = loadImage("oldman_right_1.png");
  images[25] = loadImage("oldman_right_2.png");
  images[26] = loadImage("oldman_up_1.png");
  images[27] = loadImage("oldman_up_2.png");
}




void draw() {
  size(1000,1000);
  fill(80, 80, 80);
  rect(30, 30, 30, 10);
  background(0);
  drawPlayer();
  drawWalls();
  player.x += player.xspeed;
  player.y += player.yspeed;
  if (gameStarted == false) {
    startMenu();
  }

  // calls all these if game is started
  if (gameStarted == true && gameOver == false) {
    objCollision();
    bulletEnemyCollision();
    drawCurrentRoom();
    doorsOpen();
    showMap();
    doorsCollision();
    enemyCollision();
    bulletUpdate();
    chase(player);
    bulletBounce();

    if (shooting == true) {
      fire();
    }
    if (playerHit == true) {
      player.health = player.health - enemyDamage;
      println(player.health);
      playerHit = false;
    }
  }
  if (player.health <=0 ) {
    gameOver = true;
    gameOver();
    println("GameOver");
  }
  rect(player.x-5, player.y-5, player.health/4 * 2, 6);
  //image(images[0], player.x, player.y, player.w+5, player.h+5);
  //image(imaes[1], player.x, player.y, player.w+5, player.h+5);
}

void startGame() {
  //when you press space and gameStarted == false then this sub program will run
  //this program starts the game
  background(0);
  createDungeon();
  createPlayer();//need to finish

  //selects starting room then draw everything inside of that room
  fill(0, 255, 0);
  //boolean used to keep this program running until it is true
  boolean foundRoom=false;
  //loops through rooms until it has found a room that != null
  for (int i=0; i<rooms.length; i++) {
    for (int j = 0; j <rooms[i].length; j++) {
      if (rooms[i][j]!=null && foundRoom==false) {
        //creates the enemies in that room
        for (int k=0; k<rooms[i][j].enemies.length; k++) {
          rooms[i][j].enemies[k].drawEnemy();
        }
        foundRoom=true;
        currentRoomX=i;
        currentRoomY=j;
        //tells me what room i am currently in    .  Error Detection
        println("current room is", i, j);
      }
    }
  }
}

void drawCurrentRoom() {
  //this program needs the StartGame program to work so we can find out what the current room is then we can
  //draw all of the enemies, doors and obstacles in the current room
  for (int k=0; k<rooms[currentRoomX][currentRoomY].enemies.length; k++) {
    fill(0, 255, 0);
    if (rooms[currentRoomX][currentRoomY].enemies[k].alive == true) {
      //draws the enemy if it is alive
      rooms[currentRoomX][currentRoomY].enemies[k].drawEnemy();
    }
  }
  for (int i=0; i<rooms[currentRoomX][currentRoomY].obstacles.length; i++) {
    fill(100, 80, 0);
    rooms[currentRoomX][currentRoomY].obstacles[i].drawOb();
  }
  //Bottom Door
  for (int i=0; i<rooms[currentRoomX][currentRoomY].doors.length; i++) {
    if (rooms[currentRoomX][currentRoomY].doors[i] == "DOWN") {
      if (doorsOpen == true) {
        image(images[13], width/2-5, height-55, 70, 70);
      } else {
        image(images[12], width/2-5, height-55, 70, 70);
      }
    }
  }
  //Top Door
  for (int i=0; i<rooms[currentRoomX][currentRoomY].doors.length; i++) {
    if (rooms[currentRoomX][currentRoomY].doors[i] == "UP") {
      fill(0, 0, 255);
      if (doorsOpen == true) {
        image(images[19], width/2-30, -15, 70, 70);
      } else {

        image(images[18], width/2-30, -15, 70, 70);
      }
    }
  }
  //Left Door
  for (int i=0; i<rooms[currentRoomX][currentRoomY].doors.length; i++) {
    if (rooms[currentRoomX][currentRoomY].doors[i] == "LEFT") {
      fill(0, 0, 255);
      if (doorsOpen == true) {
        image(images[15], -15, height/2, 70, 70);
      } else {
        image(images[14], -15, height/2, 70, 70);
      }
    }
  }
  //Right Door
  for (int i=0; i<rooms[currentRoomX][currentRoomY].doors.length; i++) {
    if (rooms[currentRoomX][currentRoomY].doors[i] == "RIGHT") {
      fill(0, 0, 255);
      if (doorsOpen == true) {
        image(images[17], width-55, height/2, 70, 70);
      } else {
        image(images[16], width-55, height/2, 70, 70);
      }
    }
  }
}

void doorsOpen() {

  if (rooms[currentRoomX][currentRoomY].killCount+1<=rooms[currentRoomX][currentRoomY].enemies.length) {
    //for (int i=0; i<rooms[currentRoomX][currentRoomY].enemies.length; i++) {
    //idk how but if i kill the right enemy the doors will open
    //need to change to if all the items a
    doorsOpen = false;
  } else {
    doorsOpen = true;
    //println("true");
  }
  //println(rooms[currentRoomX][currentRoomY].killCount);
  //println("there are",rooms[currentRoomX][currentRoomY].enemies.length,"enemies");
}

//}

void createDungeon() {
  //loops through the rooms and checks if they are arent null
  for (int i=0; i<rooms.length; i++) {
    //println(i);
    for (int j = 0; j <rooms[i].length; j++) {
      //println(j);
      if (rooms[i][j]!=null) {
        //enemies
        //then it initialises the enemies array creating between 2 and 6 enemies in each room and based on the difficulty there can be more
        for (int o=0; o < int(random(difficulty+2, difficulty+6)); o++) {
          rooms[i][j].enemies=(enemy[])append(rooms[i][j].enemies, new enemy());
          rooms[i][j].enemies[rooms[i][j].enemies.length-1].x=int(random(60, width-60));
          rooms[i][j].enemies[rooms[i][j].enemies.length-1].y=int(random(60, height-60));
        }
        //it then initialises the obstacles array creating between 2 and 6 enemies in each room
        //for easy access i have made the ammount of obstacles editable by a global variable
        for (int o=0; o < int(random(objects+2, objects+6)); o++) {
          rooms[i][j].obstacles=(obstacle[])append(rooms[i][j].obstacles, new obstacle());
          //creates the width/height/x and y positions of each obstacle
          rooms[i][j].obstacles[rooms[i][j].obstacles.length-1].x=int(random(90, width-90));
          rooms[i][j].obstacles[rooms[i][j].obstacles.length-1].y=int(random(90, height-90));
          rooms[i][j].obstacles[rooms[i][j].obstacles.length-1].w=int(random(20, 50));
          rooms[i][j].obstacles[rooms[i][j].obstacles.length-1].h=int(random(20, 50));
        }
        //there will next be an items array but wont get finished by deadline
      }
    }
  }
  println();
}




void createDoor() {
  //loops through the array of rooms
  for (int i = 0; i < rooms.length; i+=1) {
    for (int j = 0; j < rooms[i].length; j+=1) {
      println("checking for doors near", i, j);
      //checks if there is a door to the right of the current door and appents Right into an array of strings used later to print the door in that position
      if (i+1 >= 0 && i+1 < roomsize && rooms[i][j] != null && rooms[i+1][j] != null) {
        rooms[i][j].doors=(String[])append(rooms[i][j].doors, "RIGHT");
      }
      //checks if there is a door to the left of the current door and appents Left into an array of strings used later to print the door in that position
      if (i-1 >=0 && i-1 < roomsize && rooms[i][j] != null && rooms[i-1][j] != null) {
        rooms[i][j].doors=(String[])append(rooms[i][j].doors, "LEFT");
      }
      //checks if there is a door to the below of the current door and appents DOWN into an array of strings used later to print the door in that position
      if (j+1 >=0 && j+1 <= roomsize - 1 && rooms[i][j] != null && rooms[i][j+1] != null) {
        rooms[i][j].doors=(String[])append(rooms[i][j].doors, "DOWN");
      }
      //checks if there is a door to the above of the current door and appents UP into an array of strings used later to print the door in that position
      if (j-1 >=0 && j-1<= roomsize - 1 && rooms[i][j] != null && rooms[i][j-1] != null) {
        rooms[i][j].doors=(String[])append(rooms[i][j].doors, "UP");
      }
      //used to see if there are doors in each position on every room.            Error detection 
      for (int x = 0; rooms[i][j]!=null && x < rooms[i][j].doors.length; x++) {
        println(rooms[i][j].doors[x]);
      }
    }
    // }
    println("done");
  }
}


void makeRooms() {
  for (int i = 0; i < rooms.length; i +=1 ) {
    rooms[i] = new room[roomsize];
  }
  //makes the the rooms take up 3/4 of the screen
  while (roomCount() <= roomLimit*roomLimit* 3/4) {
    //picks random positions on the screen and picks those as the start points for the walk
    int x = int(random(roomsize));
    int y = int(random(roomsize));
    if (rooms[x][y]==null) {
      //initialises all of the arrays part of the room class
      rooms[x][y] = new room();
      rooms[x][y].enemies=new enemy[0];
      rooms[x][y].obstacles=new obstacle[0];
      rooms[x][y].doors = new String[0];
      rooms[x][y].items=new item[0];
      int dx, dy;
      //starts the walk for the horizontal axis.
      //if x < half off the screen then it wall go right else it will go left
      if (x < roomsize/2) {
        dx = 1;
      } else {
        dx = -1;
      }
      //starts the walk in the vertical axis
      //if y < half of the screen then it will go down else it will go up
      if (y < roomsize/2) {
        dy = 1;
      } else {
        dy = -1;
      }
      //error detection
      println("walking from ", x, y, dx, dy, " : ");
      //randomly choses if it what direction the step will take 
      //if it is in top left quadrant then it will chose between down and right
      if (random(1)<0.5) x = x + dx;
      else y=y+dy;

      //makes the walk continue until it meets an edge 
      while (x < roomsize && x >= 0 && y < roomsize && y >= 0) {
        if (rooms[x][y]==null) {
          rooms[x][y] = new room();
          rooms[x][y].enemies=new enemy[0];
          rooms[x][y].obstacles=new obstacle[0];
          rooms[x][y].doors = new String[0];
          rooms[x][y].items=new item[0];
          //print(x, y, ", ");
        }
        //randomly choses if it what direction the step will take 
        //if it is in top left quadrant then it will chose between down and right
        if (random(1)<0.5) x = x + dx;
        else y=y+dy;
      }
      //println();
    }
  }
  //helps me know if rooms are creating propelty.   Error detection
  println("done");
}



void keyPressed() {
  if (key == 'm') {
    showMap();
  }
  if (key == ' ') {
    //makes the game only start once when you press SPACEBAR and will be used later when you die or finish the game
    if (gameStarted==false) {
      //startGame();
      //gameStarted=true;
    }
  }
  if (key == 'w') {
    playerUp = true;
    //used in combination with key released so you can move diagional
    player.yspeed = -PlayerSpeed;
  }
  if (key == 'a') {
    playerLeft = true;
    //used in combination with key released so you can move diagional
    player.xspeed = -PlayerSpeed;
  }
  if (key == 's') {
    playerDown = true;
    //used in combination with key released so you can move diagional
    player.yspeed = PlayerSpeed;
  }
  if (key == 'd') {
    playerRight = true;
    //used in combination with key released so you can move diagional
    player.xspeed = PlayerSpeed;
  }
}


void keyReleased() {
  if (key == 'm') {
    //background(0);
  }
  if (key == 'w') {
    playerUp = false;
    player.yspeed = 0;
    //print("up");
  }
  if (key == 'a') {
    player.xspeed = 0;
    playerLeft = false;
    //print("right");
  }
  if (key == 's') {
    player.yspeed = 0;
    playerDown = false;
    //print("down");
  }
  if (key == 'd') {
    player.xspeed = 0;
    playerRight = false;
    //print("left");
  }
}
boolean shooting = false;
void mousePressed() {   
  //shoots until mouse released
  if (mouseButton==LEFT) {
    shooting = true;
    //println("L");
  }
}

void mouseReleased() {
  //stops the shooting
  if (mouseButton == LEFT) {
    shooting = false;
  }
}


void showMap() {
  //loops through the array of rooms and checks if there is a room in each position
  for (int i = 0; i < rooms.length; i+=1) {
    for (int j = 0; j < rooms[i].length; j+=1) {
      if (rooms[i][j] != null) {
        fill(80, 80, 80, 90);
        if (i==currentRoomX && j==currentRoomY) {
          fill(255, 255, 100, 90);
        }
        //if there is a room in each position then it will print a room there
        square(i *width/roomsize/6+30, j * height/roomsize/6+30, width/roomsize/6);
      }
    }
  }
}

int roomCount() {
  //used to find how many rooms are in the 
  //and used to limit the maximum amount of rooms
  int roomCount=0;
  for (int i =0; i < rooms.length; i++) {
    for (int j = 0; j < rooms[i].length; j ++)
      if (rooms[i][j]!=null) {
        roomCount += 1;
      }
  }
  return roomCount;
}


//wont be finished by due date
void items() {
}

void gameOver() {
  textSize(60);
  text("GAMEOVER", width/2.8, height/2);
  stroke(0);
  fill(100, 0, 0);
  rect(width/3, height/1.8, 370, 80);
  fill(100);
  text("Keep Going", width/2.9, height/1.63);
  if (mousePressed && width/2.8+330>mouseX && width/2.8-330<mouseX && height/1.8+75>mouseY && height/1.8-75<mouseY) {
    player.health = 100;
    gameOver = false;
  }
}

void startMenu() {
  fill(100);
  textSize(60);
  text("Dungeons and Grandpas", width/4.5, height/2);
  stroke(0);
  fill(100, 0, 0);
  rect(width/3.2, height/1.8, 370, 80);
  fill(100);
  text("Start Game", width/3, height/1.63);
  if (mousePressed && width/2.8+330>mouseX && width/2.8-330<mouseX && height/1.8+75>mouseY && height/1.8-75<mouseY) {
    startGame();
    gameStarted = true;
  }
}
