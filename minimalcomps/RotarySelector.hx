/**
 * RotarySelector.as
 * Keith Peters
 * version 0.97
 * 
 * A rotary selector component for choosing among different values.
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
import flash.events.Event;
import flash.events.MouseEvent;

class RotarySelector extends Component {
	
	public var choice(getChoice, setChoice) : UInt;
	public var labelMode(getLabelMode, setLabelMode) : String;
	public var numChoices(getNumChoices, setNumChoices) : UInt;
	
	public inline static var ALPHABETIC:String = "alphabetic";
	public inline static var NUMERIC:String = "numeric";
	public inline static var NONE:String = "none";
	public inline static var ROMAN:String = "roman";
	
	var _label:Label;
	var _labelText:String ;
	var _knob:Sprite;
	var _numChoices:Int ;
	var _choice:Int ;
	var _labels:Sprite;
	var _labelMode:String ;
	
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param label String containing the label for this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
	 */
	public function new(?parent:DisplayObjectContainer = null, ?xpos:Float = 0, ?ypos:Float =  0, ?label:String = "", ?defaultHandler:Dynamic = null)
	{
		
		_labelText = "";
		_numChoices = 2;
		_choice = 0;
		_labelMode = ALPHABETIC;
		_labelText = label;
		super(parent, xpos, ypos);
		if(defaultHandler != null)
		{
			addEventListener(Event.CHANGE, defaultHandler);
		}
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		setSize(60, 60);
	}
	
	/**
	 * Creates the children for this component
	 */
	override function addChildren() {
		_knob = new Sprite();
		_knob.buttonMode = true;
		_knob.useHandCursor = true;
		addChild(_knob);
		
		_label = new Label();
		_label.autoSize = true;
		addChild(_label);
		
		_labels = new Sprite();
		addChild(_labels);
		
		_knob.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	/**
	 * Decrements the index of the current choice.
	 */
	function decrement() {
		if(_choice > 0)
		{
			_choice--;
			draw();
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
	/**
	 * Increments the index of the current choice.
	 */
	function increment() {
		if(_choice < _numChoices - 1)
		{
			_choice++;
			draw();
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
	/**
	 * Removes old labels.
	 */
	function resetLabels() {
		while(_labels.numChildren > 0)
		{
			_labels.removeChildAt(0);
		}
		_labels.x = _width / 2 - 5;
		_labels.y = _height / 2 - 10;
	}
	
	/**
	 * Draw the knob at the specified radius.
	 * @param radius The radius with which said knob will be drawn.
	 */
	function drawKnob(radius:Float) {
		_knob.graphics.clear();
		_knob.graphics.beginFill(Style.BACKGROUND);
		_knob.graphics.drawCircle(0, 0, radius);
		_knob.graphics.endFill();
		
		_knob.graphics.beginFill(Style.BUTTON_FACE);
		_knob.graphics.drawCircle(0, 0, radius - 2);
		
		_knob.x = _width / 2;
		_knob.y = _height / 2;
	}
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		
		var radius:Int = Math.min(_width, _height) / 2;
		drawKnob(radius);
		resetLabels();
		
		var arc:Float = Math.PI * 1.5 / _numChoices; // the angle between each choice
		var start:Int = - Math.PI / 2 - arc * (_numChoices - 1) / 2; // the starting angle for choice 0
		
		graphics.clear();
		graphics.lineStyle(4, Style.BACKGROUND, .5);
		for(i in 0..._numChoices)
		{
			var angle:Float = start + arc * i;
			var sin:Float = Math.sin(angle);
			var cos:Float = Math.cos(angle);
			
			graphics.moveTo(_knob.x, _knob.y);
			graphics.lineTo(_knob.x + cos * (radius + 2), _knob.y + sin * (radius + 2));
			
			var lab:Label = new Label(_labels, cos * (radius + 10), sin * (radius + 10));
			lab.mouseEnabled = true;
			lab.buttonMode = true;
			lab.useHandCursor = true;
			lab.addEventListener(MouseEvent.CLICK, onLabelClick);
			if(_labelMode == ALPHABETIC)
			{
				lab.text = String.fromCharCode(65 + i);
			}
			else if(_labelMode == NUMERIC)
			{
				lab.text = (i + 1).toString();
			}
			else if(_labelMode == ROMAN)
			{
				var chars:Array<Dynamic> = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];
				lab.text = chars[i];
			}
			if(i != _choice)
			{
				lab.alpha = 0.5;
			}
		}
		
		angle = start + arc * _choice;
		graphics.lineStyle(4, Style.LABEL_TEXT);
		graphics.moveTo(_knob.x, _knob.y);
		graphics.lineTo(_knob.x + Math.cos(angle) * (radius + 2), _knob.y + Math.sin(angle) * (radius + 2));
		
		
		_label.text = _labelText;
		_label.draw();
		_label.x = _width / 2 - _label.width / 2;
		_label.y = _height + 2;
	}
	
	
	
	///////////////////////////////////
	// event handler
	///////////////////////////////////
	
	/**
	 * Internal click handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onClick(event:MouseEvent) {
		if(mouseX < _width / 2)
		{
			decrement();
		}
		else 
		{
			increment();
		}
	}
	
	function onLabelClick(event:Event) {
		var lab:Label = cast( event.target, Label);
		choice = _labels.getChildIndex(lab);
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets the number of available choices (maximum of 10).
	 */
	public function setNumChoices(value:UInt):UInt {
		_numChoices = Math.min(value, 10);
		draw();
		return value;
	}
	public function getNumChoices():UInt {
		return _numChoices;
	}
	
	/**
	 * Gets / sets the current choice, keeping it in range of 0 to numChoices - 1.
	 */
	public function setChoice(value:UInt):UInt {
		_choice = Math.max(0, Math.min(_numChoices - 1, value));
		draw();
		dispatchEvent(new Event(Event.CHANGE));
		return value;
	}
	public function getChoice():UInt {
		return _choice;
	}
	
	/**
	 * Specifies what will be used as labels for each choice. Valid values are "alphabetic", "numeric", and "none".
	 */
	public function setLabelMode(value:String):String {
		_labelMode = value;
		draw();
		return value;
	}
	public function getLabelMode():String {
		return _labelMode;
	}
}
