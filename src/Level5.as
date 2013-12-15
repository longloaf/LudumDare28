package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level5 extends Level
	{
		[Embed(source = "data/level5.txt")]
		private static const Map:Class;
		
		override public function getMap():Class 
		{
			return Map;
		}
		
		override public function makeLevel():void 
		{
			
		}
		
	}

}