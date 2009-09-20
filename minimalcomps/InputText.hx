/**
 * InputText.as
 * Keith Peters
 * version 0.97
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
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

class InputText extends Component {
	
	public var maxChars(getMaxChars, setMaxChars) : Int;
	public var password(getPassword, setPassword) : Bool;
	public var restrict(getRestrict, setRestrict) : String;
	public var text(getText, setText) : String;
	
	var _back:Sprite;
	var _password:Bool;
	var _text:String ;
	var _tf:TextField;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this InputText.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param text The string containing the initial text of this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?text:String = "", ?defaultHandler:Dynamic = null) {
		_password = false;
		_text = "";
		_text = text;
		super(parent, xpos, ypos);
		if(defaultHandler != null)
			addEventListener(Event.CHANGE, defaultHandler);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		setSize(100, 16);
	}
	
	/**
	 * Creates and adds child display objects.
	 */
	override function addChildren() {
		_back = new Sprite();
		_back.filters = [getShadow(2, true)];
		addChild(_back);
		
		_tf = new TextField();
		_tf.embedFonts = true;
		_tf.selectable = true;
		_tf.type = TextFieldType.INPUT;
		_tf.defaultTextFormat = new TextFormat("PFRondaSeven", 8, Style.INPUT_TEXT);
		addChild(_tf);
		_tf.addEventListener(Event.CHANGE, onChange);
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
		
		_tf.displayAsPassword = _password;
		
		_tf.text = _text;
		_tf.width = _width - 4;
		if(_tf.text == "") {
			_tf.text = "X";
			_tf.height = Math.min(_tf.textHeight + 4, _height);
			_tf.text = "";
		} else
			_tf.height = Math.min(_tf.textHeight + 4, _height);
		_tf.x = 2;
		_tf.y = Math.round(_height / 2 - _tf.height / 2);
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Internal change handler.
	 * @param event The Event passed by the system.
	 */
	function onChange(event:Event) {
		_text = _tf.text;
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets the text shown in this InputText.
	 */
	public function setText(t:String):String{
		_text = t;
		invalidate();
		return t;
	}
	public function getText():String{
		return _text;
	}
	
	/**
	 * Gets / sets the list of characters that are allowed in this TextInput.
	 */
	public function setRestrict(str:String):String {
		_tf.restrict = str;
		return str;
	}
	public function getRestrict():String {
		return _tf.restrict;
	}
	
	/**
	 * Gets / sets the maximum number of characters that can be shown in this InputText.
	 */
	public function setMaxChars(max:Int):Int {
		_tf.maxChars = max;
		return max;
	}
	public function getMaxChars():Int {
		return _tf.maxChars;
	}
	
	/**
	 * Gets / sets whether or not this input text will show up as password (asterisks).
	 */
	public function setPassword(b:Bool):Bool {
		_password = b;
		invalidate();
		return b;
	}
	public function getPassword():Bool {
		return _password;
	}
}
