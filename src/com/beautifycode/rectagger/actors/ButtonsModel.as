package com.beautifycode.rectagger.actors {
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Marvin
	 */
	public class ButtonsModel extends Actor {
		public var coordsObj:Object;
		
		public function ButtonsModel() {
			coordsObj = new Object();
		}

		public function saveNewButton(page:int, x:int, y:int, w:int, h:int, trigger:String):void {
			trace("saving");
		}
	}
}
