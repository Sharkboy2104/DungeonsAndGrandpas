//enemy class
class enemy {
  boolean alive = true;
  int x, y;
  int w=20;
  int h=40;
  int health=100;
  int xSpeed = 1;
  int ySpeed = 1;

  item[] items;
  float attackrange = 100;

  //draws the enemy
  void drawEnemy() {
    //rect(this.x, this.y, this.w, this.h);
    if(this.xSpeed > 0) {
      image(images[24], this.x, this.y, this.w+5, this.h+5);
      image(images[25], this.x, this.y,this.w+5, this.h+5);
    } else {
      image(images[20], this.x, this.y, this.w+5, this.h+5);
      image(images[21], this.x, this.y, this.w+5, this.h+5);
    }
    if (this.xSpeed < 0) {
      image(images[22], this.x, this.y, this.w+5, this.h+5);
      image(images[23], this.x, this.y, this.w+5, this.h+5);
    } else {
    }

    if (this.ySpeed > 0) {
      image(images[20], this.x, this.y, this.w+5, this.h+5);
      image(images[21], this.x, this.y, this.w+5, this.h+5);
    } else {
    }

    if (this.ySpeed < 0) {
      image(images[26], player.x, player.y, player.w+5, player.h+5);
      image(images[27], player.x, player.y, player.w+5, player.h+5);
    } else {
    }
  }
}




void chase(entity player) {
  for (int i=0; i<rooms[currentRoomX][currentRoomY].enemies.length; i++) {
    if (rooms[currentRoomX][currentRoomY].enemies[i].y > player.y + 1) {
      rooms[currentRoomX][currentRoomY].enemies[i].y -=rooms[currentRoomX][currentRoomY].enemies[i].ySpeed;
    } else {
    }
    if (rooms[currentRoomX][currentRoomY].enemies[i].y < player.y - 1) {
      rooms[currentRoomX][currentRoomY].enemies[i].y += rooms[currentRoomX][currentRoomY].enemies[i].ySpeed;
    } else {
    }

    if (rooms[currentRoomX][currentRoomY].enemies[i].x > player.x + 1) {
      rooms[currentRoomX][currentRoomY].enemies[i].x -= rooms[currentRoomX][currentRoomY].enemies[i].xSpeed;
      //println("left");
    } else {
    } 
    if (rooms[currentRoomX][currentRoomY].enemies[i].x < player.x - 1) {
      rooms[currentRoomX][currentRoomY].enemies[i].x += rooms[currentRoomX][currentRoomY].enemies[i].xSpeed;
    } else {
    }
  }
}
