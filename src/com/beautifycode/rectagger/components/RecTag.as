package com.beautifycode.rectagger.components {
	import com.beautifycode.rectagger.events.RecTagEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Marvin
	 */
	public class RecTag extends Sprite {
		private var _fill : Sprite;
		private var _x : int;
		private var _y : int;
		private var _w : int;
		private var _h : int;
		private var _page : int;
		private var _trigger : String;
		private var _cnt : int;
		private var _deleteBtn : RecTagBarDeleteBtn;
		private var _editBtn : RecTagBarEditBtn;
		private var _titleTF : RecTagBarTitle;

		private var _e : RecTagEvent;

		public function RecTag(x : int, y : int, w : int, h : int, page : int, cnt : int) {
			_trigger = trigger;
			_page = page;
			_h = h;
			_w = w;
			_y = y;
			_x = x;
			_cnt = cnt;

			_fill = new Sprite();
			_fill.graphics.lineStyle(1, 0xFFFFFF, .5);
			_fill.graphics.beginFill(0xFF00FF, .3);
			_fill.graphics.drawRect(0, 0, _w, _h);
			addChild(_fill);

			_deleteBtn = new RecTagBarDeleteBtn();
			_editBtn = new RecTagBarEditBtn();
			_titleTF = new RecTagBarTitle();

			_deleteBtn.x = _w - (_deleteBtn.width + 1);
			_deleteBtn.y = 1;
			_deleteBtn.addEventListener(MouseEvent.CLICK, onDelete);
			_editBtn.x = _deleteBtn.x - (_editBtn.width + 1);
			_editBtn.y = 1;
			_editBtn.addEventListener(MouseEvent.CLICK, onEdit);
			_titleTF.x = 1;
			_titleTF.y = _h - (_titleTF.height - 1);

			addChild(_titleTF);
			addChild(_deleteBtn);
			addChild(_editBtn);
		}

		private function onEdit(event : MouseEvent) : void {
			_e = new RecTagEvent(RecTagEvent.EDIT_RECTAG, true, false);
			_e.vo = new Object();
			_e.vo.trigger = _trigger;
			_e.vo.page = _page;
			_e.vo.cnt = _cnt;
			dispatchEvent(_e);
		}

		private function onDelete(event : MouseEvent) : void {
			_e = new RecTagEvent(RecTagEvent.DELETE_RECTAG, true, false);
			_e.vo = new Object();
			_e.vo.cnt = _cnt;
			_e.vo.page = _page;
			dispatchEvent(_e);
		}

		public function get posX() : int {
			return _x;
		}

		public function get posY() : int {
			return _y;
		}

		public function get w() : int {
			return _w;
		}

		public function get h() : int {
			return _h;
		}

		public function get page() : int {
			return _page;
		}

		public function get trigger() : String {
			return _trigger;
		}

		public function set trigger(trigger : String) : void {
			_trigger = trigger;
			_titleTF.content.text = _trigger;
		}

		public function get cnt() : int {
			return _cnt;
		}

		public function set cnt(cnt : int) : void {
			_cnt = cnt;
		}
	}
}
