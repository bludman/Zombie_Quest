package com.zombiequest
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	// This is a variation on flashpunk's Text class, allowing multiline and alignment.
	public class TextAdvanced extends Image
	{
		// To use "default" the TTF needs to be included in the com directory. See bottom of file.
		public function TextAdvanced(text:String, fontName:String = "default", sz:uint = 16, align:String = "left", x:Number = 0, y:Number = 0, width:uint = 0, height:uint = 0 )
		{
			_font = fontName;
			_field.embedFonts = true;
			_field.defaultTextFormat = _form = new TextFormat(fontName, sz, 0xFFFFFF);
			_field.text = _text = text;
			_form.align = align;
			if (!width)
				width = _field.textWidth + 4;
			else
				_width = width;
			if (!height)
				height = _field.textHeight + 4;
			else
				_field.height = _height = height;
			if ( width < _field.textWidth )
			{
				_field.width = width;
				_field.multiline = true;
				_field.wordWrap = true;
			}
			_source = new BitmapData(width, height, true, 0);
			super(_source);
			updateBuffer();
			this.x = x;
			this.y = y;
		}

		// Updates the drawing buffer.
		override public function updateBuffer(clearBefore:Boolean = false):void 
		{
			_field.setTextFormat(_form);
			_source.fillRect(_sourceRect, 0);
			_source.draw(_field);
			super.updateBuffer(clearBefore);
		}

		//Centers the Text's originX/Y to its center.
		override public function centerOrigin():void
		{
			originX = _width / 2;
			originY = _height / 2;
		}

		//Text string.
		public function get text():String { return _text; }
		public function set text(value:String):void
		{
			if (_text == value) return;
			_field.text = _text = value;
			updateBuffer();
		}

		//Font family.
		public function get font():String { return _font; }
		public function set font(value:String):void
		{
			if (_font == value) return;
			_form.font = _font = value;
			updateBuffer();
		}

		//Font size.
		public function get size():uint { return _size; }
		public function set size(value:uint):void
		{
			if (_size == value) return;
			_form.size = _size = value;
			updateBuffer();
		}

		//Width of the text image.
		override public function get width():uint { return _width; }
		//Height of the text image.
		override public function get height():uint { return _height; }
		// Text information.

		protected var _field:TextField = new TextField;
		protected var _width:uint;
		protected var _height:uint;
		protected var _form:TextFormat;
		protected var _text:String;
		protected var _font:String;
		protected var _size:uint;

		// Default font family.
// UNCOMMENT one of these and include the default font in your directory if you need access to this.
		// Use this option when compiling with Flex SDK 4
		// [Embed(source = '04B_03__.TTF', embedAsCFF="false", fontFamily = 'default')]
		// Use this option when compiling with Flex SDK <4
		//[Embed(source='04B_03__.TTF', fontFamily = 'default')]
		//protected static var _FONT_DEFAULT:Class;
	}
}
