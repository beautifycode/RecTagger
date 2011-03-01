package com.beautifycode.rectagger.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class CanvasEvent extends Event {
		public static const STORE_CURRENT_RECT:String = "STORE_CURRENT_RECT";
		public var vo:Object;
		
		public function CanvasEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var clonedEvent:CanvasEvent = new CanvasEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.vo = this.vo;

			return clonedEvent;
		}
	}
}
