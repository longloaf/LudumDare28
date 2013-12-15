package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Blood extends FlxSprite
	{
		[Embed(source = "data/blood_100x130_4.png")]
		private static const Img:Class;
		
		private var A:String = "A";
		
		public function Blood() 
		{
			loadGraphic(Img, true, false, 100, 130);
			addAnimation(A, [0, 1, 2, 3], 20, false);
		}
		
		override public function update():void 
		{
			if (finished) {
				kill();
			}
		}
		
		public function resetBlood(X:Number, Y:Number):void 
		{
			reset(X - width / 2, Y - height / 2);
			play(A);
		}
		
	}

}