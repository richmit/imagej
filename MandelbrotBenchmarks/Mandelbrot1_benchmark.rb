# Create an image and draw a Mandelbrot set

timeStart = Time.now;
puts("START TIME:  " + timeStart.to_s);

java_import "ij.process.ColorProcessor"
java_import "ij.ImagePlus"

width    = 1024;
height   = 1024;
maxCount = 256;
left     =  -2.0;
top      =  -2.0; 
xside    =   4.0; 
yside    =   4.0;

ip = ColorProcessor.new(width, height)

xscale = xside / width;
yscale = yside / height;

0.upto(height-1) do |y|
  0.upto(width-1) do |x|
    cx = x * xscale + left;
    cy = y * yscale + top;
    zx = zy = 0.0;
    count = 0;
    while ((zx * zx + zy * zy < 4.0) && (count < maxCount)) 
      tempx = zx * zx - zy * zy + cx;
      zy = 2 * zx * zy + cy;
      zx = tempx;
      count = count + 1;
    end
	ip.set(x, y, ((255-(10*count)%256) << 16) | (((6*count)%256) << 8) | (255-(count%256) << 0));
  end
end

img = ImagePlus.new "mand", ip
img.show

timeEnd = Time.now;
puts("FINISH TIME: " + timeEnd.to_s);

timeEll = timeEnd-timeStart;
puts("ELAPSED TIME: " + timeEll.to_s);
