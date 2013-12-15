package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Boss extends Creature
	{
		[Embed(source = "data/boss_100x120_2.png")]
		private static const Img:Class;
		
		private var player:Player;
		private var knifeGroup:KnifeGroup;
		
		private var stand:Boolean = true;
		
		private var time:Number = 0;
		private var T:Number;
		
		private var waitAction:Action = new Action();
		private var shotAction:Action = new Action();
		private var sitDownAction:Action = new Action();
		private var standUpAction:Action = new Action();
		
		private var actionManager:ActionManager = new ActionManager();
		
		public function Boss(p:Player, k:KnifeGroup) 
		{
			player = p;
			knifeGroup = k;
		}
		
		override protected function create():void 
		{
			loadGraphic(Img, true, true, 100, 120);
			width /= 4;
			centerOffsets();
			height = 100;
			offset.y = 20;
			facing = LEFT;
			
			waitAction
			.setInit(wait_init)
			.setUpdate(wait_update)
			.setNext(wait_next);
			
			shotAction
			.setInit(shot_init)
			.setNext(shot_next);
			
			sitDownAction
			.setInit(sitDown_init)
			.setUpdate(sitDown_update)
			.setNext(sitDown_next);
			
			standUpAction
			.setInit(standUp_init)
			.setUpdate(standUp_update)
			.setNext(standUp_next);
			
			actionManager.init(waitAction);
		}
		
		override public function updateGameObject():void 
		{
			actionManager.update();
		}
		
		// WAIT
		
		private function wait_init():void
		{
			time = 0;
			T = 3;
			FlxG.log("wait");
		}
		
		private function wait_update():void
		{
			time += FlxG.elapsed;
		}
		
		private function wait_next():Action
		{
			if (time >= T) {
				if (FlxG.random() > 0.5) return shotAction;
				return sitDownAction;
			}
			return null;
		}
		
		// SHOT
		
		private function shot_init():void
		{
			var ky:Number;
			if (stand) {
				ky = y + 20;
			} else {
				ky = y + height - 20;
			}
			knifeGroup.makeKnife(x, ky, -500);
			FlxG.log("shot");
		}
		
		private function shot_next():Action
		{
			if (stand) return waitAction;
			return standUpAction;
		}
		
		// SIT DOWN
		
		private function sitDown_init():void
		{
			time = 0;
			T = 0.3;
			frame = 1;
			stand = false;
			FlxG.log("sitDown");
		}
		
		private function sitDown_update():void
		{
			time += FlxG.elapsed;
		}
		
		private function sitDown_next():Action
		{
			if (time >= T) return shotAction;
			return null;
		}
		
		// STAND UP
		
		private function standUp_init():void
		{
			time = 0;
			T = 0.3;
			
			FlxG.log("standUp");
		}
		
		private function standUp_update():void
		{
			time += FlxG.elapsed;
		}
		
		private function standUp_next():Action
		{
			if (time > T) {
				frame = 0;
				stand = true;
				return waitAction;
			}
			return null;
		}
		
	}

}