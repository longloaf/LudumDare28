package 
{
	import org.flixel.FlxGame;
	
	[SWF(width = "800", height = "450", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")]
	
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Main extends FlxGame
	{
		
		public function Main():void 
		{
			//super(800, 450, PlayState, 1, G.FPS, G.FPS, true);
			super(800, 450, Level, 1, G.FPS, G.FPS, true);
			forceDebugger = true;
		}
		
	}
	
}