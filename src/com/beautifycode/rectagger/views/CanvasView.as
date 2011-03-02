package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.components.RecTag;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.ui.Mouse;

	/**
	 * @author Marvin
	 */
	public class CanvasView extends Sprite {
		private var _bg : Sprite;
		private var _rectCanvas : Sprite;
		private var _rectCanvasGraphics : Graphics;

		private var _metaDataView : MetaDataView;

		private var _recTagContainer : Sprite;

		public function CanvasView() {
		}

		public function initialize(width : int, height : int) : void {	

			_metaDataView = new MetaDataView();
			_metaDataView.hide();

			_recTagContainer = new Sprite();
			addChild(_recTagContainer);

			_bg = new Sprite();
			_bg.graphics.beginFill(0xFFFFFF, 0.5);
			_bg.graphics.drawRect(0, 0, width, height);
			_bg.graphics.endFill();
			_bg.visible = false;

			_rectCanvas = new Sprite();
			_rectCanvasGraphics = _rectCanvas.graphics;

			addChild(_rectCanvas);
			addChild(_bg);
			addChild(_metaDataView);
		}

		public function hideBackground() : void {
			_bg.visible = false;
		}

		public function showBackground() : void {
			_bg.visible = true;
		}

		public function get rectCanvasGraphics() : Graphics {
			return _rectCanvasGraphics;
		}

		public function get bg() : Sprite {
			return _bg;
		}

		public function clear() : void {
			if (_bg) removeChild(_bg);
			_bg = null;
			if (_rectCanvas) removeChild(_rectCanvas);
			_rectCanvas = null;
			if (_rectCanvasGraphics) _rectCanvasGraphics = null;
			if (_recTagContainer) {
				for (var i : int = _recTagContainer.numChildren - 1; i > -1; i--) {
					_recTagContainer.removeChildAt(i);
				}
			}
		}

		public function setRecTags(rects : Array) : void {
			for (var i : int; i < rects.length; i++) {
				var tmpRecTag : RecTag = rects[i];
				tmpRecTag.x = rects[i].posX;
				tmpRecTag.y = rects[i].posY;
				tmpRecTag.trigger = rects[i].trigger;

				_recTagContainer.addChild(tmpRecTag);
			}
		}

		public function showMetaDataInput(currentPage : int, cnt : int) : void {
			_metaDataView.switchToInputMode(currentPage, "p" + currentPage + "c" + cnt, cnt);
			_metaDataView.x = mouseX;
			_metaDataView.y = mouseY;
		}

		public function editMetaDataInput(page : int, trigger : String, cnt : int = 0) : void {
			_metaDataView.switchToEditMode(page, trigger, cnt);
			_metaDataView.x = mouseX;
			_metaDataView.y = mouseY;
		}

		public function deleteRecTags() : void {
			if (_recTagContainer) {
				for (var i : int = _recTagContainer.numChildren - 1; i > -1; i--) {
					_recTagContainer.removeChildAt(i);
				}
			}
		}
	}
}
