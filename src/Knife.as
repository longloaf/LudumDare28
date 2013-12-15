package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Knife extends GameObject
	{
		[Embed(source = "data/knife.png")]
		private static const Img:Class;
		
		private var t:Number = 0;
		private var T:Number = 5;
		
		public function Knife() 
		{
			loadGraphic(Img, false, true);
		}
		
		public function resetKnife(x:Number, y:Number, vel:Number):void
		{
			reset(x - width / 2, y - height / 2);
			velocity.x = vel;
			facing = vel > 0 ? RIGHT : LEFT;
			acceleration.y = 0;
			t = 0;
		}
		
		override public function updateGameObject():void 
		{
			t += FlxG.elapsed;
			if (t > T) kill();
		}
		
	}

}