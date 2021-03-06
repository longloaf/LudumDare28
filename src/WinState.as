package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class WinState extends FlxState
	{
		
		private var text:FlxText;
		private var text2:FlxText;
		
		private var menuButton:FlxButton;
		
		override public function create():void 
		{
			text = new FlxText(0, 200, FlxG.width, "WIN");
			text.size = 32;
			text.alignment = "center";
			add(text);
			
			text2 = new FlxText(0, text.y + text.height, FlxG.width, "PRESS ENTER");
			text2.size = 8;
			text2.alignment = "center";
			add(text2);
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new MenuState());
			}
		}
		
	}

}