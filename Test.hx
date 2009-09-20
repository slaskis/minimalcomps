
/*
Known Issues:
 - VBox won't position Knob and InputText properly
 - ColorChooser doesn't position it's popup correctly
 - Event targets isn't the object but the _comp 
 - "-swf-lib font/pf_ronda_seven.swf" must be added when compiling 
*/

class Test extends flash.display.Sprite {
	
	public function new() {
		super();
		
		new minimalcomps.Text( this , 0 , 0 , "Text" );
		
		new minimalcomps.HUISlider( this , 220 , 0 , "Horizontal Slider" );
		new minimalcomps.VUISlider( this , 220 , 20 , "Vertical Slider" );
		
		var vbox = new minimalcomps.VBox( this , 0 , 120 );
		new minimalcomps.RadioButton( vbox , 0 , 0 , "Radio 1" , false );
		new minimalcomps.RadioButton( vbox , 0 , 0 , "Radio 2" , false );
		new minimalcomps.RadioButton( vbox , 0 , 0 , "Radio 3" , true );
		
		var wheel = new minimalcomps.WheelMenu( this , 6 );
		new minimalcomps.PushButton( this , 100 , 120 , "Show WheelMenu" , function(e) {
			wheel.show();
		} );
		
		var hbox = new minimalcomps.HBox( this , 0 , 200 );
		new minimalcomps.CheckBox( hbox , 0 , 0 , "Check 1" );
		new minimalcomps.CheckBox( hbox , 0 , 0 , "Check 2" );
		new minimalcomps.CheckBox( hbox , 0 , 0 , "Check 3" );
		
		var vbox = new minimalcomps.VBox( this , 290 , 20 );
		new minimalcomps.Knob( vbox , 0 , 0 , "Knob" );	
		new minimalcomps.InputText( vbox , 0 , 0 , "InputText" );	
		var hbox = new minimalcomps.HBox( vbox );
		var light = new minimalcomps.IndicatorLight( hbox );
		var col : minimalcomps.ColorChooser = null;
		col = new minimalcomps.ColorChooser( hbox , 0 , 0 , null , function(e) {
			light.color = col.value;
			light.flash();
		} );
		col.usePopup = true;
		new minimalcomps.ProgressBar( vbox ).value = 1;
		
		var win = new minimalcomps.Window( this );
		win.hasMinimizeButton = true;
		win.minimized = true;
		win.setSize( 400 , 200 );
		var hbox = new minimalcomps.HBox( win.content , 0 , 0 );
		new minimalcomps.CheckBox( hbox , 0 , 0 , "Check 1" );
		new minimalcomps.CheckBox( hbox , 0 , 0 , "Check 2" );
		new minimalcomps.CheckBox( hbox , 0 , 0 , "Check 3" );
		new minimalcomps.Meter( win.content , 0 , 40 ).value = .5;
		
	}
	
	static function main() {
		flash.Lib.current.addChild( new Test() );
	}
}