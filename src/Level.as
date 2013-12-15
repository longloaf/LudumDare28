package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
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
		private var start:Start;
		private var finish:Finish;
		private var badBlockGroup:FlxGroup;
		private var platformGroup:FlxGroup;
		private var doorGroup:FlxGroup;
		private var player:Player;
		private var switchGroup:FlxGroup;
		
		override public function create():void 
		{
			tileMap = new FlxTilemap();
			tileMap.loadMap(new Map, Tiles, 32, 32, FlxTilemap.OFF, 0, 0, 10);
			tileMap.reset(0, 0);
			
			start = new Start();
			finish = new Finish();
			
			badBlockGroup = new FlxGroup();
			platformGroup = new FlxGroup();
			doorGroup = new FlxGroup();
			
			player = new Player();
			player.reset(100, 100);
			//player.reset(38 * G.TILE_SIZE, 0);
			
			switchGroup = new FlxGroup();
			
			FlxG.camera.follow(player);
			tileMap.follow();
			
			add(tileMap);
			add(start);
			add(finish);
			add(badBlockGroup);
			add(platformGroup);
			add(doorGroup);
			add(player);
			add(switchGroup);
			add(player.foot);
			
			makePlatform(39, 8, 3, 8, 2);
			makeSwitchAndDoor(44, 7, true, 49, 2);
			makeSwitchAndDoor(46, 7, false, 49, 10);
			makeBadBlock(55, 8, 9, 1);
			makeBadBlock(51, 10, 3, 2);
			makeBadBlock(64, 14, 5);
			makeStart(3, 13);
			makeFinish(15, 13);
		}
		
		public function getMap():Class
		{
			return null;
		}
		
		public function makeLevel():void
		{
			
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(player, tileMap);
			FlxG.collide(player, badBlockGroup);
			FlxG.collide(player, platformGroup);
			FlxG.collide(player, doorGroup);
			
			player.playerPostUpdate();
			FlxG.overlap(player.foot, badBlockGroup, ovFootBadBlock);
			
			FlxG.overlap(player, switchGroup, ovPlayerSwitch);
			
			if (FlxG.keys.justPressed("ENTER")) FlxG.resetState();
		}
		
		public function makePlatform(tx:int, ty:int, width:int = 1, height:int = 1, step:int = 1):void
		{
			if ((width < 1) || (height < 1) || (step < 1)) throw new Error();
			for (var x:int = 0; x < width; ++x) {
				for (var y:int = 0; y < height; y += step) {
					var p:Platform = new Platform();
					//p.reset(tileMap.x + (tx + x) * G.TILE_SIZE, tileMap.y + (ty + y) * G.TILE_SIZE);
					moveSprite(p, tx + x, ty + y);
					platformGroup.add(p);
				}
			}
		}
		
		public function makeSwitchAndDoor(sx:int, sy:int, left:Boolean, dx:int, dy:int):void
		{
			var d:Door = new Door();
			moveSprite(d, dx, dy);
			d.x += (G.TILE_SIZE - d.width) / 2;
			doorGroup.add(d);
			var s:Switch = new Switch(d, left);
			//moveSprite(s, sx, sy);
			//s.x += (2 * G.TILE_SIZE - s.width) / 2;
			//s.y -= s.height - G.TILE_SIZE;
			moveSprite2(s, sx, sy);
			switchGroup.add(s);
		}
		
		public function makeBadBlock(tx:int, ty:int, width:int = 1, height:int = 1):void
		{
			if ((width < 1) || (height < 1)) throw new Error();
			for (var x:int = 0; x < width; ++x) {
				for (var y:int = 0; y < height; ++y) {
					var b:BadBlock = new BadBlock();
					moveSprite(b, tx + x, ty + y);
					badBlockGroup.add(b);
				}
			}
		}
		
		public function makeStart(tx:int, ty:int):void
		{
			moveSprite2(start, tx, ty);
		}
		
		public function makeFinish(tx:int, ty:int):void
		{
			moveSprite2(finish, tx, ty);
		}
		
		private function moveSprite(s:FlxSprite, tx:int, ty:int):void
		{
			s.reset(tileMap.x + tx * G.TILE_SIZE, tileMap.y + ty * G.TILE_SIZE);
		}
		
		private function moveSprite2(s:FlxSprite, tx:int, ty:int):void
		{
			moveSprite(s, tx, ty);
			s.x += (2 * G.TILE_SIZE - s.width) / 2;
			s.y += G.TILE_SIZE - s.height;
		}
		
		private function ovPlayerSwitch(o1:FlxObject, o2:FlxObject):void
		{
			(o2 as Switch).doSwitch();
		}
		
		private function ovFootBadBlock(o1:FlxObject, o2:FlxObject):void
		{
			(o2 as BadBlock).breakBlock();
		}
		
	}

}