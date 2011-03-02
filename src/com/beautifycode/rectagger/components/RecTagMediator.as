package com.beautifycode.rectagger.components {
	import com.beautifycode.rectagger.events.RecTagEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Blase
	 */
	public class RecTagMediator extends Mediator {
		[Inject]
		public var view:RecTag;

		override public function onRegister() : void {
			eventMap.mapListener(view, RecTagEvent.EDIT_RECTAG, dispatch);
			eventMap.mapListener(view, RecTagEvent.DELETE_RECTAG, dispatch);
		}
	}
}
