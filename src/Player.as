package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Player extends Creature
	{
		[Embed(source = "data/player_100x130_3.png")]
		private static const Img:Class;
		
		[Embed(source = "data/arm.png")]
		private static const ArmImg:Class;
		
		public var actionManager:ActionManager = new ActionManager();
		
		private var stopAction:Action = new Action("STOP");
		private var changeDirAction:Action = new Action("CHANGE DIR");
		private var smallJumpAction:Action = new Action("SMALL JUMP");
		private var squatAction:Action = new Action("SQUAT");
		private var bigJumpAction:Action = new Action("BIG JUMP");
		private var landAction:Action = new Action("LAND");
		private var attackAction:Action = new Action("ATTACK");
		
		private var dirChanged:Boolean;
		private var verticalJump:Boolean;
		private const BIG_JUMP_VEL_Y:Number = 300;
		private const BIG_JUMP_VEL_X:Number = 203;
		private const VERTICAL_JUMP_VEL_Y:Number = 400;
		private const SMALL_JUMP_VEL_X:Number = 80; // 100;
		private const SMALL_JUMP_VEL_Y:Number = 100;
		
		private const DIR_LEFT:int = -1;
		private const DIR_RIGHT:int = 1;
		private const DIR_STOP:int = 0;
		
		private var keyDir:int = DIR_STOP;
		
		private const NO_SQUAT:int = 0;
		private const SMALL_SQUAT:int = 1;
		private const BIG_SQUAT:int = 2;
		
		private const LAND_ANIM:String = "land";
		private const SQUAT_ANIM:String = "squat";
		private const BIG_JUMP_ANIM:String = "big_jump";
		
		private const LEFT_KEY:String = "LEFT";
		private const RIGHT_KEY:String = "RIGHT";
		private const BIG_JUMP_KEY:String = "Z";
		private const VERTICAL_JUMP_KEY:String = "UP";
		private const ATTACK_KEY:String = "X";
		
		public var arm:FlxSprite;
		public var sword:FlxSprite;
		
		override protected function create():void 
		{
			loadGraphic(Img, true, true, 100, 130);
			width /= 4;
			height = 110;
			centerOffsets();
			offset.y = 15;
			
			addAnimation(LAND_ANIM, [SMALL_SQUAT], 15, false);
			addAnimation(SQUAT_ANIM, [BIG_SQUAT], 10, false);
			addAnimation(BIG_JUMP_ANIM, [SMALL_SQUAT, NO_SQUAT], 10, false);
			
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
			.setNext(squat_next);
			
			bigJumpAction
			.setInit(bigJump_init)
			.setNext(jump_next);
			
			landAction
			.setInit(land_init)
			.setNext(land_next);
			
			attackAction
			.setInit(attack_init)
			.setUpdate(attack_update)
			.setNext(attack_next);
			
			actionManager.init(stopAction);
			
			arm = new FlxSprite();
			arm.loadGraphic(ArmImg, false, true);
			arm.origin.x = 10;
			arm.origin.y = arm.height;
			arm.antialiasing = true;
			arm.visible = false;
			arm.reset(100, 300);
			
			sword = new FlxSprite();
			sword.makeGraphic(60, 90);
			sword.solid = false;
			sword.visible = false;
			
			x = (FlxG.width - width) / 2;
			y = 0;
		}
			
		override public function updateGameObject():void 
		{
			keyDir = DIR_STOP;
			if (FlxG.keys.pressed(LEFT_KEY)) keyDir += DIR_LEFT;
			if (FlxG.keys.pressed(RIGHT_KEY)) keyDir += DIR_RIGHT;
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
			if (FlxG.keys.pressed(ATTACK_KEY)) {
				return attackAction;
			}
			if (FlxG.keys.pressed(VERTICAL_JUMP_KEY)) {
				verticalJump = true;
				return squatAction;
			}
			if (FlxG.keys.pressed(BIG_JUMP_KEY)) {
				verticalJump = false;
				return squatAction;
			}
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
			velocity.y = -SMALL_JUMP_VEL_Y;
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
			velocity.y = -SMALL_JUMP_VEL_Y;
			velocity.x = fdir() * SMALL_JUMP_VEL_X;
		}
		
		// SQUAT
		
		private function squat_init():void
		{
			play(SQUAT_ANIM);
		}
		
		private function squat_next():Action
		{
			if (finished) return bigJumpAction;
			return null;
		}
		
		// BIG JUMP
		
		private function bigJump_init():void
		{
			play(BIG_JUMP_ANIM);
			if (verticalJump) {
				velocity.y = -VERTICAL_JUMP_VEL_Y;
			} else {
				velocity.y = -BIG_JUMP_VEL_Y;
				velocity.x = fdir() * BIG_JUMP_VEL_X;
			}
		}
		
		// JUMP (SMALL JUMP, BIG_JUMP, CHANGE DIR)
		
		private function jump_next():Action
		{
			if (isTouching(FLOOR)) return landAction;
			return null;
		}
		
		// ATTACK
		
		private function attack_init():void
		{
			arm.visible = true;
			arm.facing = facing;
			if (arm.facing == RIGHT) {
				arm.origin.x = 10;
			} else {
				arm.origin.x = arm.width - 10;
			}
			arm.angle = 0;
		}
		
		private function attack_update():void
		{
			arm.angle += (facing == RIGHT ? 1 : -1) * FlxG.elapsed * 230;
			if (Math.abs(arm.angle) > 30) {
				sword.solid = true;
				//sword.visible = true;
			}
		}
		
		private function attack_next():Action
		{
			if (((arm.facing == RIGHT) && (arm.angle > 90)) || ((arm.facing == LEFT) && (arm.angle < -90))) {
				arm.visible = false;
				sword.solid = false;
				//sword.visible = false;
				return stopAction;
			}
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
		
		//
		
		private function fdir():int
		{
			if (facing == LEFT) return DIR_LEFT;
			return DIR_RIGHT;
		}
		
		public function updateArm():void
		{
			arm.x = x + width / 2;
			if (facing == LEFT) arm.x -= arm.width;
			arm.y = y - height +  10;
			
			sword.x = x + width / 2;
			if (facing == RIGHT) {
				sword.x += 50;
			} else {
				sword.x -= 50 + sword.width;
			}
			sword.y = y - 30;
		}
		
	}

}