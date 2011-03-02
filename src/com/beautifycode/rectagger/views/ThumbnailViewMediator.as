package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.components.Thumbnail;
	import com.beautifycode.rectagger.events.FileRefEvent;
	import com.beautifycode.rectagger.events.ThumbnailEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Marvin
	 */
	public class ThumbnailViewMediator extends Mediator {
		[Inject]
		public var view : ThumbnailView;

		private var _lY : int;
		private var _spacerY : int = 10;
		private var _e : ThumbnailEvent;

		private var _friction : Number = .5;
		private var _vel : Number = 0;
		private var _prevVel : Number = 0;
		private var _prevY : Number = 0;
		private var _draggable : Boolean = true;
		private var _dragging : Boolean = false;
		
		private var _offset:int = 70;

		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, FileRefEvent.GENERATE_THUMBNAILS, generateThumbnails);
			eventMap.mapListener(view, MouseEvent.MOUSE_DOWN, onMouseDown);
			eventMap.mapListener(view, MouseEvent.MOUSE_UP, onMouseUp);
			eventMap.mapListener(view, MouseEvent.CLICK, onClick);
			eventMap.mapListener(view, Event.ENTER_FRAME, enterFrameHandler);
		}

		private function onResize(event : Event) : void {
			
		}

		private function onClick(event : MouseEvent) : void {
			
		}

		private function onMouseDown(event : MouseEvent) : void {
			if (_draggable) {
				_dragging = true;
				_prevY = view.y;
				view.startDrag(false, new Rectangle(view.x, (view.stage.stageHeight - view.height), 0, (view.height - view.stage.stageHeight)+_offset));
			}
		}

		private function enterFrameHandler(event : Event) : void {
			if (_dragging) {
				_prevVel = _vel;
				_vel = (view.y - _prevY) / 3;
				_prevY = view.y;
			} else {
				_prevVel = _vel;

				if (_vel > 0) {
					_vel -= _friction;
					_vel = Math.max(0, _vel);
				} else if (_vel < 0) {
					_vel += _friction;
					_vel = Math.min(_vel, 0);
				}

				view.y += _vel;
				view.y = Math.min(view.y, _offset);
				view.y = Math.max(view.stage.stageHeight - view.height, view.y);
			}
		}

		private function onMouseUp(event : Event) : void {
			_dragging = false;
			view.stopDrag();
		}

		private function generateThumbnails(event : FileRefEvent) : void {
			for (var i : int; i < event.vo.length; i++) {
				var tmpThumbnail : Thumbnail = event.vo[i];
				tmpThumbnail.y = _lY;
				tmpThumbnail.doubleClickEnabled = true;
				tmpThumbnail.addEventListener(MouseEvent.DOUBLE_CLICK, onThumbnailClick);

				view.addThumbnail(tmpThumbnail);
				_lY += tmpThumbnail.height + _spacerY;
			}
		}

		private function onThumbnailClick(event : MouseEvent) : void {
			_e = new ThumbnailEvent(ThumbnailEvent.THUMBNAIL_CLICK, true, false);
			_e.vo = event.target.id;
			dispatch(_e);
		}
	}
}
