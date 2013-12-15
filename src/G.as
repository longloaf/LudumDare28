package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class G 
	{
		
		public static const FPS:int = 30;
		
		public static const NIL_FUNC:Function = function():void { }
		
		public static const TILE_SIZE:int = 32;
		
		public static const LEVELS:Vector.<Class> = 
		Vector.<Class>([TestLevel, Level1, Level2, Level3, Level4, Level5]);
		
		public static var currentLevel:int = 0;
		
		public static function startGame():void
		{
			currentLevel = 0;
			FlxG.switchState(new LEVELS[currentLevel]);
		}
		
		public static function nextLevel():void
		{
			++currentLevel;
			var c:Class;
			if (currentLevel < LEVELS.length) {
				c = LEVELS[currentLevel];
			} else {
				c = WinState;
			}
			FlxG.switchState(new c);
		}
		
	}

}