particle[] elec = new particle[100];   //Enter the number of particles you want. Please note that a higher number may be taxing on the system.

PrintWriter hist1;
PrintWriter hist2;
float time1 = minute();
float endtime = 5;    //Enter time in minutes for which you want to run the experiment.

int j = 0;
void setup(){
  
  float x=0,y=0;
  int i,j;
  int diam = 20;            //This sets the diameter of the particles
  
  hist1 = createWriter("spatial_density.txt");
  hist2 = createWriter("Velocity_distribution.txt");

  size(500,500);
  
  //Initialising the particle objects
  for (int k = 0; k < elec.length; k++){
    x = random(width/10, width/1.2);
    y = random(height/10, height/1.2);
    elec[k] = new particle(x,y);
  }
  
  //Spawning at random places
  for ( i = 0; i < elec.length; i++){
 
   if (i!=0){
     
     for (  j = 0; j < elec.length; j ++){

       if (dist(x,y,elec[j].getX(),elec[j].getY()) <= diam){
         x = random(width/10, width/1.2);
         y = random(height/10, height/1.2);
         j = -1;
       }
     }
  }
      
        elec[i] = new particle(x,y,diam,random(-0.5,0.5),random(-0.5,0.5),1);
   
  }

}
void draw(){
  float time2 = minute();
  background(0);
  

  
  for (int i = 0; i < elec.length; i++){
    elec[i].update(elec);
    elec[i].move();
    elec[i].bounce();
    hist1.println(nf(elec[i].getX(),0,2) +","+ nf(elec[i].getY(),0,2) );
    hist2.println(nf(elec[i].getDX(),0,2) +","+ nf(elec[i].getDY(),0,2) );
   
  }
  hist1.println("F");
  hist2.println("F");
  
  
  if (abs(time1-time2)>endtime) { finish();}

}


  
void finish() {
  hist1.flush(); // Writes the remaining data to the file
  hist1.close(); // Finishes the file
  hist2.flush(); // Writes the remaining data to the file
  hist2.close(); // Finishes the file
  exit(); // Stops the program
}

  
