
var java_mlt = Java.type("java.awt.event.MouseAdapter");
var js_mlt = Java.extend(java_mlt, {
	mousePressed: function(event) {
		var x = event.getX();
		var y = event.getY();
	    var canvas = event.getSource()
        var srcImg    = canvas.getImage()
        var srcPro = srcImg.getProcessor();
        var srcPix = srcPro.getPixels();
        var srcWidth  = srcImg.getWidth(); 
        var srcHeight = srcImg.getHeight();

        Packages.ij.IJ.log("Click Event " + event);
        Packages.ij.IJ.log("Click canv: " + canvas);
        Packages.ij.IJ.log("Click img: " + srcImg);
        Packages.ij.IJ.log("Click img: " + srcPro);
        Packages.ij.IJ.log("Click img: " + srcPix);
        Packages.ij.IJ.log("Click x: " + x);
        Packages.ij.IJ.log("Click y: " + y);
    }
});

var listener = new js_mlt();   

var imgWindow = Packages.ij.WindowManager.getCurrentWindow();
 
imgWindow.getCanvas().addMouseListener(listener);

Packages.ij.IJ.log("HELLO");

java.lang.Thread.sleep(5000);

imgWindow.getCanvas().removeMouseListener(listener);
Packages.ij.IJ.log("BYE");
