package com.beautifycode.rectagger.components {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Marvin
	 */
	public class Thumbnail extends Sprite {
		private var _id : int;
		private var _bm : Bitmap;
		private var _border : Sprite;
		private var _name : String;
		private var _path : String;
		private var _infos : ThumbnailInfos;
		private var _infoStr : String;

		public function Thumbnail(bm : Bitmap, picName : String, picPath : String, id : int) {
			_bm = bm;
			_name = picName;
			_id = id;

			if (_name.indexOf('/') > 0) {
				var tmpStrArr : Array = _name.split('/');
				_name = tmpStrArr[tmpStrArr.length - 1];
			}

			_path = picPath;

			_border = new Sprite();
			_border.graphics.beginFill(0xFFFFFF);
			_border.graphics.drawRect(-2, -2, _bm.width + 4, _bm.height + 4);

			_infoStr = new String();

			_infos = new ThumbnailInfos();
			_infos.filenameTF.text = _name;
			_infos.countTF.text = "";
			_infos.rectagsTF.text = "";
			_infos.x = -130;

			addChild(_infos);
			addChild(_bm);
		}

		public function get path() : String {
			return _path;
		}

		public function refreshInfos(rectagsObj : Object, currentPage : int) : void {
			if (_id == currentPage) {
				var infoStr : String = "";

				var rectagsArr:Array = rectagsObj[currentPage];
				_infos.countTF.text = rectagsArr.length + " RecTags are set.";

				for (var i : int; i < rectagsArr.length; i++) {
					infoStr += i + ": " + rectagsArr[i].trigger + "\n";
				}

				_infos.rectagsTF.text = infoStr;
			}
		}

		public function setInfos(cnt : int, trigger : String, totalCount : int) : void {
			_infos.countTF.text = totalCount + " RecTags are set.";

			_infoStr += cnt + ": " + trigger + "\n";

			_infos.rectagsTF.text = _infoStr;
		}

		public function get id() : int {
			return _id;
		}
	}
}
