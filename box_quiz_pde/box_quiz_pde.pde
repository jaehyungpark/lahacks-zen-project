import java.util.ArrayList;
ArrayList myQueries;

Query queryBeingDragged;

int dragX;
int dragY;

void setup() {
 queryBeingDragged = null;
 myQueries = new ArrayList();
 
 size(800, 600);
 smooth();
  
 myQueries.add( new Query("box1", color(0,0,255), width/5.0+200, height/5.0+100, 0, 60, 40, 0));
 myQueries.add( new Query("box2", color(255,0,0), width/5.0, 4.0*height/5.0, 0, 80, 20, 0));
 myQueries.add( new Query("box3", color(0,255,0), width/5.0+50, height/5.0+50, 0, 40, 60, 0));
 myQueries.add( new Query("triangle1", color(0,255,255), width/5.0+100, height/5.0, 0, 50, 50, 0));
}

void draw() {
 background(255);
 
 for(int i = 0; i < myQueries.size(); i++){
   Query myQuery1 = (Query)myQueries.get(i);
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

 // c'tor
 Query(String name, color tempQc, float tempQx, float tempQy,float tempQz, int tempdQx, int tempdQy, int tempdQz) {
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
 for(int i = 0; i < myQueries.size(); i++){ 
    // note how I made it generic
   Query myQuery1 = (Query)myQueries.get(i);
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