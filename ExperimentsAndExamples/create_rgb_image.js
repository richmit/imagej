var type = "RGB";
var width = 1024;
var height = 512;
var im = Packages.ij.IJ.createImage("New image", type, width, height, 1);
var ip = im.getProcessor();
var px = ip.getPixels();
for (var j = 0; j < height; j++) 
	for (var i = 0; i < width; i++) 
        px[i + width * j] = ((i & 0xff) << 16) | ((j & 0xff) << 8) | ((i+j) & 0xff << 0);
im.show();
