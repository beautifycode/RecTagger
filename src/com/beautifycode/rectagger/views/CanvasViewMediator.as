package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.events.CanvasEvent;
	import com.beautifycode.rectagger.events.FileRefEvent;
	import com.beautifycode.rectagger.events.NavigationEvent;
	import com.beautifycode.rectagger.events.ThumbnailEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author Marvin
	 */
	public class CanvasViewMediator extends Mediator {
		[Inject]
		public var view:CanvasView;
		
		[Inject]
		public var imagesmodel:ImagesModel;
		
		private var _dragging:Boolean;
		private var _corner:Point;
		private var _e:CanvasEvent;

		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, FileRefEvent.GENERATE_THUMBNAILS, onAllImagesLoaded);
			eventMap.mapListener(eventDispatcher, NavigationEvent.SWITCH_TO_SCROLL, hideCanvasBackground);
			eventMap.mapListener(eventDispatcher, NavigationEvent.SWITCH_TO_DRAW, showCanvasBackground);
			eventMap.mapListener(eventDispatcher, ThumbnailEvent.THUMBNAIL_CLICK, onImageChange, ThumbnailEvent);
		}

		private function onImageChange(event:ThumbnailEvent):void {
			view.clear();
			view.initialize(imagesmodel.images[event.vo].width, imagesmodel.images[event.vo].height);
			view.bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.bg.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function showCanvasBackground(event:NavigationEvent):void {
			view.showBackground();
		}

		private function hideCanvasBackground(event:NavigationEvent):void {
			view.hideBackground();
		}

		private function onAllImagesLoaded(event:FileRefEvent):void {
			
		}

		private function onMouseDown(event:MouseEvent):void {
			if (!_dragging) {
				view.rectCanvasGraphics.clear();
				_corner = new Point(event.target.mouseX, event.target.mouseY);
				_dragging = true;
				view.bg.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			}
		}

		private function onMove(event:MouseEvent):void {
			view.rectCanvasGraphics.clear();
			view.rectCanvasGraphics.lineStyle(1, 0xFFFFFF, .5);
			view.rectCanvasGraphics.beginFill(0xFF00FF, .3);
			view.rectCanvasGraphics.drawRect(_corner.x, _corner.y, event.target.mouseX - _corner.x, event.target.mouseY - _corner.y);
		}

		private function onMouseUp(event:MouseEvent):void {
			if (_dragging) {
				_dragging = false;
				view.bg.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
				view.rectCanvasGraphics.lineStyle(1, 0xFFFFFF, .5);
				view.rectCanvasGraphics.beginFill(0xFF00FF, .3);
				view.rectCanvasGraphics.drawRect(_corner.x, _corner.y, event.target.mouseX - _corner.x, event.target.mouseY - _corner.y);
			}
			
			_e = new CanvasEvent(CanvasEvent.STORE_CURRENT_RECT, true, false);
			_e.vo = new Object();
			_e.vo.x = int(_corner.x);
			_e.vo.y = int(_corner.y);
			_e.vo.w = int(event.target.mouseX - _corner.x);
			_e.vo.h = int(event.target.mouseY - _corner.y);
			dispatch(_e);
		}
	}
}
