import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

void setup() {
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  size(720, 576);
  video = new Capture(this, 720, 576,cameras[0]);
  opencv = new OpenCV(this, 720, 576); 
opencv.startBackgroundSubtraction(5, 3, 0.5);
  video.start();
}

void draw() {
image(video, 0, 0 );
    opencv.loadImage(video);

opencv.updateBackground();

  
  
  opencv.dilate();
  opencv.erode();
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
 for (Contour contour : opencv.findContours()) {
    contour.draw();
  }
  fill(255, 0, 0);
  stroke(255, 0, 0);
  // DRAW MAPPING MARKERS
  for(int n=0;n<5;n++)
  {
    ellipse(5+(n*710), 5, 5, 5);
    ellipse(5+(n*710), 571, 5, 5);
  }

  
  
}

void captureEvent(Capture c) {
  c.read();
}