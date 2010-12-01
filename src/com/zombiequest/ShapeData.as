package com.zombiequest
{
	import org.flixel.FlxGroup;

	public class ShapeData
	{
		public var x:Number;
		public var y:Number;
		public var group:FlxGroup;

		public function ShapeData(X:Number, Y:Number, Group:FlxGroup )
		{
			x = X;
			y = Y;
			group = Group;
		}
	}
}
