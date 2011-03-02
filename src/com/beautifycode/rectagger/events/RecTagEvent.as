package com.beautifycode.rectagger.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class RecTagEvent extends Event {
		public static const RECTAG_STORED:String = "RECTAG_STORED";
		public static const CREATE_RECTAG : String = "CREATE_RECTAG";
		public static const EDIT_RECTAG : String = "EDIT_RECTAG";
		public static const DELETE_RECTAG : String = "DELETE_RECTAG";
		public static const RECTAG_DELETED : String = "RECTAG_DELETED";
		
		
		
		public var vo:Object;
		
		
		public function RecTagEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			var clonedEvent:RecTagEvent = new RecTagEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.vo = this.vo;

			return clonedEvent;
		}
	}
}
