package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class BadBlock extends FlxSprite
	{
		[Embed(source = "data/badBlock_40x40_3.png")]
		private static const Img:Class;
		
		private static const A1:String = "1";
		private static const A2:String = "2";
		
		private var broken:Boolean = false;
		
		private var time:Number = 0;
		private const T:Number = 1;
		
		public function BadBlock() 
		{
			loadGraphic(Img, true, false, 40, 40);
			width = height = 32;
			centerOffsets();
			immovable = true;
			
			addAnimation(A1, [1]);
			addAnimation(A2, [0, 1, 2, 1], 10);
			
			play(A1);
		}
		
		override public function update():void 
		{
			if (!broken) return;
			if (time < T) {
				time += FlxG.elapsed;
				if (time >= T) acceleration.y = 1200;
			}
			if (y > FlxG.height) kill();
		}
		
		public function breakBlock():void
		{
			broken = true;
			play(A2);
		}
		
	}

}