package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = "data/player_100x160_3.png")]
		private static const Img:Class;
		
		public var actionManager:ActionManager = new ActionManager();
		
		private var stopAction:Action = new Action("STOP");
		private var changeDirAction:Action = new Action("CHANGE DIR");
		private var smallJumpAction:Action = new Action("SMALL JUMP");
		private var squatAction:Action = new Action("SQUAT");
		private var bigJumpAction:Action = new Action("BIG JUMP");
		private var landAction:Action = new Action("LAND");
		
		private var dirChanged:Boolean;
		private var bigJumpSpeed:Number;
		private const BIG_JUMP_SPEED_D:Number = 800;
		private const BIG_JUMP_MAX_SPEED:Number = 400;
		
		private const DIR_LEFT:int = -1;
		private const DIR_RIGHT:int = 1;
		private const DIR_STOP:int = 0;
		
		private var keyDir:int = DIR_STOP;
		
		private const NO_SQUAT:int = 0;
		private const SMALL_SQUAT:int = 1;
		private const BIG_SQUAT:int = 2;
		
		private const LAND_ANIM:String = "land";
		private const BIG_JUMP_ANIM:String = "big_jump";
		
		public function Player() 
		{
			loadGraphic(Img, true, true, 100, 160);
			width /= 2;
			height = 150;
			centerOffsets();
			offset.y = 5;
			
			addAnimation(LAND_ANIM, [SMALL_SQUAT], 10, false);
			addAnimation(BIG_JUMP_ANIM, [SMALL_SQUAT, NO_SQUAT], 10, false);
			
			acceleration.y = 1000;
			facing = RIGHT;
			
			frame = NO_SQUAT;
			
			stopAction
			.setInit(stopAction_init)
			.setNext(stopAction_next);
			
			changeDirAction
			.setInit(changeDir_init)
			.setUpdate(changeDir_update)
			.setNext(jump_next);
			
			smallJumpAction
			.setInit(smallJump_init)
			.setNext(jump_next);
			
			squatAction
			.setInit(squat_init)
			.setUpdate(squat_update)
			.setNext(squat_next);
			
			bigJumpAction
			.setInit(bigJump_init)
			.setNext(jump_next);
			
			landAction
			.setInit(land_init)
			.setNext(land_next);
			
			actionManager.init(stopAction);
			
			x = (FlxG.width - width) / 2;
			y = 0;
		}
		
		/*override public function update():void 
		{
			var dir:int = 0;
			if (FlxG.keys.RIGHT) dir += 1;
			if (FlxG.keys.LEFT) dir -= 1;
			
			if (isTouching(FLOOR)) {
				velocity.x = 0;
				acceleration.x = 0;
				if (FlxG.keys.UP) {
					velocity.y = -300;
					jumpState = BIG_JUMP_STATE;
				} else {
					var f:int = facing == RIGHT ? 1 : -1;
					if (dir != 0) {
						velocity.y = -100;
						if (dir == f) {
							velocity.x = dir * 100;
							jumpState = SMALL_JUMP_STATE;
						} else {
							velocity.x = 0;
							jumpState = CHANGE_DIR_STATE;
							dirChanged = false;
						}
					}
				}
			} else {
				drag.x = 0;
				if (jumpState == CHANGE_DIR_STATE) {
					if (!dirChanged && (velocity.y > 0)) {
						setFacing(dir);
						dirChanged = true;
					}
				} else if (jumpState == BIG_JUMP_STATE) {
					acceleration.x = 100 * dir;
					setFacing(dir);
				}
			}
		}*/
			
		override public function update():void 
		{
			keyDir = DIR_STOP;
			if (FlxG.keys.LEFT) keyDir += DIR_LEFT;
			if (FlxG.keys.RIGHT) keyDir += DIR_RIGHT;
			actionManager.update();
		}
		
		// STOP
		
		private function stopAction_init():void
		{
			frame = SMALL_SQUAT;
		}
		
		private function stopAction_next():Action
		{
			if (!isTouching(FLOOR)) return null;
			if (FlxG.keys.Z) return squatAction;
			var f:int = facing == RIGHT ? 1 : -1;
			if (keyDir != 0) {
				if (keyDir == f) return smallJumpAction;
				return changeDirAction;
			}
			return null;
		}
		
		// CHANGE DIR
		
		private function changeDir_init():void
		{
			frame = NO_SQUAT;
			velocity.y = -100;
			dirChanged = false;
		}
		
		private function changeDir_update():void
		{
			if (!dirChanged && (velocity.y > 0)) {
				if (facing == LEFT) {
					facing = RIGHT;
				} else {
					facing = LEFT;
				}
				dirChanged = true;
			}
		}
		
		// SMALL JUMP
		
		private function smallJump_init():void
		{
			frame = NO_SQUAT;
			velocity.y = -100;
			velocity.x = keyDir * 100;
		}
		
		// SQUAT
		
		private function squat_init():void
		{
			frame = BIG_SQUAT;
			bigJumpSpeed = 0;
		}
		
		private function squat_update():void
		{
			bigJumpSpeed += FlxG.elapsed * BIG_JUMP_SPEED_D;
		}
		
		private function squat_next():Action
		{
			if (!FlxG.keys.Z || (bigJumpSpeed >= BIG_JUMP_MAX_SPEED)) return bigJumpAction;
			return null;
		}
		
		// BIG JUMP
		
		private function bigJump_init():void
		{
			play(BIG_JUMP_ANIM);
			velocity.y = -bigJumpSpeed;
			velocity.x = keyDir * 200;
		}
		
		// JUMP (SMALL JUMP, BIG_JUMP, CHANGE DIR)
		
		private function jump_next():Action
		{
			if (isTouching(FLOOR)) return landAction;
			return null;
		}
		
		// LAND
		
		private function land_init():void
		{
			velocity.x = 0;
			play(LAND_ANIM);
		}
		
		private function land_next():Action
		{
			if (finished) return stopAction;
			return null;
		}
		
		/*private function setFacing(dir:int):void
		{
			if (dir == 1) {
				facing = RIGHT;
			} else if (dir == -1) {
				facing = LEFT;
			}
		}*/
		
	}

}