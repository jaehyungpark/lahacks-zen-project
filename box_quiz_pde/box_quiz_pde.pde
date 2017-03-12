import java.util.ArrayList;
ArrayList rectangle;
ArrayList triangle;

Query queryBeingDragged;

int dragX;
int dragY;

void setup() {
 queryBeingDragged = null;
 rectangle = new ArrayList();
 triangle = new ArrayList();
 
 
 size(500, 400);
 smooth();
 
 // draw boxes only for this time
 // later add different shapes or import images
 rectangle.add( new Query("box1", color(255,255,0), width/7.0+80, height/7.0+80, 0, 40, 40, 0));
 rectangle.add( new Query("box2", color(0,0,255), width/7.0, height/7.0+80, 0, 40, 40, 0));
 rectangle.add( new Query("box3", color(0,255,0), width/7.0+80, height/7.0, 0, 40, 40, 0));
 rectangle.add( new Query("box4", color(255,0,0), width/7.0, height/7.0, 0, 40, 40, 0));
}

void draw() {  
 background(255);
 for(int i = 0; i < rectangle.size(); i++){
   Query myQuery1 = (Query)rectangle.get(i);
   myQuery1.display();
 }  
}

class Query {
 String name;
 
 // variables
 color qc;
 float qx;
 float qy;
 float qz;
 int dQx;
 int dQy;
 int dQz;

// think of the z axis value and add more values to figure out the points for the triangle

 // c'tor
 Query(String name, color tempQc, float tempQx, float tempQy, float tempQz, int tempdQx, int tempdQy, int tempdQz) {
  this.name = name;
  qc = tempQc;
  qx = tempQx;
  qy = tempQy;
  qz = tempQz;
  dQx = tempdQx;
  dQy = tempdQy;
  dQz = tempdQz;
 }

 void display() {
   stroke(0);
   fill(qc);
   rectMode(RADIUS);
   rect(qx,qy,dQx,dQy);
   //triangle(qx,qy,qz,dQx,dQy,dQz);
 }
 
 boolean inQuery(int x, int y) {
   //changed to x > qx-dQx and y > qy-dQy
   if((x > qx-dQx) & x < (qx+dQx)) {
     if((y > qy-dQy)  & y < (qy+dQy)) {
       return true;
     }
   }
   return false;
 }
}  

void mousePressed() {
 for(int i = 0; i < rectangle.size(); i++){ 
    // note how I made it generic
   Query myQuery1 = (Query)rectangle.get(i);
   evaluateQuerySelection(myQuery1);
 }
 println("pressed");
}

void evaluateQuerySelection(Query myQuery1) { 
 // note how absolutely lazy I was in just pasting the old code
if (myQuery1.inQuery(mouseX, mouseY) & queryBeingDragged==null) { 
   //note how it will not evaluate if something is already being dragged

   dragX = (int)myQuery1.qx - mouseX;
   dragY = (int)myQuery1.qy - mouseY;
   queryBeingDragged = myQuery1;
 }
}

void mouseReleased() {
 queryBeingDragged = null; 
}

void mouseDragged() {
 if( queryBeingDragged != null){
    println("dragging" + queryBeingDragged.name);
   moveQueryByMouse(queryBeingDragged);
  }
}  

void moveQueryByMouse(Query myQuery1) {
 myQuery1.qx = mouseX + dragX;
 myQuery1.qy = mouseY + dragY;
}