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
		
		private var actionText:FlxText;
		private var prevAction:Action = null;
		private var nextAction:Action = null;
		
		override public function create():void 
		{
			var bg:FlxSprite = new FlxSprite();
			bg.makeGraphic(FlxG.width, FlxG.height);
			
			floor = new Floor();
			player = new Player();
			
			actionText = new FlxText(10, 10, FlxG.width, "");
			actionText.size = 16;
			actionText.color = FlxG.BLUE;
			actionText.shadow = FlxG.BLACK;
			
			add(bg);
			add(floor);
			add(player);
			add(actionText);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(floor, player);
			
			prevAction = nextAction;
			nextAction = player.actionManager.action;
			if (prevAction != nextAction) FlxG.log(nextAction.name);
			actionText.text = player.actionManager.action.name;
			
			if (FlxG.keys.justPressed("ENTER")) FlxG.resetState();
		}
		
	}

}