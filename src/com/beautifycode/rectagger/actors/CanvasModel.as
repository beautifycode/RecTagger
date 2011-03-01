package com.beautifycode.rectagger.actors {
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Marvin
	 */
	public class CanvasModel extends Actor {
		public var currentRectPos:Object;

		public function CanvasModel() {
			currentRectPos = new Object();
		}

		public function store(x:int, y:int, w:int, h:int):void {
			currentRectPos.x = x;
			currentRectPos.y = y;
			currentRectPos.w = w;
			currentRectPos.h = h;
		}
	}
}
