Particle[] star;
float backgroundX[] = new float[40]; 
float backgroundY[] = new float[40]; 
void setup()
{
  noStroke();
  size(1000, 1000);
  colorMode(HSB);
  background(0, 0, 0);
  star = new Particle[30];
  for (int i = 0; i < star.length - 1; i++)
    star[i] = new Particle();
  star[29] = new OddballParticle();
  frameRate(30);
  for (int i = 0; i < backgroundX.length; i++) {
    backgroundX[i] = (float)(width * Math.random());
    backgroundY[i] = (float)(height * Math.random());
  }
}

void draw()
{
  fill(0, 0, 0);
  rect(0, 0, width, height);
  star = removeParticle(star);
  for (int i = 0; i < backgroundX.length; i++) {
    fill((int)(Math.random() * 255), 0, 50);
    rect(backgroundX[i], backgroundY[i], 5, 5);
  }
  fill(0, 255, 30);
  ellipse(width/2, height/2, 700, 700);
  rect(width/2 - 350, height/2, 700, 1000);
  fill(150, 100, 30);
  rect(width/2 - 300, height/2, 600, 200, 50);
  for (int i = 0; i < star.length; i++)
  {
    star[i].move();
    star[i].draw();
  }
  star = (Particle[])(append(star, new Particle()));
  if (Math.random() < 0.03) {
    star = (Particle[])(append(star, new OddballParticle()));
  }
}
class Particle
{
  int myX, myY, hue;
  float angle, mov;
  Particle()
  {
    myX = width / 2;
    myY = height / 2;
    hue = (int)(Math.random() * 255);
    angle = (float)(Math.random() * 2 * PI);
    mov = (float)(Math.random() ) + 1;
  }

  void move()
  {
    myX += (int)(cos(angle) * mov );
    myY += (int)(sin(angle) * mov );
    mov *= 1.1;
  }

  void draw()
  {
    int bright = (int)(dist(myX, myY, width / 2, height / 2) );
    fill(hue, 50, bright);
    rect(myX, myY, 5, 5);
  }
}

class OddballParticle extends Particle
{
  OddballParticle() 
  {
    myX = width / 2;
    myY = height / 2;
    angle = (float)(Math.random() * 2 * PI);
    mov = 10;
  }

  void draw()
  {
    int bright = (int)(dist(myX, myY, width / 2, height / 2)  );
    if (bright > 180)
      bright = 180;

    fill(20, 255, 255);
    ellipse(myX, myY, mov, mov );
    fill(40, 255, 255);
    ellipse(myX, myY, mov*.8, mov*.8);
  }
}

Particle[] removeParticle(Particle[] star)
{
  Particle[] arr = {};
  for (int i = 0; i < star.length; i++)
  {
    if (!(star[i].myX < -50 || star[i].myX > width || star[i].myY < -50 || star[i].myY > height))
    {
      arr = (Particle[])(append(arr, star[i]));
    }
  }
  return arr;
}
