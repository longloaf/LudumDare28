package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Switch extends FlxSprite
	{
		[Embed(source = "data/switch_64x80_2.png")]
		private static const Img:Class;
		
		private var door:Door;
		
		public function Switch(d:Door, left:Boolean = true) 
		{
			loadGraphic(Img, true, false, 64, 80);
			if (left) {
				frame = 0;
			} else {
				frame = 1;
			}
			width /= 3;
			centerOffsets();
			height = 50;
			offset.y = 30;
			
			door = d;
		}
		
		public function doSwitch():void
		{
			frame = (frame + 1) % 2;
			solid = false;
			door.kill();
		}
		
	}

}