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
		[Embed(source = "data/player.png")]
		private static const Img:Class;
		
		private const SMALL_JUMP_STATE:int = 0;
		private const BIG_JUMP_STATE:int = 1;
		private const CHANGE_DIR_STATE:int = 2;
		private var jumpState:int = BIG_JUMP_STATE;
		
		private var dirChanged:Boolean;
		
		public function Player() 
		{
			loadGraphic(Img, false, true);
			
			acceleration.y = 400;
			facing = RIGHT;
			
			x = (FlxG.width - width) / 2;
			y = 0;
		}
		
		override public function update():void 
		{
			var dir:int = 0;
			if (FlxG.keys.RIGHT) dir += 1;
			if (FlxG.keys.LEFT) dir -= 1;
			
			if (isTouching(FLOOR)) {
				acceleration.x = 0;
				drag.x = 400;
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
						facing = facing == RIGHT ? LEFT : RIGHT;
						dirChanged = true;
					}
				} else if (jumpState == BIG_JUMP_STATE) {
					acceleration.x = 50 * dir;
					facing = dir == 1 ? RIGHT : LEFT;
				}
			}
		}
		
	}

}