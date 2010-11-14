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
		private var speed:Number = 25;
		public function Bullet(X:Number, Y:Number, angle:Number) 
		{
			super(x, y, ImgBullet);
			this.angle = angle;
		}
		public override function update():void
		{
			this.x += speed * Math.cos(Main.degToRad(angle));
			this.y += speed * Math.sin(Main.degToRad(angle));
			super.update();
		}
		
	}

}