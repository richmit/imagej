
// This doesn't work.  Might be my version of ImageJ?

var java_alt = Java.type("Packages.java.awt.event.ActionListener");
var js_alt = Java.extend(java_alt, {
  actionPerformed: function(event) {
    source = event.getSource();
    print(source);
    if (source.label == "A")
      print("Button A Pressed");
    else if(source.label == "B")
      print("Button B Pressed");
  }
});


dialogObj = new Packages.ij.gui.GenericDialog("A/B Buttons");
var listener = new js_alt();
dialogObj.addButton("A", listener)
dialogObj.addButton("B", listener)
gui.showDialog()
