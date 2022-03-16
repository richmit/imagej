var timeStart = Date.now();
print("START TIME:  " + timeStart);

var width    = 1024;
var height   = 1024;
var maxCount = 256;
var left     =  -2.0;
var top      =  -2.0; 
var xside    =   4.0; 
var yside    =   4.0;

var ip = new Packages.ij.process.ColorProcessor(width, height)
var px = ip.getPixels();

xscale = xside / width;
yscale = yside / height;
var x, y, cx, cy, zx, zy, tempx, count;
for(y = 0; y < height; y++) {
  for(x = 0; x < width; x++) {
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
    px[x + y * width] = ((255-(10*count)%256) << 16) | (((6*count)%256) << 8) | (255-(count%256) << 0);
  }
}

var img = new Packages.ij.ImagePlus("mand", ip);
img.show();

var timeEnd = Date.now();
print("FINISH TIME: " + timeEnd);

timeEll = timeEnd-timeStart;
print("ELAPSED TIME: " + timeEll);
