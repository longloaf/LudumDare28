package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Start extends FlxSprite
	{
		[Embed(source = "data/start.png")]
		private static const Img:Class;
		
		public function Start() 
		{
			loadGraphic(Img);
		}
		
	}

}