package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Action 
	{
		public var name:String;
		public var init:Function = G.NIL_FUNC;
		public var update:Function = G.NIL_FUNC;
		public var next:Function = G.NIL_FUNC;
		
		public function Action(n:String = "UNKNOWN ACTION")
		{
			name = n;
		}
		
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
		
		public function setNext(f:Function):Action
		{
			next = f;
			return this;
		}
		
	}

}