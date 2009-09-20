/**
 * RadioButton.as
 * Keith Peters
 * version 0.97
 * 
 * A basic radio button component, meant to be used in groups, where only one button in the group can be selected.
 * Currently only one group can be created.
 * 
 * Copyright (c) 2009 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package minimalcomps;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;

class RadioButton extends Component {
	
	public var label(getLabel, setLabel) : String;
	public var selected(getSelected, setSelected) : Bool;
	
	var _back:Sprite;
	var _button:Sprite;
	var _selected:Bool ;
	var _label:Label;
	var _labelText:String ;
	
	static var buttons:Array<RadioButton>;
	
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this RadioButton.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param label The string to use for the initial label of this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?label:String = "", ?checked:Bool = false, ?defaultHandler:Dynamic = null) {		
		_selected = false;
		_labelText = "";
		RadioButton.addButton(this);
		_selected = checked;
		_labelText = label;
		super(parent, xpos, ypos);
		if(defaultHandler != null)
			addEventListener(MouseEvent.CLICK, defaultHandler);
	}
	
	/**
	 * Static method to add the newly created RadioButton to the list of buttons in the group.
	 * @param rb The RadioButton to add.
	 */
	static function addButton(rb:RadioButton) {
		if(buttons == null)
		{
			buttons = new Array();
		}
		buttons.push(rb);
	}
	
	/**
	 * Unselects all RadioButtons in the group, except the one passed.
	 * This could use some rethinking or better naming.
	 * @param rb The RadioButton to remain selected.
	 */
	static function clear(rb:RadioButton) {
		for(i in 0...buttons.length) {
			if(buttons[i] != rb)
				buttons[i].selected = false;
		}
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		
		buttonMode = true;
		useHandCursor = true;
		
		addEventListener(MouseEvent.CLICK, onClick, false, 1);
		selected = _selected;
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_back = new Sprite();
		_back.filters = [getShadow(2, true)];
		addChild(_back);
		
		_button = new Sprite();
		_button.filters = [getShadow(1)];
		_button.visible = false;
		addChild(_button);
		
		_label = new Label(this, 0, 0, _labelText);
		draw();
		
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		_back.graphics.clear();
		_back.graphics.beginFill(Style.BACKGROUND);
		_back.graphics.drawCircle(5, 5, 5);
		_back.graphics.endFill();
		
		_button.graphics.clear();
		_button.graphics.beginFill(Style.BUTTON_FACE);
		_button.graphics.drawCircle(5, 5, 3);
		
		_label.x = 12;
		_label.y = (10 - _label.height) / 2;
		_label.text = _labelText;
		_label.draw();
		_width = _label.width + 12;
		_height = 10;
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Internal click handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onClick(event:MouseEvent) {
		selected = true;
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Sets / gets the selected state of this CheckBox.
	 */
	public function setSelected(s:Bool):Bool {
		_selected = s;
		_button.visible = _selected;
		if(_selected)
			RadioButton.clear(this);
		return s;
	}
	public function getSelected():Bool {
		return _selected;
	}

	/**
	 * Sets / gets the label text shown on this CheckBox.
	 */
	public function setLabel(str:String):String {
		_labelText = str;
		invalidate();
		return str;
	}
	public function getLabel():String {
		return _labelText;
	}
	
}
