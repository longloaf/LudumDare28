package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Door extends FlxSprite
	{
		[Embed(source = "data/door.png")]
		private static const Img:Class;
		
		public function Door() 
		{
			loadGraphic(Img);
			width = 24;
			centerOffsets();
			immovable = true;
		}
		
	}

}