package com.zombiequest
{
	public class TextData
	{
		public var x:Number;
		public var y:Number;
		public var width:uint;
		public var height:uint;
		public var angle:Number;
		public var text:String;
		public var fontName:String;
		public var size:uint;
		public var color:uint;
		public var alignment:String;

		public function TextData( X:Number, Y:Number, Width:uint, Height:uint, Angle:Number, Text:String, FontName:String, Size:uint, Color:uint, Alignment:String )
		{
			x = X;
			y = Y;
			width = Width;
			height = Height;
			angle = Angle;
			text = Text;
			fontName = FontName;
			size = Size;
			color = Color;
			alignment = Alignment;
		}
	}
}
