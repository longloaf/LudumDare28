package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class ActionManager 
	{
		
		public var action:Action = null;
		
		public function init(a:Action):void
		{
			if (a == null) throw new Error();
			action = a;
			action.init();
		}
		
		public function update():void
		{
			var next:Action = action.next();
			if (next != null) {
				action = next;
				action.init();
			}
			action.update();
		}
		
	}

}