package com.zombiequest
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	public class SpriteEntity extends Entity
	{
		public var anim:Spritemap = null;
		public var sprite:Image = null;
		private var _text:TextAdvanced = null;

		public function set text( newText:TextAdvanced):void
		{
			graphic = sprite = _text = newText;
		}

		public function get text():TextAdvanced
		{
			return _text;
		}

		public function SpriteEntity( X:Number, Y:Number )
		{
			x = X;
			y = Y;
		}

		public function loadImage( imageClass:Class, Width:uint, Height:uint, animates:Boolean = true ):void
		{
			if ( animates )
			{
				sprite = anim = new Spritemap( imageClass, Width, Height);
			}
			else
			{
				sprite = new Image( imageClass );
			}
			graphic = sprite;
		}
	}
}
