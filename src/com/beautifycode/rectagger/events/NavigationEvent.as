package com.beautifycode.rectagger.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class NavigationEvent extends Event {
		public static const BROWSE_FILES:String = "BROWSE_FILES";
		public static const SWITCH_TO_SCROLL:String = "SWITCH_TO_SCROLL";
		public static const SWITCH_TO_DRAW:String = "SWITCH_TO_DRAW";
		public static const SAVE_COORDS:String = "SAVE_COORDS";
		public var vo:Object;

		public function NavigationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			var clonedEvent:NavigationEvent = new NavigationEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.vo = this.vo;

			return clonedEvent;
		}
	}
}
