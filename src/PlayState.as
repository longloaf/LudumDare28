package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
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
		private var platform:FlxSprite;
		private var player:Player;
		private var solidObjects:FlxGroup;
		
		private var actionText:FlxText;
		private var prevAction:Action = null;
		private var nextAction:Action = null;
		
		override public function create():void 
		{
			var bg:FlxSprite = new FlxSprite();
			bg.makeGraphic(FlxG.width, FlxG.height);
			
			floor = new Floor();
			
			platform = new FlxSprite();
			platform.makeGraphic(300, 20, 0xFF808080);
			platform.immovable = true;
			platform.allowCollisions = FlxObject.UP;
			platform.reset(400, 300);
			
			player = new Player();
			
			actionText = new FlxText(10, 10, FlxG.width, "");
			actionText.size = 16;
			actionText.color = FlxG.BLUE;
			actionText.shadow = FlxG.BLACK;
			
			solidObjects = new FlxGroup();
			solidObjects.add(floor);
			solidObjects.add(platform);
			
			add(bg);
			add(solidObjects);
			add(player);
			add(actionText);
		}
		
		override public function update():void 
		{	
			super.update();
			
			FlxG.collide(player, solidObjects);
			
			prevAction = nextAction;
			nextAction = player.actionManager.action;
			if (prevAction != nextAction) FlxG.log(nextAction.name);
			actionText.text = player.actionManager.action.name;
			
			if (FlxG.keys.justPressed("ENTER")) FlxG.resetState();
		}
		
	}

}