package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.events.MetaDataEvent;
	import com.beautifycode.rectagger.events.RecTagEvent;

	import org.robotlegs.mvcs.Mediator;


	/**
	 * @author Marvin
	 */
	public class MetaDataViewMediator extends Mediator {
		[Inject]
		public var view:MetaDataView;
		
		
		[Inject]
		public var canvasmodel:CanvasModel;
		
		override public function onRegister():void {
			eventMap.mapListener(view, MetaDataEvent.SAVE_DATA, dispatch);
			eventMap.mapListener(view, MetaDataEvent.CANCEL_CREATION, dispatch);
			eventMap.mapListener(view, MetaDataEvent.CANCEL_EDIT, dispatch);
		}
	}
}
