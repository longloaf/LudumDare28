package  
{
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
		
		override public function create():void 
		{
			text = new FlxText(0, 200, FlxG.width, "WIN\nPRESS ENTER");
			text.size = 32;
			text.alignment = "center";
			add(text);
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new MenuState());
			}
		}
		
	}

}