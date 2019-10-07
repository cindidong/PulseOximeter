import processing.serial.*;

import cc.arduino.*;

Arduino arduino;
float val=0;
float x=0;
float pastX=0;
float pastY=0;
PImage photo;
boolean isPaused = false;


void setup() {
  photo = loadImage("underwater-background-with-different-marine-species_23-2147807753.jpg");
  size(626, 578);
  background(photo);
  stroke(255);
  
  // Prints out the available serial ports.
  println(Arduino.list());
  
  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);
  
  arduino.pinMode(0, Arduino.INPUT);
}

void draw() {
  if (isPaused == false)
  {
    val=arduino.analogRead(0);
    println(val);
    val = map(val, 0.0, 1023.0, 0.0, height);
    if (x< width)
    {
      strokeWeight(2);
      line(pastX, pastY, x, height-val);
      pastX=x;
      pastY=(height-val);
      x+=1;
    }
    else
    {
      x=0;
      background(photo);
      pastX=0;
    }
  }
}

void keyPressed()
{
  if (keyPressed && key == ' ')
  {
    if (isPaused == false)
    {
      isPaused = true;
    }
    else
    {
      isPaused = false;
    }
  }
}
