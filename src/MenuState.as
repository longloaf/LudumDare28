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
	public class MenuState extends FlxState
	{
		
		private var gameName:FlxText;
		private var info:FlxText;
		private var controls:FlxText;
		private var playButton:FlxButton;
		
		override public function create():void 
		{
			gameName = new FlxText(0, 100, FlxG.width, "ONE-LEGGED MAN");
			gameName.size = 32;
			gameName.alignment = "center";
			add(gameName);
			
			info = new FlxText(0, gameName.y + gameName.height + 50, FlxG.width,
			"BY MAKSIM SOLDATOV FOR LUDUM DARE 28\nTHEME: YOU ONLY GET ONE");
			info.size = 16;
			info.alignment = "center";
			add(info);
			
			controls = new FlxText(0, info.y + info.height + 50, FlxG.width,
			"CONTROLS: UP, LEFT, RIGHT, Z, X");
			controls.size = 16;
			controls.alignment = "center";
			add(controls);
			
			playButton = new FlxButton(0, 0, "PLAY", G.startGame);
			playButton.x = (FlxG.width - playButton.width) / 2;
			playButton.y = controls.y + controls.height + 50;
			add(playButton);
		}
		
	}

}