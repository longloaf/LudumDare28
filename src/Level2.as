package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level2 extends Level
	{
		[Embed(source = "data/level2.txt", mimeType = "application/octet-stream")]
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