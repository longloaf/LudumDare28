package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Worm extends Creature
	{
		[Embed(source = "data/worm_60x30_4.png")]
		private static const Img:Class;
		
		private static const STAY:String = "1";
		private static const RUN:String = "2";
		
		private var player:Player;
		
		private var run:Boolean = false;
		
		public function Worm(p:Player) 
		{
			player = p;
		}
		
		override public function create():void 
		{
			loadGraphic(Img, true, true, 60, 30);
			width /= 2;
			centerOffsets();
			height = 15;
			offset.y = 15;
			
			addAnimation(STAY, [0, 1], 5);
			addAnimation(RUN, [2, 3], 10);
			play(STAY);
		}
		
		override public function updateGameObject():void 
		{
			if (!run) {
				var d:Number = (x + width / 2) - (player.x + player.width / 2);
				if (Math.abs(d) < 300) {
					run = true;
					velocity.x = (d > 0 ? 1 : -1) * 130;
					facing = d > 0 ? RIGHT : LEFT;
					play(RUN);
				} else {
					facing = d > 0 ? LEFT : RIGHT;
				}
			} 
		}
		
	}

}