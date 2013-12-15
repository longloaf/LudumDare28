package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Creature extends GameObject
	{
		
		public var foot:FlxSprite = new FlxSprite;
		
		public function createCreature():void
		{
			create();
			foot.makeGraphic(width, 5, FlxG.RED);
		}
		
		protected function create():void { }
		
		override public function reset(X:Number, Y:Number):void 
		{
			super.reset(X, Y);
			updateFoot();
			foot.reset(foot.x, foot.y);
		}
		
		public function updateFoot():void
		{
			foot.x = x + (width - foot.width) / 2;
			foot.y = y + height;
		}
		
	}

}