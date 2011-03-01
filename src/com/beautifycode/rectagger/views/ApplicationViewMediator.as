package com.beautifycode.rectagger.views {
	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;


	/**
	 * @author Blase
	 */
	public class ApplicationViewMediator extends Mediator {

		[Inject]
		public var view : ApplicationView;

		override public function onRegister() : void {
			eventMap.mapListener(view.stage, Event.RESIZE, onResize);
		}

		private function onResize(event:Event) : void {
			
		}

	}
}
