package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Level extends FlxState
	{	
		[Embed(source = "data/tiles_32x32_20.png")]
		private static const Tiles:Class;
		
		protected var tileMap:FlxTilemap;
		private var start:Start;
		private var finish:Finish;
		private var badBlockGroup:FlxGroup;
		private var platformGroup:FlxGroup;
		private var doorGroup:FlxGroup;
		private var player:Player;
		private var enemyGroup:FlxGroup;
		private var bloodGroup:BloodGroup;
		private var knifeGroup:KnifeGroup;
		private var switchGroup:FlxGroup;
		
		private var solidGroup:FlxGroup;
		private var footGroup:FlxGroup;
		
		private var txt:FlxText;
		
		override public function create():void 
		{
			tileMap = new FlxTilemap();
			tileMap.loadMap(new (getMap()), Tiles, 32, 32, FlxTilemap.OFF, G.T_START, G.T_DRAW, G.T_COLLIDE);
			tileMap.reset(0, 0);
			
			start = new Start();
			finish = new Finish();
			
			badBlockGroup = new FlxGroup();
			platformGroup = new FlxGroup();
			doorGroup = new FlxGroup();
			
			player = new Player();
			player.createCreature();
			enemyGroup = new FlxGroup();
			bloodGroup = new BloodGroup();
			knifeGroup = new KnifeGroup();
			
			switchGroup = new FlxGroup();
			footGroup = new FlxGroup();
			footGroup.visible = false;
			
			txt = new FlxText(0, 200, FlxG.width, "R - RESTART, Q - QUIT");
			txt.size = 32;
			txt.color = FlxG.BLACK;
			txt.alignment = "center";
			txt.visible = false;
			txt.scrollFactor.x = txt.scrollFactor.y = 0;
			
			FlxG.camera.follow(player);
			tileMap.follow();
			
			solidGroup = new FlxGroup();
			solidGroup.add(tileMap);
			solidGroup.add(badBlockGroup);
			solidGroup.add(platformGroup);
			solidGroup.add(doorGroup);
			
			footGroup.add(player.foot);
			
			add(tileMap);
			add(start);
			add(finish);
			add(badBlockGroup);
			add(platformGroup);
			add(doorGroup);
			add(player);
			add(player.sword);
			add(player.arm);
			add(enemyGroup);
			add(bloodGroup);
			add(knifeGroup);
			add(switchGroup);
			add(footGroup);
			add(txt);
			
			makeLevel();
			
			player.reset(start.x + (start.width - player.width) / 2, start.y + start.height - player.height);
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
			FlxG.collide(player, solidGroup);
			FlxG.collide(enemyGroup, solidGroup);
			
			player.updateFoot();
			player.updateArm();
			enemyGroup.callAll("updateFoot");
			
			FlxG.overlap(player.sword, enemyGroup, ovSwordEnemy);
			FlxG.overlap(player.sword, knifeGroup, ovSwordEnemy);
			FlxG.overlap(player, enemyGroup, ovPlayerEnemy);
			FlxG.overlap(player, knifeGroup, ovPlayerEnemy);
			
			FlxG.overlap(footGroup, badBlockGroup, ovFootBadBlock);
			
			FlxG.overlap(player, switchGroup, ovPlayerSwitch);
			
			FlxG.overlap(player, finish, ovPlayerFinish);
			
			txt.visible = !player.exists;
			
			if (FlxG.keys.justPressed("R")) {
				FlxG.resetState();
			} else if (FlxG.keys.justPressed("Q")) {
				FlxG.switchState(new MenuState());
			} else if (FlxG.keys.justPressed("N")) {
				G.nextLevel();
			}
		}
		
		public function makePlatform(tx:int, ty:int, width:int = 1, height:int = 1, step:int = 1):void
		{
			if ((width < 1) || (height < 1) || (step < 1)) throw new Error();
			for (var x:int = 0; x < width; ++x) {
				for (var y:int = 0; y < height; y += step) {
					var p:Platform = new Platform();
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
		
		public function makeWorm(tx:int, ty:int):void
		{
			var w:Worm = new Worm(player);
			w.createCreature();
			moveSprite2(w, tx, ty);
			addEnemy(w);
		}
		
		public function makeSceleton(tx:int, ty:int, fast:Boolean):void
		{
			var s:Sceleton = new Sceleton(player, fast);
			s.createCreature();
			moveSprite2(s, tx, ty);
			addEnemy(s);
		}
		
		public function makeBoss(tx:int, ty:int):void
		{
			var b:Boss = new Boss(player, knifeGroup);
			b.createCreature();
			moveSprite2(b, tx, ty);
			addEnemy(b);
		}
		
		private function addEnemy(c:Creature):void
		{
			enemyGroup.add(c);
			footGroup.add(c.foot);
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
		
		private function ovPlayerFinish(o1:FlxObject, o2:FlxObject):void
		{
			finish.solid = false;
			G.nextLevel();
		}
		
		private function ovSwordEnemy(o1:FlxObject, o2:FlxObject):void
		{
			if (!(o2 is Worm) && !(o2 is Knife)) {
				bloodGroup.makeBLood(o2.x + o2.width / 2, o2.y + o2.height / 2);
			}
			o2.kill();
		}
		
		private function ovPlayerEnemy(o1:FlxObject, o2:FlxObject):void
		{
			player.kill();
			bloodGroup.makeBLood(player.x + player.width / 2, player.y + player.height / 2);
		}
		
	}

}