package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Action 
	{
		
		private var _init:Function = G.NIL_FUNC;
		private var _update:Function = G.NIL_FUNC;
		
		public function setInit(f:Function):Action
		{
			init = f;
			return this;
		}
		
		public function setUpdate(f:Function):Action
		{
			update = f;
			return this;
		}
		
		public function init():void
		{
			_init();
		}
		
		public function update():void
		{
			_update();
		}
		
		public function next():Action
		{
			return null;
		}
		
	}

}