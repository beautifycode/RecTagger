package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.events.ThumbnailEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Marvin
	 */
	public class ImageViewMediator extends Mediator {
		[Inject]
		public var view:ImageView;

		[Inject]
		public var imagesmodel:ImagesModel;


		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, ThumbnailEvent.THUMBNAIL_CLICK, onImageChange, ThumbnailEvent);
		}

		private function onImageChange(event:ThumbnailEvent):void {
			view.removeCurrentImage();
			
			view.addImage(imagesmodel.images[event.vo]);
		}
	}
}
