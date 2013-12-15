package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level1 extends Level
	{
		[Embed(source = "data/level1.txt", mimeType = "application/octet-stream")]
		private static const Map:Class;
		
		override public function getMap():Class 
		{
			return Map;
		}
		
		override public function makeLevel():void 
		{
			makeStart(2, 15);
			makeFinish(26, 15);
		}
		
	}

}