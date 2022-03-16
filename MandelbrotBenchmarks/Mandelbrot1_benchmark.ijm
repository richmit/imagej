// Create an image and draw a Mandelbrot set

timeStart = getTime();;
print("START TIME:  " + timeStart);




width    = 1024;
height   = 1024;
maxCount = 256;
left     =  -2;
top      =  -2; 
xside    =   4; 
yside    =   4;

newImage("mand", "8-bit", width, height, 1);

xscale = xside / width;
yscale = yside / height;

for(y = 1; y <= height; y++) {
  for(x = 1; x <= width; x++) {
    cx = x * xscale + left;
    cy = y * yscale + top;
    zx = zy = 0;
    count = 0;
    while((zx * zx + zy * zy < 4) && (count < maxCount)) {
      tempx = zx * zx - zy * zy + cx;
      zy = 2 * zx * zy + cy;
      zx = tempx;
      count++;
    }
	setPixel(x, y, (count)%256);
  }
}




timeEnd = getTime();
print("FINISH TIME: " + timeEnd);

timeEll = (timeEnd-timeStart)/1000;
print("ELAPSED TIME: " + timeEll);

