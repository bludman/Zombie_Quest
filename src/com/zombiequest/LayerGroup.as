package com.zombiequest
{
	public class LayerGroup
	{
		public var sprites:Vector.<SpriteEntity> = new Vector.<SpriteEntity>;
		public var scrollX:Number;
		public var scrollY:Number;
		public function LayerGroup( scrollx:Number = 1, scrolly:Number = 1 )
		{
			scrollX = scrollx;
			scrollY = scrolly;
		}
		public function AddSprite( sprite:SpriteEntity, shareScroll:Boolean = true ):void
		{
			sprites.push(sprite);
			if ( shareScroll && sprite.sprite)
			{
				sprite.sprite.scrollX = scrollX;
				sprite.sprite.scrollY = scrollY;
			}
		}
	}
}
