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
			makeStart(2, 12);
			makeFinish(56, 7);
			for (var i:int = 0; i < tileMap.widthInTiles; ++i) {
				if (tileMap.getTile(i, 13) < G.T_COLLIDE) {
					makeBadBlock(i, 13);
				}
			}
			makeWorm(12, 12);
		}
		
	}

}