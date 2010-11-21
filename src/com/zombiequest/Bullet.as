package com.zombiequest 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source="../../../assets/png/bullet.png")]
		private var ImgBullet:Class;
		private var speed:Number = 100;
		public function Bullet(p:FlxPoint, angle:Number)
		{
			super(p.x, p.y, ImgBullet);
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