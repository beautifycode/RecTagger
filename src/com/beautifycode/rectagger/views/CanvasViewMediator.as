package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.events.FileRefEvent;
	import com.beautifycode.rectagger.events.MetaDataEvent;
	import com.beautifycode.rectagger.events.NavigationEvent;
	import com.beautifycode.rectagger.events.RecTagEvent;
	import com.beautifycode.rectagger.events.ThumbnailEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author Marvin
	 */
	public class CanvasViewMediator extends Mediator {
		[Inject]
		public var view : CanvasView;
		[Inject]
		public var imagesmodel : ImagesModel;
		[Inject]
		public var canvasmodel : CanvasModel;
		[Inject]
		public var rectagsmodel : RecTagsModel;
		private var _currentPage : int;
		private var _dragging : Boolean;
		private var _corner : Point;
		private var _re : RecTagEvent;
		private var _e : NavigationEvent;

		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, FileRefEvent.GENERATE_THUMBNAILS, onAllImagesLoaded);
			eventMap.mapListener(eventDispatcher, NavigationEvent.SWITCH_TO_SCROLL, hideCanvasBackground);
			eventMap.mapListener(eventDispatcher, NavigationEvent.SWITCH_TO_DRAW, showCanvasBackground);
			eventMap.mapListener(eventDispatcher, ThumbnailEvent.THUMBNAIL_CLICK, onImageChange, ThumbnailEvent);
			eventMap.mapListener(eventDispatcher, MetaDataEvent.SAVE_DATA, refreshCanvas);
			eventMap.mapListener(eventDispatcher, RecTagEvent.EDIT_RECTAG, editRecTag);
			eventMap.mapListener(eventDispatcher, RecTagEvent.RECTAG_DELETED, deleteRecTag);
		}

		private function deleteRecTag(event : RecTagEvent) : void {
			view.deleteRecTags();
			view.rectCanvasGraphics.clear();
			view.setRecTags(rectagsmodel.rects[_currentPage]);
			view.bg.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function editRecTag(event : RecTagEvent) : void {
			var page : int = event.vo.page;
			var cnt : int = event.vo.cnt;
			var trigger : String = event.vo.trigger;

			view.editwMetaDataInput(page, trigger, cnt);
		}

		private function clearLastRecTag() : void {
			view.deleteRecTags();
			view.rectCanvasGraphics.clear();
			view.setRecTags(rectagsmodel.rects[_currentPage]);
			view.bg.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function refreshCanvas(event : MetaDataEvent) : void {
			view.rectCanvasGraphics.clear();
			_e = new NavigationEvent(NavigationEvent.SWITCH_TO_SCROLL, true, false);
			dispatch(_e);
			view.setRecTags(rectagsmodel.rects[_currentPage]);
		}

		private function onImageChange(event : ThumbnailEvent) : void {
			_currentPage = event.vo;
			canvasmodel.currentPage = _currentPage;
			if(rectagsmodel.rects[_currentPage]) rectagsmodel.currentRectCount = rectagsmodel.rects[_currentPage].length;

			view.clear();
			view.initialize(imagesmodel.images[event.vo].width, imagesmodel.images[event.vo].height);

			view.bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.bg.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

			if (rectagsmodel.rects[_currentPage]) view.setRecTags(rectagsmodel.rects[_currentPage]);
		}

		private function showCanvasBackground(event : NavigationEvent) : void {
			view.bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.bg.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.showBackground();
		}

		private function hideCanvasBackground(event : NavigationEvent) : void {
			view.hideBackground();
		}

		private function onAllImagesLoaded(event : FileRefEvent) : void {
		}

		private function onMouseDown(event : MouseEvent) : void {
			if (!_dragging) {
				view.rectCanvasGraphics.clear();
				_corner = new Point(event.target.mouseX, event.target.mouseY);
				_dragging = true;
				view.bg.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			}
		}

		private function onMove(event : MouseEvent) : void {
			view.rectCanvasGraphics.clear();
			view.rectCanvasGraphics.lineStyle(1, 0xFFFFFF, .5);
			view.rectCanvasGraphics.beginFill(0xFF00FF, .3);
			view.rectCanvasGraphics.drawRect(_corner.x, _corner.y, event.target.mouseX - _corner.x, event.target.mouseY - _corner.y);
		}

		private function onMouseUp(event : MouseEvent) : void {
			if (_dragging) {
				_dragging = false;
				view.bg.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			}

			view.bg.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.bg.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			canvasmodel.currentPage = _currentPage;

			_re = new RecTagEvent(RecTagEvent.CREATE_RECTAG, true, false);
			_re.vo = new Object();
			_re.vo.x = int(_corner.x);
			_re.vo.y = int(_corner.y);
			_re.vo.w = int(event.target.mouseX - _corner.x);
			_re.vo.h = int(event.target.mouseY - _corner.y);
			_re.vo.page = _currentPage;
			dispatch(_re);

			view.showMetaDataInput(_currentPage, rectagsmodel.currentRectCount-1);
		}
	}
}
