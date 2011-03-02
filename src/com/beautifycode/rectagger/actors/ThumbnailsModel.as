package com.beautifycode.rectagger.actors {
	import com.beautifycode.rectagger.components.Thumbnail;
	import com.beautifycode.rectagger.events.FileRefEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author Marvin
	 */
	public class ThumbnailsModel extends Actor {
		private var _thumbnails:Array;
		private var _bitmap:Bitmap;
		private var _e:FileRefEvent;
		private var _tmpThumbnail:Thumbnail;
		

		public function initialize():void {
			_thumbnails = new Array();
		}

		public function createThumbnail(bmData:BitmapData, picName:String, picPath:String):void {
			_bitmap = new Bitmap();			
			_bitmap.bitmapData = bmData;
			_bitmap.width = 120;
			_bitmap.scaleY = _bitmap.scaleX;
			_bitmap.smoothing = true;
			_bitmap.x = 0;
			_bitmap.y = 0;
			
			_tmpThumbnail = new Thumbnail(_bitmap, picName, picPath, _thumbnails.length);
			_thumbnails.push(_tmpThumbnail);
		}

		public function generateThumbnails():void {
			_e = new FileRefEvent(FileRefEvent.GENERATE_THUMBNAILS, true, false);
			_e.vo = _thumbnails;
			dispatch(_e);
		}

		public function get thumbnails():Array {
			return _thumbnails;
		}

		public function createInfos(totalCount:String, cnt:int, rectagsCount:int, trigger:String) : void {
			_thumbnails[totalCount].setInfos(cnt, trigger, rectagsCount);
		}

	}
}
