/**
 * Window.as
 * Keith Peters
 * version 0.97
 * 
 * A draggable window. Can be used as a container for other components.
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

class Window extends Component {
	
	public var color(getColor, setColor) : Int;
	public var content(getContent, null) : DisplayObjectContainer;
	public var draggable(getDraggable, setDraggable) : Bool;
	public var hasMinimizeButton(getHasMinimizeButton, setHasMinimizeButton) : Bool;
	public var minimized(getMinimized, setMinimized) : Bool;
	public var shadow(default, setShadow) : Bool;
	public var title(getTitle, setTitle) : String;
	override public var height(getHeight, setHeight) : Float;
	
	var _title:String;
	var _titleBar:Panel;
	var _titleLabel:Label;
	var _panel:Panel;
	var _color:Int ;
	var _shadow:Bool ;
	var _draggable:Bool ;
	var _minimizeButton:Sprite;
	var _hasMinimizeButton:Bool ;
	var _minimized:Bool ;
	
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this Panel.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param title The string to display in the title bar.
	 */
	public function new(?parent:Dynamic=null, ?xpos:Int=0, ?ypos:Int=0, ?title:String="Window") {
		_color = -1;
		_shadow = true;
		_draggable = true;
		_hasMinimizeButton = false;
		_minimized = false;
		_title = title;
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
		_titleBar = new Panel(this);
		_titleBar.buttonMode = true;
		_titleBar.useHandCursor = true;
		_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_titleBar.height = 20;
		_titleLabel = new Label(_titleBar.content, 5, 1, _title);
		
		_panel = new Panel(this, 0, 20);
		_panel.visible = !_minimized;
		
		_minimizeButton = new Sprite();
		_minimizeButton.graphics.beginFill(0, 0);
		_minimizeButton.graphics.drawRect(-10, -10, 20, 20);
		_minimizeButton.graphics.endFill();
		_minimizeButton.graphics.beginFill(0, .35);
		_minimizeButton.graphics.moveTo(-5, -3);
		_minimizeButton.graphics.lineTo(5, -3);
		_minimizeButton.graphics.lineTo(0, 4);
		_minimizeButton.graphics.lineTo(-5, -3);
		_minimizeButton.graphics.endFill();
		_minimizeButton.x = 10;
		_minimizeButton.y = 10;
		_minimizeButton.useHandCursor = true;
		_minimizeButton.buttonMode = true;
		_minimizeButton.addEventListener(MouseEvent.CLICK, onMinimize);
		
		filters = [getShadow(4, false)];
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		_titleBar.color = _color;
		_panel.color = _color;
		_titleBar.width = width;
		_titleLabel.x = _hasMinimizeButton ? 20 : 5;
		_panel.setSize(_width, _height - 20);
	}


	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Internal mouseDown handler. Starts a drag.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseDown(event:MouseEvent) {
		this.startDrag();
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		parent.addChild(this._comp);
	}
	
	/**
	 * Internal mouseUp handler. Stops the drag.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseUp(event:MouseEvent) {
		this.stopDrag();
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	function onMinimize(event:MouseEvent) {
		minimized = !minimized;
	}
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets whether or not this Window will have a drop shadow.
	 */
	function setShadow(b:Bool):Bool {
		this.shadow = b;
		if( b )
			filters = [getShadow(4, false)];
		else
			filters = [];
		return b;
	}
	
	/**
	 * Gets / sets the background color of this panel.
	 */
	function setColor(c:Int):Int {
		_color = c;
		invalidate();
		return c;
	}
	function getColor():Int {
		return _color;
	}
	
	/**
	 * Gets / sets the title shown in the title bar.
	 */
	function setTitle(t:String):String {
		_title = t;
		_titleLabel.text = _title;
		return t;
	}
	function getTitle():String {
		return _title;
	}
	
	/**
	 * Container for content added to this panel. This is just a reference to the content of the internal Panel, which is masked, so best to add children to content, rather than directly to the window.
	 */
	function getContent():DisplayObjectContainer {
		return _panel.content;
	}
	
	/**
	 * Sets / gets whether or not the window will be draggable by the title bar.
	 */
	function setDraggable(b:Bool):Bool {
		_draggable = b;
		_titleBar.buttonMode = _draggable;
		_titleBar.useHandCursor = _draggable;
		if(_draggable)
			_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		else
			_titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		return b;
	}
	function getDraggable():Bool {
		return _draggable;
	}
	
	/**
	 * Gets / sets whether or not the window will show a minimize button that will toggle the window open and closed. A closed window will only show the title bar.
	 */
	function setHasMinimizeButton(b:Bool):Bool {
		_hasMinimizeButton = b;
		if(_hasMinimizeButton)
			addChild(_minimizeButton);
		else if(_comp.contains(_minimizeButton))
			removeChild(_minimizeButton);
		invalidate();
		return b;
	}
	function getHasMinimizeButton():Bool {
		return _hasMinimizeButton;
	}
	
	/**
	 * Gets / sets whether the window is closed. A closed window will only show its title bar.
	 */
	function setMinimized(value:Bool):Bool {
		_minimized = value;
		_panel.visible = !_minimized;
		if(_minimized)
			_minimizeButton.rotation = -90;
		else
			_minimizeButton.rotation = 0;
		dispatchEvent(new Event(Event.RESIZE));
		return value;
	}
	function getMinimized():Bool {
		return _minimized;
	}
	
	/**
	 * Gets the height of the component. A minimized window's height will only be that of its title bar.
	 */
	override function getHeight():Float {
		if(_panel.visible)
			return _comp.height;
		else
			return 20;
	}
}
