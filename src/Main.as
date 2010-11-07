package 
{
	import com.zombiequest.*;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Main extends FlxGame 
	{
		[SWF(width="640", height="480", backgroundColor="#D3D3D3")]
		[Frame(factoryClass="Preloader")]
		public function Main():void 
		{
			super(320, 240, MenuState, 2);
		}
	}
	
}