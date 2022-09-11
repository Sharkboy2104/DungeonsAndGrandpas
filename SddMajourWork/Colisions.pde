//This is a program that checks if 2 entitys are colliding then returns true if they are
boolean collision(int x, int y, int w, int h, int x2, int y2, int w2, int h2) {
  if (x + w >= x2 && x<= x2+w2 && y+h>= y2 && y<= y2+h2) {
    return true;
  } else {
    return false;
  }
}
//This is a program that checks if 2 entitys are colliding then returns true if they are
boolean bcollision(float x, float y, int bulletSize, int x2, int y2, int w2, int h2) {
  if (x + bulletSize >= x2 && x<= x2+w2 && y+bulletSize>= y2 && y<= y2+h2) {
    return true;
  } else {
    return false;
  }
}


void bulletEnemyCollision() {
  //this program uses the bcollision program to check if bullets and enemies are colliding then kills the enemy and stops 
  //loops through enemies
  for (int i=0; i<rooms[currentRoomX][currentRoomY].enemies.length; i++) {
    //loops through bullets
    for (int j=0; j<bullets.length; j++) {
      if (bcollision(bullets[j].x, bullets[j].y, bullets[j].bulletSize, 
        rooms[currentRoomX][currentRoomY].enemies[i].x, 
        rooms[currentRoomX][currentRoomY].enemies[i].y, 
        rooms[currentRoomX][currentRoomY].enemies[i].w, 
        rooms[currentRoomX][currentRoomY].enemies[i].h)==true && rooms[currentRoomX][currentRoomY].enemies[i].alive == true) {
        //if bullets is alive/ kill enemy then increase kill count
        if (bullets[i].balive == true ) {
          rooms[currentRoomX][currentRoomY].enemies[i].alive = false;
          rooms[currentRoomX][currentRoomY].killCount +=1;
        }else{
        
        }
        
      }
    }
  }
}

void enemyCollision() {
  //loops through the enemies
  for (int i=0; i<rooms[currentRoomX][currentRoomY].enemies.length; i++) {
    //checks if their alive
    if (rooms[currentRoomX][currentRoomY].enemies[i].alive == true) {
      //uses collision program to check if player is colliding with an enemy// wont be used in final game
      if (collision(player.x, player.y, player.w, player.h, 
        rooms[currentRoomX][currentRoomY].enemies[i].x, 
        rooms[currentRoomX][currentRoomY].enemies[i].y, 
        rooms[currentRoomX][currentRoomY].enemies[i].w, 
        rooms[currentRoomX][currentRoomY].enemies[i].h)==true && isInvincible == false) {
        playerHit = true; 
        isInvincible = true;
      } else {
        if (frameCount % 100==0) {
          isInvincible = false;
        }
      }
    }
  }
}
void objCollision() {
  for (int i=0; i<rooms[currentRoomX][currentRoomY].obstacles.length; i++) {
    //if (rooms[currentRoomX][currentRoomY].enemies[i].alive == true) {
    if (collision(player.x, player.y, player.w, player.h, 
      rooms[currentRoomX][currentRoomY].obstacles[i].x, 
      rooms[currentRoomX][currentRoomY].obstacles[i].y, 
      rooms[currentRoomX][currentRoomY].obstacles[i].w, 
      rooms[currentRoomX][currentRoomY].obstacles[i].h)==true) {
      player.x=player.x-player.xspeed;
      player.y=player.y-player.yspeed;
      
    }
  }
}

void bulletBounce() {
  //this program uses the bcollision program to check if bullets and enemies are colliding then kills the enemy and stops 
  //loops through enemies
  for (int i=0; i<rooms[currentRoomX][currentRoomY].obstacles.length; i++) {
    //loops through bullets
    for (int j=0; j<bullets.length; j++) {
      if (bcollision(bullets[j].x, bullets[j].y, bullets[j].bulletSize, 
        rooms[currentRoomX][currentRoomY].obstacles[i].x, 
        rooms[currentRoomX][currentRoomY].obstacles[i].y, 
        rooms[currentRoomX][currentRoomY].obstacles[i].w, 
        rooms[currentRoomX][currentRoomY].obstacles[i].h)==true) {
        //if bullets is alive/ kill enemy then increase kill count
        bullets[j].xSpeed -= bullets[j].xSpeed *2;
        
        }
      }
    }
  }

//}


void drawWalls() {
  //draws walls
  fill(90);
  rect(0, 0, 30, height);
  rect(width-30, 0, 30, height);
  rect(0, 0, width, 30);
  rect(0, height-30, width, 30);
  //right wall collision
  if (player.x+player.w >=width-30) {
    player.x = player.x-2;
    player.xspeed=0;
  }
  //left wall collision
  if (player.x+player.w <=60) {
    player.x = player.x+2;
    player.xspeed=0;
  }
  //Top wall collision
  if (player.y-player.h <= -20) {
    player.y = player.y+2;
    player.yspeed=0;
  }
  //bottom wall collision
  if (player.y+player.h >=height-30) {
    player.y = player.y-2;
    player.yspeed=0;
  }
}


void doorsCollision() {
  //loops through the doors array of strings to see if there is a door in each place
  for (int i = 0; i <rooms[currentRoomX][currentRoomY].doors.length; i ++) {
    //if there is a door string called right and you collide with the door
    if (collision(player.x, player.y, player.w, player.h, width-30, height/2, 60, 60)==true && doorsOpen==true && rooms[currentRoomX][currentRoomY].doors[i] == "RIGHT") {
      //go to next room to the right
      currentRoomX = currentRoomX+1;
      //closes doors
      doorsOpen=false;
      player.x =0+60;
      //sets you to left of next room
      player.y = height/2;
      println("next room right");
    }
    //if there is a door string called left and you collide with the door
    if (collision(player.x, player.y, player.w, player.h, 0, height/2, 30, 60)==true && doorsOpen==true && rooms[currentRoomX][currentRoomY].doors[i] == "LEFT") {
      //moves to room to the left
      currentRoomX= currentRoomX-1;
      //takes u to right of next room
      player.x =width-90;
      player.y = height/2;
      doorsOpen=false;
    }
    if (collision(player.x, player.y, player.w, player.h, width/2, 5, 60, 30)==true && doorsOpen==true && rooms[currentRoomX][currentRoomY].doors[i] == "UP") {
      currentRoomY = currentRoomY-1;
      player.x =width/2;
      player.y = height-100;
      doorsOpen=false;
    }
    if (collision(player.x, player.y, player.w, player.h, width/2-30, height-30, 60, 60)==true && doorsOpen==true && rooms[currentRoomX][currentRoomY].doors[i] == "DOWN") {
      currentRoomY = currentRoomY+1;
      player.x =width/2;
      player.y = 60;
      doorsOpen=false;
      println("Next Room");
    }
  }
}


// loop through the doors in a room then check each one if they are colliding
