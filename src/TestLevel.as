package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class TestLevel extends Level
	{
		[Embed(source = "data/map1.txt", mimeType = "application/octet-stream")]
		private static const Map:Class;
		
		override public function getMap():Class 
		{
			return Map;
		}
		
		override public function makeLevel():void 
		{
			makePlatform(39, 8, 3, 8, 2);
			makeSwitchAndDoor(44, 7, true, 49, 2);
			makeSwitchAndDoor(46, 7, false, 49, 10);
			makeBadBlock(55, 8, 9, 1);
			makeBadBlock(51, 10, 3, 2);
			makeBadBlock(64, 14, 5);
			makeStart(3, 13);
			makeFinish(15, 13);
		}
		
	}

}