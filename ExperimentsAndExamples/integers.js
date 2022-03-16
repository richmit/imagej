
print("FOO");
var foo = (1 << 17);

print(foo.class);
print(foo);

print("BAR");
var byteType = Java.type("java.lang.Byte");
var bar = new byteType(255);

print(bar.class);
print(bar);

bar = 255;

print(bar.class);
print(bar);

print("IMG");
  var srcImg = Packages.ij.IJ.getImage();
  var srcPro = srcImg.getProcessor();
  var srcPix = srcPro.getPixels();


print(srcPix[0].class);

var spv = (1 << 32) - 1;
srcPix[0] = srcPix[2]
srcPix[1] = -15785442; // (15 << 16) | (34 << 8) | 30;
print(spv);
print(srcPix[0]);
print(srcPix[0].class);


print("BAI");
var jit = Java.type("java.lang.Integer");
var bai = new jit(spv);
print(bai);
print(bai.class);
print(1<<32);
