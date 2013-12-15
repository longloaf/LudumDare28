package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Finish extends FlxSprite
	{
		[Embed(source = "data/finish.png")]
		private static const Img:Class;
		
		public function Finish() 
		{
			loadGraphic(Img);
			width /= 4;
			centerOffsets();
		}
		
	}

}