package com.beautifycode.rectagger.actors {
	import com.beautifycode.rectagger.events.FileRefEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author Marvin
	 */
	public class ImagesModel extends Actor {
		private static const _MAX_WIDTH : Number = 500;
		private static const _MAX_HEIGHT : Number = 600;
		private var _bitmap : Bitmap;
		private var _e : FileRefEvent;
		private var _images : Array;
		private var _bmOldWidth : Number;
		private var _resizeRatio : Number;

		public function ImagesModel() {
			super();
		}

		public function initialize() : void {
			_images = new Array();
		}

		public function storeImage(bmData : BitmapData) : void {
			_bitmap = new Bitmap();
			_bitmap.bitmapData = bmData;
			_bitmap.smoothing = true;
			_bitmap.x = 0;
			_bitmap.y = 0;

			_bmOldWidth = _bitmap.width;

			if ( _bitmap.width > _MAX_WIDTH || _bitmap.height < _MAX_HEIGHT ) {
				// resizeBitmap(_bitmap);
				_bitmap.width = 900;
				_bitmap.scaleY = _bitmap.scaleX;
			}
			
			_resizeRatio = _bmOldWidth / _bitmap.width;
			trace('_resizeRatio: ' + (_resizeRatio));

			_images.push(_bitmap);
		}

		private function resizeBitmap(target : Bitmap) : void {
			if ( target.height < target.width ) {
				target.width = _MAX_WIDTH;
				target.scaleY = target.scaleX;
			} else if ( target.width < target.height ) {
				target.height = _MAX_HEIGHT;
				target.scaleX = target.scaleY;
			}
		}

		public function get images() : Array {
			return _images;
		}

		public function get resizeRatio() : Number {
			return _resizeRatio;
		}
	}
}
