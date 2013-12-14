package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Player extends FlxSprite
	{
		
		public function Player() 
		{
			makeGraphic(32, 64, 0xFF009000);
			
			acceleration.y = 100;
			
			x = (FlxG.width - width) / 2;
			y = 0;
		}
		
		override public function update():void 
		{
		}
		
	}

}