package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.events.FileRefEvent;
	import com.beautifycode.rectagger.events.NavigationEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Marvin
	 */
	public class WorkspaceViewMediator extends Mediator {
		private var _friction : Number = .5;
		private var _vel : Number = 0;
		private var _prevVel : Number = 0;
		private var _prevY : Number = 0;
		private var _draggable : Boolean = true;
		private var _dragging : Boolean = false;

		private var _offset : int = 70;

		[Inject]
		public var view : WorkspaceView;

		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, FileRefEvent.GENERATE_THUMBNAILS, enableScrolling);
			eventMap.mapListener(eventDispatcher, NavigationEvent.SWITCH_TO_SCROLL, enableScrolling);
			eventMap.mapListener(eventDispatcher, NavigationEvent.SWITCH_TO_DRAW, disableScrolling);
		}


		private function disableScrolling(event : NavigationEvent) : void {
			view.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enableScrolling(event : Event) : void {
			view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function onMouseDown(event : MouseEvent) : void {
			if (_draggable) {
				_dragging = true;
				_prevY = view.y;
				view.startDrag(false, new Rectangle(0, view.stage.stageHeight - view.height, 0, (view.height - view.stage.stageHeight)+ _offset));
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
	}
}
