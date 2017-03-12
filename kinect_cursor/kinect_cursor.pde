import org.openkinect.processing.*;

// Kinect Library object
Kinect2 kinect2;

// for the default value, it works about 1 feet away from the Kinect device
// we're looking to optimize the distance somewhere between 3 to 4 feet
// the maximum disstance a Kinect can detect is 4500
float minThresh = 480; // 480 (default)
float maxThresh = 830; // 830 (default)
PImage img;

void setup() {
  size(512, 424); // not full screen, default screen size
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
}

// use your hand to track the cursor and point the object
// then use the other hand to pinpoint the object, which will middle out the cursor between two hands
// this way, we can compare the depth value between the empty space(black) and hand space(pink)
// and if there is a difference, use grab motion
void draw() {
  background(0);

  img.loadPixels();
  
  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for (int x = 0; x < kinect2.depthWidth; x++) {
    for (int y = 0; y < kinect2.depthHeight; y++) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      // we will be comparing
      int empty = depth[0]; // some arbitrary value that is empty

      // if the offset depth value is within the range
      if (d > minThresh && d < maxThresh && x > 0) {
        img.pixels[offset] = color(255, 0, 150);
        
        sumX += x;
        sumY += y;
        totalPixels++;
        
        // if the depth value d becomes the same as empty (dark)
        if (d == empty) {
         // grab the object
        }
        
      } else {
        // color 
        img.pixels[offset] = color(0);
      }  
    }
  }

  img.updatePixels();
  image(img, 0, 0);
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(150,0,255);
  ellipse(avgX, avgY, 64, 64);
}