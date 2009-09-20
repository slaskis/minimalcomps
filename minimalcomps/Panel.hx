/**
 * Panel.as
 * Keith Peters
 * version 0.97
 * 
 * A rectangular panel. Can be used as a container for other components.
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
import flash.display.Shape;
import flash.display.Sprite;

class Panel extends Component {
	
	public var color(getColor, setColor) : Int;
	public var shadow(getShadowBool, setShadowBool) : Bool;
	
	var _mask:Sprite;
	var _background:Shape;
	var _color:Int;
	var _shadow:Bool;
	
	/**
	 * Container for content added to this panel. This is masked, so best to add children to content, rather than directly to the panel.
	 */
	public var content:Sprite;
	
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this Panel.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0) {
		_color = -1;
		_shadow = true;
		super(parent, xpos, ypos);
	}
	
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		setSize(100, 100);
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_background = new Shape();
		addChild(_background);
		
		_mask = new Sprite();
		_mask.mouseEnabled = false;
		addChild(_mask);
		
		content = new Sprite();
		addChild(content);
		content.mask = _mask;
		
		filters = [getShadow(2, true)];
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		_background.graphics.clear();
		if(_color == -1)
		{
			_background.graphics.beginFill(Style.PANEL);
		}
		else
		{
			_background.graphics.beginFill(_color);
		}
		_background.graphics.drawRect(0, 0, _width, _height);
		_background.graphics.endFill();
		
		_mask.graphics.clear();
		_mask.graphics.beginFill(0xff0000);
		_mask.graphics.drawRect(0, 0, _width, _height);
		_mask.graphics.endFill();
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets whether or not this Panel will have an inner shadow.
	 */
	public function setShadowBool(b:Bool):Bool {
		_shadow = b;
		if(_shadow) 
			filters = [getShadow(2, true)];
		else
			filters = [];
		return b;
	}
	public function getShadowBool():Bool {
		return _shadow;
	}
	
	/**
	 * Gets / sets the backgrond color of this panel.
	 */
	public function setColor(c:Int):Int {
		_color = c;
		invalidate();
		return c;
	}
	public function getColor():Int {
		return _color;
	}
}
