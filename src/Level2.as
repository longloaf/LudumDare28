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
			makeStart(2, 15);
			makeFinish(56, 15);
			makeBadBlock(12, 16, 2);
			makePlatform(22, 8, 3, 7, 2);
			makeSwitchAndDoor(2, 7, false, 29, 10);
			makeSceleton(25, 15, false);
			makeSceleton(55, 15, false);
			makeSceleton(55, 15, true);
		}
		
	}

}