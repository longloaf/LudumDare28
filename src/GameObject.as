package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class GameObject extends FlxSprite
	{
		
		override final public function update():void 
		{
			if (y > FlxG.height) kill();
			updateGameObject();
		}
		
		public function updateGameObject():void
		{
			
		}
		
	}

}