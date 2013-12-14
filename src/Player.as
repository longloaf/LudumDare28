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
		
		private const SMALL_JUMP_STATE:int = 0;
		private const SMALL_SUMP_FINISH_STATE:int = 1;
		private const BIG_JUMP_PREPARE_STATE:int = 2;
		private const BIG_JUMP_STATE:int = 3;
		private const BIG_JUMP_FINISH_STATE:int = 4;
		private const CHANGE_DIR_STATE:int = 5;
		private var jumpState:int = BIG_JUMP_STATE;
		
		private var dirChanged:Boolean;
		
		private const NO_SQUAT:int = 0;
		private const SMALL_SQUAT:int = 1;
		private const BIG_SQUAT:int = 2;
		
		public function Player() 
		{
			loadGraphic(Img, true, true, 100, 160);
			width /= 2;
			height = 150;
			centerOffsets();
			offset.y = 5;
			
			acceleration.y = 400;
			facing = RIGHT;
			
			frame = NO_SQUAT;
			
			x = (FlxG.width - width) / 2;
			y = 0;
		}
		
		override public function update():void 
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
		}
		
		private function setFacing(dir:int):void
		{
			if (dir == 1) {
				facing = RIGHT;
			} else if (dir == -1) {
				facing = LEFT;
			}
		}
		
	}

}