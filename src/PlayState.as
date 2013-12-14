package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class PlayState extends FlxState
	{
		private var floor:Floor;
		private var player:Player;
		
		override public function create():void 
		{
			floor = new Floor();
			player = new Player();
			
			add(floor);
			add(player);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(floor, player);
		}
		
	}

}