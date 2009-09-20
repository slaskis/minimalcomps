/**
 * CheckBox.as
 * Keith Peters
 * version 0.97
 * 
 * A basic CheckBox component.
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

class CheckBox extends Component {
	
	public var label(getLabel, setLabel) : String;
	public var selected(getSelected, setSelected) : Bool;
	
	var _back:Sprite;
	var _button:Sprite;
	var _label:Label;
	var _labelText:String ;
	var _selected:Bool ;
	
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param label String containing the label for this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?label:String = "", ?defaultHandler:Dynamic = null) {
		_labelText = "";
		_selected = false;
		_labelText = label;
		super(parent, xpos, ypos);
		if(defaultHandler != null)
			addEventListener(MouseEvent.CLICK, defaultHandler);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		buttonMode = true;
		useHandCursor = true;
	}
	
	/**
	 * Creates the children for this component
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
		
		addEventListener(MouseEvent.CLICK, onClick);
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
		_back.graphics.drawRect(0, 0, 10, 10);
		_back.graphics.endFill();
		
		_button.graphics.clear();
		_button.graphics.beginFill(Style.BUTTON_FACE);
		_button.graphics.drawRect(2, 2, 6, 6);
		
		_label.text = _labelText;
		_label.draw();
		_label.x = 12;
		_label.y = (10 - _label.height) / 2;
		_width = _label.width + 12;
		_height = 10;
	}
	
	
	
	
	///////////////////////////////////
	// event handler
	///////////////////////////////////
	
	/**
	 * Internal click handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onClick(event:MouseEvent) {
		_selected = !_selected;
		_button.visible = _selected;
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Sets / gets the label text shown on this CheckBox.
	 */
	public function setLabel(str:String) {
		_labelText = str;
		invalidate();
		return str;
	}
	public function getLabel():String {
		return _labelText;
	}
	
	/**
	 * Sets / gets the selected state of this CheckBox.
	 */
	public function setSelected(s:Bool):Bool {
		_selected = s;
		_button.visible = _selected;
		return s;
	}
	public function getSelected():Bool{
		return _selected;
	}

}
