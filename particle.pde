public class velocity {
  float delx, dely;

  //Constructor 1 
  public velocity() {
  }

  //Constructor 2
  public velocity(float delx, float dely) {
    this.delx = delx;
    this.dely = dely;
  }

  //Mutators for xvelocity and y velocity
  public float getdelx() {
    return this.delx;
  }

  public float getdely() {
    return this.dely;
  }

  //Accessors for xvelocity and y velocity
  public void setdelx(float delx) {
    this.delx = delx;
  }

  public void setdely(float dely) {
    this.dely = dely;
  }
}






public class particle {

  private float xpos, ypos, delx, dely, size, mass;
  //private color colour = color(0,0,0);

  //constructor 1
  public particle(float x, float y) {
    this.xpos = x;
    this.ypos = y;
  }

  //constructor 2
  public particle(float xpos, float ypos, float size, float delx, float dely, float mass) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.size = size;
    this.delx = delx;
    this.dely = dely;
    this.mass = mass;
  }

  //Mutators for size, x velocity y velocity and velocity vector
  public void setsize(float size) {
    this.size = size;
  }

  public void setDX(float delx) {
    this.delx = delx;
  }

  public void setDY(float dely) {
    this.dely = dely;
  }




  //Accessors for size, x position, y position, x velocity and y velocity

  public float getsize() {
    return this.size;
  }

  public float getX() {
    return this.xpos;
  }

  public float getY() {
    return this.ypos;
  }

  public float getDX() {
    return this.delx;
  }

  public float getDY() {
    return this.dely;
  }

  public float getmass() {
    return this.mass;
  }

  public velocity getvel() {

    velocity v = new velocity(this.getDX(), this.getDY());
    return v;
  }



  //Functionality. Moving around, Bouncing off of walls, and basic display updates
  public void move() {
    this.xpos += this.delx;
    this.ypos += this.dely;
  }

  public void bounce() {
    float decay = 1.3; //decay is a paramater which controls how much velocity (momentum) the particle loses upon collision with a 
                      // wall. 
                      
    if ( this.xpos - this.size/2.0 < 0 ) {
      this.setDX( Math.abs(this.getDX())/decay );
    } else if ( this.xpos + this.size/2.0 > width ) {
      this.setDX( -Math.abs(this.getDX())/decay );
    }

    if ( this.ypos - this.size/2.0 < 0 ) {
      this.setDY( Math.abs(this.getDY())/decay );
    } else if ( this.ypos + this.size/2.0 > height ) {
      this.setDY( -Math.abs(this.getDY())/decay );
    }
  }

  public void update(particle[] elec) {

    for (int i =0; i< elec.length; i++) {

      if (this == elec[i]) continue; //do not collide with itself. That will be trippy.
      
      //detect collision and resolve the velocities, i.e. momentum conservation.
      if (dist(this.getX(), this.getY(), elec[i].getX(), elec[i].getY()) - this.getsize() <0) {
        collision(this, elec[i]);
      }
    }
    display();
  }



  public void display() {

    stroke(0);
    float v = sqrt(pow(this.getDX(), 2)+pow(this.getDY(), 2)) / 8;

    stroke(255);
    SetFillFromHUE( v * 4.0/6.0 ); 
    ellipse(this.xpos, this.ypos, this.size, this.size);
  }

  public void SetFillFromHUE(float hue) {

    float R = Math.abs(hue * 6.0 - 3.0) - 1.0;
    float G = 2.0 - Math.abs(hue * 6.0 - 2.0);
    float B = 2.0 - Math.abs(hue * 6.0 - 4.0);
    fill(R*255.0, G*255.0, B*255.0);
  }
}



velocity rotate(velocity v, float angle) {
  float x = v.getdelx()*cos(angle) - v.getdely()*sin(angle);
  float y = v.getdelx()*sin(angle) + v.getdely()*cos(angle);

  velocity vel = new velocity(x, y);
  return vel;
}



void collision(particle p1, particle p2) {

  float xveldiff = p1.getDX()-p2.getDX();
  float yveldiff = p1.getDY()-p2.getDY();

  float xdist = p2.getX() - p1.getX();
  float ydist = p2.getY() - p1.getY();

  //Check for accidental overlaps of particles
  if (xveldiff*xdist + yveldiff*ydist >= 0) {

    float angle = -atan2(p2.getY() - p1.getY(), p2.getX() - p1.getX());

    float m1 = p1.getmass();
    float m2 = p2.getmass();

    velocity u1 = rotate(p1.getvel(), angle);
    velocity u2 = rotate(p2.getvel(), angle);

    velocity v1 = new velocity(u1.getdelx() * (m1 - m2) / (m1 + m2) + u2.getdelx() * 2 * m2 / (m1 + m2), u1.getdely());
    velocity v2 = new velocity(u2.getdelx() * (m1 - m2) / (m1 + m2) + u1.getdelx() * 2 * m2 / (m1 + m2), u2.getdely());

    velocity vf1 = rotate(v1, -angle);
    velocity vf2 = rotate(v2, -angle);

    p1.setDX(vf1.getdelx());
    p1.setDY(vf1.getdely());

    p2.setDX(vf2.getdelx());
    p2.setDY(vf2.getdely());
  }
}
