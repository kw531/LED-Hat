void setup() {
  // Select and load image
  selectInput("Select image file to convert:", "processImage");
}

void processImage(File image) {
  String      filename, basename, sum;
  PImage      img;
  PrintWriter output;
  int         x, bytesOnLine = 199;

  println("Loading image...");
  filename = image.getPath();
  img      = loadImage(image.getPath());

  // Morph filename into output filename and base name for data
  x = filename.lastIndexOf('.');
  if (x > 0) filename = filename.substring(0, x);  // Strip current extension
  x = filename.lastIndexOf('\\');
  if (x > 0) basename = filename.substring(x + 1); // Strip path
  else      basename = filename;
  filename += ".h"; // Append '.h' to output filename
  println("Writing output to " + filename);


  img.loadPixels();

  // Open header file for output (NOTE: WILL CLOBBER EXISTING .H FILE, if any)
  output = createWriter(filename);


  // Write image dimensions and beginning of array
  output.println("#ifndef _" + basename + "_h_");
  output.println("#define _" + basename + "_h_");
  output.println("#include <avr/pgmspace.h>");
  output.println();

  output.print("const int " + basename + "[] PROGMEM = {");


  int pix=0;
  //RED
  while (pix<1024) { //32x32=1024
    sum=hex(img.pixels[pix]).substring(2,8); //Get the hex code for the pixel, 2 decimals only
    if (++bytesOnLine >= 32) { // Wrap nicely should result in 32x32 hex array
      output.print("\n ");
      bytesOnLine = 0;
    }
    pix++;
    println("sum: " + Integer.parseInt(sum,16));
    int normal = Integer.parseInt(sum,16)/0x10101;
    println(normal);
    sum=Integer.toHexString(normal);
    println("sum hex: " + sum);
    output.print("0x"+ sum +","); // Write accumulated bits
  }
  pix=0;

  // --------------------------Green-------------------------------------
  output.println();
  output.println("};");
  output.println();
  //output.print("const int " + basename + "_Green[] PROGMEM = {");
  
  //while (pix<1024) { //32x32=1024
  //  sum=hex(img.pixels[pix]); //Get the hex code for the pixel, 2 decimals only
  //  if (++bytesOnLine >= 32) { // Wrap nicely should result in 32x32 hex array
  //    output.print("\n ");
  //    bytesOnLine = 0;
  //  }
  //  pix++;
  //  output.print("0x"+ sum.substring(4, 6)+","); // Write accumulated bits
  //}
  //pix=0;

  ////----------------------------------Blue----------------------------------
  //output.println();
  //output.println("};");
  //output.println();
  //output.print("const int " + basename + "_Blue[] PROGMEM = {");
  //// Blue
  //while (pix<1024) { //32x32=1024
  //  sum=hex(img.pixels[pix]); //Get the hex code for the pixel, 2 decimals only
  //  if (++bytesOnLine >= 32) { // Wrap nicely should result in 32x32 hex array
  //    output.print("\n ");
  //    bytesOnLine = 0;
  //  }
  //  pix++;
  //  output.print("0x"+ sum.substring(6, 8)+","); // Write accumulated bits
  //}

  //output.println();
  //output.println("};");
  output.println();
  output.println("#endif // _" + basename + "_h_");
  output.flush();
  output.close();
  println("Done!");
  exit();
}