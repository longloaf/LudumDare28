package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class BloodGroup extends FlxGroup
	{
		
		public function makeBLood(x:Number, y:Number):void
		{
			var b:Blood = recycle(Blood) as Blood;
			b.resetBlood(x, y);
		}
		
	}

}