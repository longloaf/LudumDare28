package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class KnifeGroup extends FlxGroup
	{
		
		public function makeKnife(x:Number, y:Number, vel:Number):void
		{
			var k:Knife = recycle(Knife) as Knife;
			k.resetKnife(x, y, vel);
		}
		
	}

}