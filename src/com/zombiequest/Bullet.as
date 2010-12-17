package com.zombiequest 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source="../../../assets/png/bullet_down.png")]
		private static var ImgBullet:Class;
		private var speed:Number = 200;
		public function Bullet(p:FlxPoint, angle:Number)
		{
			super(p.x, p.y);
			loadRotatedGraphic(ImgBullet, 32, -1, false, false);
			this.angle = angle;
		}
		public override function update():void
		{
			velocity.x = speed * Math.cos(MathU.degToRad(angle));
			velocity.y = speed * Math.sin(MathU.degToRad(angle));
			super.update();
		}
		
	}

}