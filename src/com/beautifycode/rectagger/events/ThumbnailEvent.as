package com.beautifycode.rectagger.events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class ThumbnailEvent extends Event {
		public static const THUMBNAIL_CLICK:String = "THUMBNAIL_CLICK";
		public var vo:*;
		
		public function ThumbnailEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var clonedEvent:ThumbnailEvent = new ThumbnailEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.vo = this.vo;

			return clonedEvent;
		}
	}
}
