package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level4 extends Level
	{
		[Embed(source = "data/level4.txt", mimeType = "application/octet-stream")]
		private static const Map:Class;
		
		override public function getMap():Class 
		{
			return Map;
		}
		
		override public function makeLevel():void 
		{
			makeStart(2, 12);
			makeFinish(26, 12);
			makeBoss(22, 12);
		}
		
	}

}