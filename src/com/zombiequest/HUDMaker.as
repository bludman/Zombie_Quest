package com.zombiequest
{
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	public class HUDMaker
	{
		private var HEALTHBARSIZE:Number = 200;
		
		private var healthBar:FlxSprite;
		private var inside:FlxSprite;
		private var frame:FlxSprite;
		
		private var bigBrain:FlxSprite;
		private var bigBrainCount:FlxText;
		
		private var smallBrain:FlxSprite;
		private var smallBrainCount:FlxText;
		
		private var clockText:FlxText;
		private var clockImg:FlxSprite;
		
		private var score:FlxText;
		
		private var statusText:FlxText;
		private var statusBox:FlxSprite;
		private var timer:FlxText;
		private var timerOffset:Number = 25;
		
		private var waveMessage:FlxText;
		private var waveSubMessage:FlxText;
		private var endOfWave:FlxGroup;
		private var waveMsgTimer:Number = 5;
		
		[Embed(source="../../../assets/png/Brain40x27.png")]
		private static var BigBrain:Class;
		
		[Embed(source="../../../assets/png/Clock27x27_2.png")]
		private static var ClockImg:Class;
		
		public function HUDMaker()
		{
			frame = new FlxSprite(4,4);
			frame.createGraphic(HEALTHBARSIZE+2,12); //White frame for the health bar
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			StartLevelState.overGroup.add(frame);
			 
			inside = new FlxSprite(5,5);
			inside.createGraphic(HEALTHBARSIZE,10,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			StartLevelState.overGroup.add(inside);
			 
			healthBar = new FlxSprite(5,5);
			healthBar.createGraphic(1,10,0xff669933); //The red bar itself
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			healthBar.origin.x = healthBar.origin.y = 0; //Zero out the origin
			healthBar.scale.x = HEALTHBARSIZE; //Fill up the health bar all the way
			StartLevelState.overGroup.add(healthBar);
			
			clockImg = new FlxSprite(240, -1);
			clockImg.loadGraphic(ClockImg, false, false, 27, 27);
			clockImg.scrollFactor.x = clockImg.scrollFactor.y = 0;
			clockImg.origin.x = clockImg.origin.y = 0;
			StartLevelState.overGroup.add(clockImg);
			
			clockText = new FlxText(277, 2, 100);
			clockText.color = 0x00ffffff;
			clockText.scrollFactor.x = clockText.scrollFactor.y = 0;
			clockText.size = 14;
			StartLevelState.overGroup.add(clockText);
			
			bigBrain = new FlxSprite(370, -1);
			bigBrain.loadGraphic(BigBrain, false, false, 40, 27);
			bigBrain.scrollFactor.x = bigBrain.scrollFactor.y = 0;
			bigBrain.origin.x = bigBrain.origin.y = 0;
			StartLevelState.overGroup.add(bigBrain);
			
			bigBrainCount = new FlxText(415, 2, 100);
			bigBrainCount.scrollFactor.x = bigBrainCount.scrollFactor.y = 0;
			bigBrainCount.size = 14;
			StartLevelState.overGroup.add(bigBrainCount);
			
			score = new FlxText(500, 2, 140)
			score.color = 0x00ffffff;
			score.scrollFactor.x = score.scrollFactor.y = 0;
			score.size = 14;
			StartLevelState.overGroup.add(score);
			
			statusBox = new FlxSprite(0, 460);
			statusBox.scrollFactor.x = statusBox.scrollFactor.y = 0;
			StartLevelState.overGroup.add(statusBox);
			statusText = new FlxText(0, 460, 320);
			statusText.color = 0xff000000;
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			statusBox.createGraphic(statusText.width+timerOffset, statusText.height, 0x00ffffff);
			StartLevelState.overGroup.add(statusText);
			timer = new FlxText(325, 460, 20);
			timer.color = 0xff000000;
			timer.scrollFactor.x = timer.scrollFactor.y = 0;
			StartLevelState.overGroup.add(timer);
			
			/**
			 * Wave Status
			 */
			endOfWave = new FlxGroup;
			waveMessage = new FlxText(200,40,400,'Wave Ended');
			waveMessage.scrollFactor.x = waveMessage.scrollFactor.y = 0;
			waveMessage.size = 36;
			waveSubMessage = new FlxText(200,80,450,'Prepare for the next one...');
			waveSubMessage.scrollFactor.x = waveSubMessage.scrollFactor.y = 0;
			waveSubMessage.size = 24;
			endOfWave.add(waveMessage);
			endOfWave.add(waveSubMessage);
			StartLevelState.overGroup.add(endOfWave);
			endOfWave.visible = false;
		}
		
		public function setHealth(amount:Number):void
		{
			
			healthBar.scale.x = amount/(Player.maxHealth/HEALTHBARSIZE);
		}
		
		public function flicker():void
		{
			//healthBar.flicker(.5);
		}
		
		public function update():void
		{
			//Just updating the brain counter for now
			bigBrainCount.text = "x " + (StartLevelState.playerBrainCount + StartLevelState.minionBrainCount);
			clockText.text = StartLevelState.generateClock();
			score.text = "Score: " + StartLevelState.calculateScore();
			if(waveMsgTimer <= 0)
			{
				endOfWave.visible=false;
				StartLevelState.enemyFactory.startWave();
				waveMsgTimer = 5;
			}				
			else if(endOfWave.visible == true)
			{
				waveMsgTimer -= FlxG.elapsed;
			}				
		}
		
		public function showMsg():void
		{
			endOfWave.visible = true;
		}
	}
}