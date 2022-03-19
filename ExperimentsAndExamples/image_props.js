var srcImg = Packages.ij.IJ.getImage();

srcImg.setProp("foo", "bar");
srcImg.setProp("foobar", 1.2);

print(srcImg.getImageProperties());

print(srcImg.getProp("foo"));

print(srcImg.getProp("foobar").class);
print(srcImg.getNumericProp("foobar").class);
