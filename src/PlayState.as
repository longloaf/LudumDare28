package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
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
			var bg:FlxSprite = new FlxSprite();
			bg.makeGraphic(FlxG.width, FlxG.height);
			
			floor = new Floor();
			player = new Player();
			
			add(bg);
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