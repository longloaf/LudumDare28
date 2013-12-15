package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level extends FlxState
	{
		[Embed(source = "data/map1.txt", mimeType = "application/octet-stream")]
		private static const Map:Class;
		
		[Embed(source = "data/tiles_32x32_20.png")]
		private static const Tiles:Class;
		
		private var tileMap:FlxTilemap;
		private var platformGroup:FlxGroup;
		private var player:Player;
		
		override public function create():void 
		{
			tileMap = new FlxTilemap();
			tileMap.loadMap(new Map, Tiles, 32, 32, FlxTilemap.OFF, 0, 0, 10);
			tileMap.reset(0, 0);
			
			platformGroup = new FlxGroup();
			
			player = new Player();
			player.reset(100, 100);
			
			FlxG.camera.follow(player);
			tileMap.follow();
			
			add(tileMap);
			add(platformGroup);
			add(player);
			
			platform(39, 7, 3, 8, 2);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(player, tileMap);
			FlxG.collide(player, platformGroup);
			
			if (FlxG.keys.justPressed("ENTER")) FlxG.resetState();
		}
		
		public function platform(tx:int, ty:int, width:int = 1, height:int = 1, step:int = 1):void
		{
			if ((width < 1) || (height < 1) || (step < 1)) throw new Error();
			for (var x:int = 0; x < width; ++x) {
				for (var y:int = 0; y < height; y += step) {
					var p:Platform = new Platform();
					p.reset(tileMap.x + (tx + x) * G.TILE_SIZE, tileMap.y + (ty + y) * G.TILE_SIZE);
					platformGroup.add(p);
				}
			}
		}
		
	}

}