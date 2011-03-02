package com.beautifycode.rectagger.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class MetaDataEvent extends Event {
		public static const SAVE_DATA:String = "SAVE_DATA";
		public static const CANCEL_CREATION:String = "CANCEL_CREATION";
		public var vo:Object;
		
		public function MetaDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var clonedEvent:MetaDataEvent = new MetaDataEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.vo = this.vo;

			return clonedEvent;
		}
	}
}
