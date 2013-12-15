package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level3 extends Level
	{
		[Embed(source = "data/level3.txt", mimeType = "application/octet-stream")]
		private static const Map:Class;
		
		override public function getMap():Class 
		{
			return Map;
		}
		
		override public function makeLevel():void 
		{
			makeStart(2, 7);
			makeFinish(26, 15);
			makeSwitchAndDoor(14, 15, true, 5, 10);
			makeSwitchAndDoor(14, 15, true, 24, 10);
			makeSceleton(2, 15, true);
			makeSceleton(26, 15, true);
		}
		
	}

}