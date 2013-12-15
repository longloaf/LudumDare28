package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Platform extends FlxSprite
	{
		[Embed(source = "data/platform.png")]
		private static const Img:Class;
		
		public function Platform() 
		{
			loadGraphic(Img);
			immovable = true;
			allowCollisions = UP;
		}
		
	}

}