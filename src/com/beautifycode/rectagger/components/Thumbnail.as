package com.beautifycode.rectagger.components {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Marvin
	 */
	public class Thumbnail extends Sprite {
		public var id:int;
		private var _bm:Bitmap;
		private var _border:Sprite;
		private var _name : String;
		private var _tf : TextField;
		private var _format:TextFormat;
		private var _path:String;
		
		public function Thumbnail(bm:Bitmap, picName:String, picPath:String) {
			_bm = bm;
			_name = picName;
			_path = picPath;
			
			_border = new Sprite();
			_border.graphics.beginFill(0xFFFFFF);
			_border.graphics.drawRect(-2, -2, _bm.width+4, _bm.height+4);
			
			
			_format = new TextFormat();
			_format.color = 0xFFFFFF;
			
			_tf = new TextField();
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.setTextFormat(_format);
			_tf.text = _name;
			
//			addChild(_border);
			addChild(_bm);	
			addChild(_tf);
		}

		public function get path():String {
			return _path;
		}
	}
}
