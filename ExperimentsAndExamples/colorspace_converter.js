// Convert RGB color to HSB -- RGB inputs [0, 255] while HSB outputs [0, 1].
var csc = new Packages.ij.process.ColorSpaceConverter();
var hsb = csc.RGBtoHSB(0, 255, 0);
var hue = hsb[0];
var sat = hsb[1];
var val = hsb[2];
print("HSB: (" + (hue*360) + ", " + sat + ", " + val + ")");
