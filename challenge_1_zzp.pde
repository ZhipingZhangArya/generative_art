/*
challenge 1-poster-Zhiping Zhang.pdf, by Zhiping Zhang,a work for challenge 1 of DBB100 (2018-1) Creative Programming in TU/e,
 This programming is to develop an OP ART style poster with wavy lines texture and providing audiences a 3D feeling that the 2D poster is undulating,
 The use of sine function is inspired by (but not implementation) 
 one of the Sean Angley's processing work named sineExplorer, which could be accessed from https://www.openprocessing.org/sketch/132643,
 and the work of John, named Op Art, which could be accessed from https://www.openprocessing.org/sketch/432600 
 */

import processing.pdf.*;

void setup() {
  beginRecord(PDF, "challenge 1-poster-Zhiping Zhang.PDF");
  size(800, 800);
}


void draw() {
  // General logic is to draw belts whose thickness change follows a trigonometric function
  // Then, the lateral shift between adjacent belts also follows a trigonometric function
  background(0);
  float shift = 0; //shift is the lateral shift between two adjacent wavy belts
  float offset = 0; //offset is the lateral offset between lines which are the edges of belts
  float shift_value = 0.5;
  float offset_value = 0.12;
  int L = 6; // There are 6 wavy layers (adjacent belts which shift in the some direction are in the same layer)
  int b = 8; // There are 8 belts in a same layer 

  // Adjacent layers have opposite directions shifting
  for (int count=0; count<L; count++) {
    // Belts in even number layers shift to left
    // There are two thickness change principles, that is lines offset change principle, in the same even layer
    if (count % 2 == 0) {
      //offset increase first
      for (int i=count*b; i<count*b+(b/2); i++) {
        shift += shift_value;
        offset += offset_value;
        oneLine(i*20, color(255-i*b, i*b, 255, 255-i*b), shift, offset);
      }
      // then offset decrease to zero
      for (int i=count*b+(b/2); i<count*b+b; i++) {
        shift += shift_value;
        offset -= offset_value;
        // draw the lines according to those paremeters change)
        oneLine(i*20, color(255-i*b, i*b, 255, 255-i*b), shift, offset);
      }

    // Belts in odd number layers shift to right
    // Similarly, there are two lines offset principles but decrease first and then increase
    } else {
      for (int i=count*b; i<count*b+(b/2); i++) {
        shift -= shift_value;
        offset -= offset_value;
        oneLine(i*20, color(255-i*b, i*b, 255, 255-i*b), shift, offset);
      }
      for (int i=count*b+(b/2); i<count*b+b; i++) {
        shift -= shift_value;
        offset += offset_value;
        oneLine(i*20, color(255-i*b, i*b, 255, 255-i*b), shift, offset);
      }
    }
  }
  // sign my name at the button of poster
  // This program has refered to the processing reference source which could be accessed fromhttps://processing.org/reference/text_.html 
  String s = "our life";
  fill(255, 0, 255);
  text(s, width/2, height-90, width, height); 
  String s1 = "zzp.2018";
  fill(255, 0, 255,100);
  text(s1, width/2, height-80, width, height);

  endRecord();
}


void oneLine(int y, color c, float shift, float offset) {
  // oneLine function is to draw a belt which consists of two lines
  // y is distance between two lines, c is color of the belt
  int gap = 6; // the horizontal distance between points being taken from the each sine line
  int a = 16; // amplitude of one sine line
  int a1 = 18; // amplitude of the other sine line

  PVector [] pts = new PVector[width / gap + 1]; // pts is a vector array to 'contain'all the points in a line
  // put all the points in one line into pts
  for (int i=0; i<width / gap + 1; i++) {
    pts[i] = new PVector(i * gap, y + a * sin(i* 0.4 / PI + shift)); //The use of sine function here is inspired by (but not implementation) one of the Sean Angley's processing work named sineExplorer, which could be accessed from https://www.openprocessing.org/sketch/132643;
  }

  PVector [] pts1 = new PVector[width / gap + 1]; // ptsl is a vector array to 'contain' all the points in the next line
  // put all the points in the next line into pts1
  for (int i=0; i<width / gap + 1; i++) {
    pts1[i] = new PVector(i * gap, y + 5 + a1 * sin(i* 0.4 / PI + shift + offset));
  }

  // draw the a belt as drawing a closed polygon
  beginShape();
  noStroke();
  fill(c);
  // points in pts link with each other in turn
  for (int i=0; i<pts.length; i++) {
    vertex(pts[i].x, pts[i].y);
  }
  // points in pts1 have reverse links with each other so that the end point in pts could link with the begin point in pts1
  for (int i=pts1.length-1; i>=0; i--) {
    vertex(pts1[i].x, pts1[i].y);
  }
  endShape(CLOSE);
}
