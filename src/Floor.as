package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Floor extends FlxSprite
	{
		
		public function Floor() 
		{
			makeGraphic(700, 20, 0xFF505050);
			moves = false;
			immovable = true;
			
			x = (FlxG.width - width) / 2;
			y = 400;
		}
		
	}

}