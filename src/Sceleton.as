package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Sceleton extends Creature
	{
		[Embed(source = "data/sceleton.png")]
		private static const Img:Class;
		
		private var player:Player = null;
		private var fast:Boolean;
		
		private const V_SLOW:Number = 50;
		private const V_FAST:Number = 200;
		
		private var vel:Number;
		
		public function Sceleton(p:Player, f:Boolean) 
		{
			player = p;
			fast = f;
			if (fast) {
				maxVelocity.x = V_FAST;
			} else {
				maxVelocity.x = V_SLOW;
			}
		}
		
		override protected function create():void 
		{
			if (player == null) throw new Error();
			loadGraphic(Img, true, true, 100, 120);
			width /= 4;
			centerOffsets();
			height = 100;
			offset.y = 20;
			if (fast) {
				frame = 1;
			} else {
				frame = 0;
			}
			
		}
		
		override public function updateGameObject():void 
		{
			if (player.exists) {
				var d:Number = (x + width / 2) - (player.x + player.width / 2);
				facing = d > 0 ? LEFT : RIGHT;
				if (Math.abs(d) < 500) {
					acceleration.x = (d > 0 ? -1 : 1) * 1000;
				} else {
					velocity.x = 0;
				}
			} else {
				velocity.x = 0;
			}
		}
		
	}

}