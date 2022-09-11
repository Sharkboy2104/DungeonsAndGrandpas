//player class

class entity {
  int health = 100;
  int x, y, xspeed, yspeed;
  int w, h;
  item[] items;
}

//draws the player
void drawPlayer() {
  fill(255);
  if (playerUp == true) {
    image(images[6], player.x, player.y, player.w+5, player.h+5);
    image(images[7], player.x, player.y, player.w+5, player.h+5);
  } else {
    image(images[0], player.x, player.y, player.w+5, player.h+5);
    image(images[1], player.x, player.y, player.w+5, player.h+5);
  }
  if (playerDown == true) {
    image(images[0], player.x, player.y, player.w+5, player.h+5);
    image(images[1], player.x, player.y, player.w+5, player.h+5);
  } else {

  }

  if (playerLeft == true) {
    image(images[2], player.x, player.y, player.w+5, player.h+5);
    image(images[3], player.x, player.y, player.w+5, player.h+5);
  } else {
    
  }

  if (playerRight == true) {
    image(images[4], player.x, player.y, player.w+5, player.h+5);
    image(images[5], player.x, player.y, player.w+5, player.h+5);
  } else {
  }
  //rect(player.x, player.y, player.w, player.h);
}
boolean playerUp = false;
boolean playerDown = false;
boolean playerLeft = false;
boolean playerRight = false;


//creates the player in the centre of the screen at the start
void createPlayer() {
  player.health = 100;
  player.x = width/2;
  player.y = height/2;
  player.w = 35;
  player.h = 45;
  player.xspeed =  0;
  player.yspeed =  0;

  player.items = new item[0];
}
