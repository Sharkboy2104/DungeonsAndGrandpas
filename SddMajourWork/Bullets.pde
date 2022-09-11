float fireRate = 20;
float bulletSpeed =3;

class bullet {
  //bullet class
  float x, y, xSpeed, ySpeed;
  int bulletSize = 10; 
  boolean balive = true;
  float maxRange = 300;
  float initialx = player.x;
  float initialy = player.y;


  void drawBullet() {
    //draws bullet
    for (int i=0; i<bullets.length; i=i+1) {
      //top half
      if (bullets[i].xSpeed > 0 && Math.abs(bullets[i].initialx- bullets[i].x ) <= bullets[i].maxRange && bullets[i].ySpeed < 0 && Math.abs(bullets[i].initialy - bullets[i].y) <= bullets[i].maxRange) {

        image(images[10], bullets[i].x, bullets[i].y);
      }
      if (bullets[i].xSpeed < 0 && Math.abs(bullets[i].initialx - bullets[i].x ) <= bullets[i].maxRange && bullets[i].ySpeed < 0 && Math.abs(bullets[i].initialy - bullets[i].y) <= bullets[i].maxRange) {
        image(images[9], bullets[i].x, bullets[i].y);
      }

      //Bottom half
      if (bullets[i].xSpeed > 0 && Math.abs(bullets[i].initialx- bullets[i].x ) <= bullets[i].maxRange && bullets[i].ySpeed > 0 && Math.abs(bullets[i].initialy - bullets[i].y) <= bullets[i].maxRange) {
        image(images[10], bullets[i].x, bullets[i].y);
      }
      if (bullets[i].xSpeed < 0 && Math.abs(bullets[i].initialx - bullets[i].x ) <= bullets[i].maxRange && bullets[i].ySpeed > 0 && Math.abs(bullets[i].initialy - bullets[i].y) <= bullets[i].maxRange) {
        image(images[9], bullets[i].x, bullets[i].y);
      }


      //if (bullets[i].ySpeed < 0 && Math.abs(bullets[i].initialy - bullets[i].y) <= bullets[i].maxRange) {
      //  image(images[11], bullets[i].x, bullets[i].y);
      //}
      //if (bullets[i].ySpeed < 0 && Math.abs(this.y - this.initialy) >= this.maxRange) {
      //  image(images[8], this.x, this.y);
      //}
      //circle(this.x, this.y, this.bulletSize);
    }
  }


  void destroyBullet() {
    //doesnt work
    if (Math.abs(this.x - this.initialx) >= this.maxRange) {
    }

    if (this.x+this.bulletSize >=width-30) {
      bullets = null;
    }
    if (this.x+this.bulletSize <=40) {
      bullets = null;
    }
    if (this.y-this.bulletSize <= 0) {
      bullets=null;
    }
    if (this.y+this.bulletSize >=height-30) {
      bullets = null;
    }
  }

  void shoot() {
    //shoots bullets and makes them move
    if (balive==true) {
      if (x>width||x<0||y>height||y<0) {
        //bullets = null;
      } else {
        fill(255, 100, 0);
        this.drawBullet();
        x+=xSpeed;
        y+=ySpeed;
      }
    }
  }
}


void fire() {
  if (frameCount % fireRate==0) {
    //creates new bullet
    bullets=(bullet[])append(bullets, new bullet());
    //gives x value 
    bullets[bullets.length-1].x=player.x;
    //gives y value
    bullets[bullets.length-1].y=player.y;
    //shoots in direction of the mouse x
    bullets[bullets.length-1].xSpeed=(mouseX-player.x)/sqrt((((mouseX-player.x)*(mouseX-player.x))+((mouseY-player.y)*(mouseY-player.y))))*bulletSpeed;
    //shoots in direction of the mouse y
    bullets[bullets.length-1].ySpeed=(mouseY-player.y)/sqrt((((mouseX-player.x)*(mouseX-player.x))+((mouseY-player.y)*(mouseY-player.y))))*bulletSpeed;
  }
}

void bulletUpdate() {
  //updates the pullet position
  for (int i=0; i<bullets.length; i=i+1) {
    bullets[i].shoot();
    //println("there are bullets", bullets.length);
  }
}
