package com.zombiequest
{
	import org.flixel.FlxGroup;

	public class BoxData extends ShapeData
	{
		public var angle:Number;
		public var width:uint;
		public var height:uint;

		public function BoxData( X:Number, Y:Number, Angle:Number, Width:uint, Height:uint, Group:FlxGroup ) 
		{
			super(X, Y, Group);
			angle = Angle;
			width = Width;
			height = Height;
		}
	}
}
