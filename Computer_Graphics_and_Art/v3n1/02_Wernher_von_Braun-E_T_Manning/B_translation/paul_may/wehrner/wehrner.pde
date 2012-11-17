/*

 This sketch is part of the ReCode Project - http://recodeproject.com
 From Computer Graphics and Art vol3 no1 pg 5
 by E.T. Manning
 
 "Wehrner Von Braun", Photo of output of optical processor for spatial quantization. 24in x 18in
 Other works in the series are "Horizontal Rows", "Outwards", as
 well as the "Permutation" works.
 
 Paul May
 2012
 Creative Commons license CC BY-SA 3.0
 
/* ---------------- GLOBALS ---------------------- */

String sketchname = "wehrner";
PImage original_img; //the original source image of Von Braun
PImage quantized_img; //where we'll store our quantized image.

color[] allowed_colours = {
  #000000,#222222,#FFFFFF
};

/* ---------------- SETUP ---------------------- */

void setup() {
  //size(1920, 1080); //FHD
  //size(1360, 768); //HD
  //size(1280,720); //720p
  //size(1093, 614); //QFHD
  size(800, 600); //4:3 low res

  /* What is Quantization? 
   
   From WikiPedia "a process that reduces 
   the number of distinct colors used in an image, usually with the intention that the new 
   image should be as visually similar as possible to the original image. Computer algorithms 
   to perform color quantization on bitmaps have been studied since the 1970s. 
   Color quantization is critical for displaying images with many colors on devices that can only 
   display a limited number of colors, usually due to memory limitations, and enables efficient 
   compression of certain types of images."
   
   http://en.wikipedia.org/wiki/Color_quantization
   
   */


  /* Load original image. 
   
   Image caption: Dr. Wernher von Braun in his Office - Dr. Wernher von Braun is in his office, with an artist's concept 
   of a lunar lander in background and models of Mercury-Redstone, Juno, and Saturn I. Dr. Wernher von Braun, the first 
   MSFC Director, led a team of German rocket scientists, called the Rocket Team, to the United States, first to 
   Fort Bliss/White Sands, later being transferred to the Army Ballistic Missile Agency at Redstone Arsenal in Huntsville, Alabama.
   Image source: http://space.about.com/od/rocketrybiographies/ig/Wernher-von-Braun-Pictures-Gal/Wernher-von-Braun-in-Office.htm
   Image retrieved: November 17th 2012
   
   */

  original_img = loadImage("data/wehrner_resized.jpg");
  original_img.loadPixels();
  quantized_img = new PImage();
  quantized_img.loadPixels();

  /* Now that we have the image, 
   loop through each pizel of the image
   calculate the distance between the colour of that pizel and each of our allowed colours
   populate the pixel array of our quantized_img with the colour that is closest
   */
  //
  for (int x = 0; x < original_img.pixels.length ; x++) {   // loop through each pixel of the image;
    float minDistance = 1000000;
    int minIndex = 10000;
    //original_img.pixels[x] = allowed_colours[floor(random(colours.length))]; //just a test, set the pixel to a random, allowed colour
    minDistance = 1000;
    minIndex = 0;
    for (int y = 0;y < allowed_colours.length;y++) {
      // calculate the distance between the colour of that pixel and each of our allowed colours
      float redDistance = red(allowed_colours[y])-red(original_img.pixels[x]);
      float greenDistance = green(allowed_colours[y])-green(original_img.pixels[x]);
      float blueDistance = blue(allowed_colours[y])-blue(original_img.pixels[x]);
      float colourDistance = abs(redDistance+greenDistance+blueDistance);
      //is this the smallest distance we've seen?
      if (colourDistance < minDistance) {
        minDistance = colourDistance;
        minIndex = y;
      }
    }
    //set the colour of the pixel in the image to the colour in our allowed colours
    original_img.pixels[x] = allowed_colours[minIndex];
  }
}

/* ---------------- DRAW ---------------------- */


void draw() {
  //map the size of the inputted image to our window size
  image(original_img, 0, 0, map(original_img.width, 0, original_img.width, 0, width),map(original_img.height, 0, original_img.height, 0, height));
}


/* ---------------- HANDY FUNCTIONS ---------------------- */

void keyPressed() {
  switch(key) {
  case 's': 
    screenShot();
    break;
}
}

void screenShot() {
  //take a timestamped screenshot
  Date date = new Date();
  Format dateFormat;
  dateFormat = new SimpleDateFormat("dd.MM.yyyy_HH.mm.ss");
  String d = dateFormat.format(date);
  String fileName = "screenshots/"+d+"_"+millis()+"_"+sketchname+".png";
  save(fileName);
  println("took screenshot: "+fileName);
}

