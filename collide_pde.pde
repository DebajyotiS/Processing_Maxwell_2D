// Author: Debajyoti Sengupta, Department of Physics, University of Calcutta, Kolkata, India.
// Simulation of maxwellian gas in a 2-D box whose walls are leaking energy
// The colours of the particles are mapped to their velocities - the fastest moving particles are blue in colour, the slowest are red.
// Please see accompanying particle class for the functionalities.
// Press r to record the state of the system frame by frame. PS : This may be taxing on your system. Please reduce particle numbers in you don't have a particularly srong system.



particle[] elec = new particle[600];
//PrintWriter hist;
boolean record = false;
color colour;
void setup() {
  //hist = createWriter("co-ordinate.txt");
  float x=0, y=0;
  int i, j;
  float diam = 10;


  size(800, 600);

  //Initialising the particle objects
  for (int k = 0; k < elec.length; k++) {
    x = random(width/10, width/1.2);
    y = random(height/10, height/1.2);
    elec[k] = new particle(x, y);
  }

  //Spawning at random places
  for ( i = 0; i < elec.length; i++) {

    if (i!=0) {

      for (  j = 0; j < elec.length; j ++) {

        if (dist(x, y, elec[j].getX(), elec[j].getY()) <= diam) {
          x = random(width/10, width/1.2);
          y = random(height/10, height/1.2);
          j = -1;
        }
      }
    }

    elec[i] = new particle(x, y, diam, random(-4, 4), random(-4, 4), 1);
  }
}
void draw() {
  background(255);

  for (int i = 0; i < elec.length; i++) {
    elec[i].update(elec);
    elec[i].move();
    elec[i].bounce();
    if (record) {
      saveFrame("collide_#####.png");
      fill(255, 0, 0);
    } else {
      fill(0, 255, 0);
    }

    ellipse(width/1.01, height/1.01, 5, 5);
  }
}

void keyPressed() {
  if (key =='r' || key =='R') {
    record = !record;
  }
}
