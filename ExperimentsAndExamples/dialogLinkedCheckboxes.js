
var gd = new Packages.ij.gui.GenericDialog("Command Launcher");
gd.addCheckbox("foo+bar", true);
gd.setInsets(5, 50, 0);
gd.addCheckboxGroup(1, 2, ["foo", "bar"], [true, true]);

var gdCheckboxes = gd.getCheckboxes();

gd.addDialogListener(new Packages.ij.gui.DialogListener( {
  dialogItemChanged: function(diag, event) {
  	if (event != null) {
	  var source = event.getSource();
	  if (source == gdCheckboxes[0]) {
	    gdCheckboxes[1].state=source.state;
	    gdCheckboxes[2].state=source.state;
	  } else {
	    gdCheckboxes[0].state = gdCheckboxes[1].state && gdCheckboxes[2].state;
	  }
  	}
    return true;
  }
}));

gd.showDialog();

print("HI HO");
