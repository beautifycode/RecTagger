package com.beautifycode.rectagger.components {
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.events.MetaDataEvent;
	import com.beautifycode.rectagger.events.RecTagEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Blase
	 */
	public class ThumbnailMediator extends Mediator {
		[Inject]
		public var view : Thumbnail;

		[Inject]
		public var rectagsmodel : RecTagsModel;
		
		[Inject]
		public var canvasmodel : CanvasModel;


		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, MetaDataEvent.SAVE_DATA, refreshInfos);
			eventMap.mapListener(eventDispatcher, RecTagEvent.RECTAG_DELETED, refreshInfos);
		}

		private function refreshInfos(event : *) : void {
			view.refreshInfos(rectagsmodel.rects, canvasmodel.currentPage);
		}
	}
}
