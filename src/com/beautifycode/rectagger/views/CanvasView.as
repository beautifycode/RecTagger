package com.beautifycode.rectagger.views {
	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author Marvin
	 */
	public class CanvasView extends Sprite {
		private var _bg:Sprite;
		private var _rectCanvas:Sprite;
		private var _rectCanvasGraphics:Graphics;

		public function CanvasView() {
		}

		public function initialize(width:int, height:int):void {
			_bg = new Sprite();
			_bg.graphics.beginFill(0xFFFFFF, 0.5);
			_bg.graphics.drawRect(0, 0, width, height);
			_bg.graphics.endFill();
			_bg.visible = false;

			_rectCanvas = new Sprite();
			_rectCanvasGraphics = _rectCanvas.graphics;

			addChild(_rectCanvas);
			addChild(_bg);
		}

		public function hideBackground():void {
			_bg.visible = false;
		}

		public function showBackground():void {
			_bg.visible = true;
		}

		public function get rectCanvasGraphics():Graphics {
			return _rectCanvasGraphics;
		}

		public function get bg():Sprite {
			return _bg;
		}

		public function clear():void {
			if (_bg) removeChild(_bg); _bg = null;
			if (_rectCanvas) removeChild(_rectCanvas); _rectCanvas = null;
			if (_rectCanvasGraphics) _rectCanvasGraphics = null;
		}
	}
}
