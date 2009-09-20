/**
 * PushButton.as
 * Keith Peters
 * version 0.97
 * 
 * A basic button component with a label.
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

class PushButton extends Component {
	
	public var label(getLabel, setLabel) : String;
	public var selected(getSelected, setSelected) : Bool;
	public var toggle(getToggle, setToggle) : Bool;
	var _back:Sprite;
	var _face:Sprite;
	var _label:Label;
	var _labelText:String ;
	var _over:Bool ;
	var _down:Bool ;
	var _selected:Bool ;
	var _toggle:Bool ;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param label The string to use for the initial label of this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?label:String = "", ?defaultHandler:Dynamic = null){			
		_labelText = "";
		_over = false;
		_down = false;
		_selected = false;
		_toggle = false;
		super(parent, xpos, ypos);
		if(defaultHandler != null)
			addEventListener(MouseEvent.CLICK, defaultHandler);
		this.label = label;
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		buttonMode = true;
		useHandCursor = true;
		setSize(100, 20);
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_back = new Sprite();
		_back.filters = [getShadow(2, true)];
		_back.mouseEnabled = false;
		addChild(_back);
		
		_face = new Sprite();
		_face.mouseEnabled = false;
		_face.filters = [getShadow(1)];
		_face.x = 1;
		_face.y = 1;
		addChild(_face);
		
		_label = new Label();
		addChild(_label);
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
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
		_back.graphics.drawRect(0, 0, _width, _height);
		_back.graphics.endFill();
		
		_face.graphics.clear();
		_face.graphics.beginFill(Style.BUTTON_FACE);
		_face.graphics.drawRect(0, 0, _width - 2, _height - 2);
		_face.graphics.endFill();
		
		_label.autoSize = true;
		_label.text = _labelText;
		if(_label.width > _width - 4) {
			_label.autoSize = false;
			_label.width = _width - 4;
		} else
			_label.autoSize = true;
		_label.draw();
		_label.move(_width / 2 - _label.width / 2, _height / 2 - _label.height / 2);
		
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Internal mouseOver handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseOver(event:MouseEvent) {
		_over = true;
		addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
	}
	
	/**
	 * Internal mouseOut handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseOut(event:MouseEvent) {
		_over = false;
		if(!_down)
			_face.filters = [getShadow(1)];
	}
	
	/**
	 * Internal mouseOut handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseDown(event:MouseEvent) {
		_down = true;
		_face.filters = [getShadow(1, true)];
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	/**
	 * Internal mouseUp handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseUp(event:MouseEvent) {
		if(_toggle  && _over)
			_selected = !_selected;
		_down = _selected;
		_face.filters = [getShadow(1, _selected)];
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Sets / gets the label text shown on this Pushbutton.
	 */
	public function setLabel(str:String):String {
		_labelText = str;
		draw();
		return str;
	}
	public function getLabel():String {
		return _labelText;
	}
	
	public function setSelected(value:Bool):Bool {
		if(!_toggle)
			value = false;
		
		_selected = value;
		_down = _selected;
		_face.filters = [getShadow(1, _selected)];
		return value;
	}
	public function getSelected():Bool {
		return _selected;
	}
	
	public function setToggle(value:Bool):Bool {
		_toggle = value;
		return value;
	}
	public function getToggle():Bool {
		return _toggle;
	}
	
	
}
