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
			
		}
		
	}

}