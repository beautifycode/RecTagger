package com.beautifycode.rectagger.events {
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class FileRefEvent extends Event {
		public static const SINGLE_IMAGE_LOADED:String = "SINGLE_IMAGE_LOADED";
		public static const GENERATE_THUMBNAILS:String = "CREATE_THUMBNAILS";
		public var vo:*;
		
		public function FileRefEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var clonedEvent:FileRefEvent = new FileRefEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.vo = this.vo;

			return clonedEvent;
		}
	}
}
