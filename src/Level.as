package  
{
	import org.flixel.FlxG;
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
		private var player:Player;
		
		override public function create():void 
		{
			tileMap = new FlxTilemap();
			tileMap.loadMap(new Map, Tiles, 32, 32, FlxTilemap.OFF, 0, 0, 10);
			tileMap.reset(0, FlxG.height - tileMap.height);
			
			player = new Player();
			player.reset(100, 100);
			
			FlxG.camera.follow(player);
			tileMap.follow();
			
			add(tileMap);
			add(player);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(player, tileMap);
			
			if (FlxG.keys.justPressed("ENTER")) FlxG.resetState();
		}
		
	}

}