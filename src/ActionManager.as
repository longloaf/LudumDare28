package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class ActionManager 
	{
		
		private var action:Action = null;
		private var actionInited:Boolean = false;
		
		public function init(a:Action):void;
		{
			if (a == null) throw new Error();
			action = a;
			actionInited = false;
		}
		
		public function update():void
		{
			if (!actionInited) {
				action.init();
				actionInited = true;
			}
			action.update();
			var next:Action = action.next();
			if (next != null) {
				action = next;
				actionInited = false;
			}
		}
		
	}

}