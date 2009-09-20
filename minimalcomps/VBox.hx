/**
 * VBox.as
 * Keith Peters
 * version 0.97
 * 
 * A layout container for vertically aligning other components.
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

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

class VBox extends Component {
	
	public var spacing(getSpacing, setSpacing) : Float;
	var _spacing:Float;
	
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 */
	public function new(?parent:DisplayObjectContainer = null, ?xpos:Float = 0, ?ypos:Float =  0) {		
		_spacing = 5;
		super(parent, xpos, ypos);
	}
	
	/**
	 * Override of addChild to force layout;
	 */
	public override function addChild(child:Dynamic) {
		super.addChild(child);
		child.addEventListener(Event.RESIZE, onResize);
		invalidate();
		return child;
	}
	
	/**
	 * Internal handler for resize event of any attached component. Will redo the layout based on new size.
	 */
	function onResize(event:Event) {
		invalidate();
	}
	
	/**
	 * Draws the visual ui of the component, in this case, laying out the sub components.
	 */
	public override function draw() : Void {
		var ypos = 0.;
		for(i in 0...numChildren) {
			var child:DisplayObject = getChildAt(i);
			child.y = ypos;
			ypos += child.height;
			ypos += _spacing;
		}
	}
	
	/**
	 * Gets / sets the spacing between each sub component.
	 */
	public function setSpacing(s:Float):Float {
		_spacing = s;
		invalidate();
		return s;
	}
	public function getSpacing():Float {
		return _spacing;
	}
}
