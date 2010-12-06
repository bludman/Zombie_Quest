package com.zombiequest 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Innocent extends FlxSprite
	{
		[Embed(source = "../../../assets/png/oldinnocent.png")]
		private var ImgInnocent:Class;
		private var speed:Number = 20;
		
		public static const healthRegen:Number = 50;
		
		public function Innocent(x:Number, y:Number, angle:Number):void 
		{
			super(x, y, ImgInnocent);
			this.angle = angle;
			loadGraphic(ImgInnocent, true, true, 24, 24);
			health = 1;
			calcFrame();
		}
		public override function update():void
		{
			velocity.x = speed * Math.cos(MathU.degToRad(angle));
			velocity.y = speed * Math.sin(MathU.degToRad(angle));
			super.update();
		}
	}

	}