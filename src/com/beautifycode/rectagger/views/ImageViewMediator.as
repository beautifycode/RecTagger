package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.events.FileRefEvent;
	import com.beautifycode.rectagger.events.ThumbnailEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Marvin
	 */
	public class ImageViewMediator extends Mediator {
		[Inject]
		public var view:ImageView;

		[Inject]
		public var model:ImagesModel;


		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, ThumbnailEvent.THUMBNAIL_CLICK, onImageChange, ThumbnailEvent);
		}

		private function onImageChange(event:ThumbnailEvent):void {
			view.removeCurrentImage();
			view.addImage(model.images[event.vo]);
		}

		private function onSingleImageLoaded(event:FileRefEvent):void {
			view.addImage(event.vo);
		}
	}
}
