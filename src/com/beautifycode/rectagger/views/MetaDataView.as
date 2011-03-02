package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.events.MetaDataEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Marvin
	 */
	public class MetaDataView extends Sprite {
		private var _viewAsset : MetaDataAsset;
		private var _cnt : int;
		private var _page : int;

		public function MetaDataView() {
			_viewAsset = new MetaDataAsset();
			addChild(_viewAsset);
		}

		public function switchToViewMode(trigger:String, page:String):void {
			this.visible = true;
			_viewAsset.gotoAndStop(1);
		}

		public function switchToInputMode(page:int, trigger:String="1", cnt:int=0):void {
			_cnt = cnt;
			_page = page;
			

			_viewAsset.gotoAndStop(2);
			_viewAsset.pageTF.text = page+"";
			_viewAsset.triggerTF.text = trigger;
			
			_viewAsset.saveBtn.addEventListener(MouseEvent.CLICK, onSaveClick);
			_viewAsset.cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClick);
			
			this.visible = true;
		}
		
		public function switchToEditMode(page : int, trigger : String, cnt : int) : void {
			_cnt = cnt;
			_page = page;
			

			_viewAsset.gotoAndStop(2);
			_viewAsset.pageTF.text = page+"";
			_viewAsset.triggerTF.text = trigger;
			
			_viewAsset.saveBtn.addEventListener(MouseEvent.CLICK, onSaveClick);
			_viewAsset.cancelBtn.removeEventListener(MouseEvent.CLICK, onCancelClick);
			_viewAsset.cancelBtn.addEventListener(MouseEvent.CLICK, onCancelEditClick);
			
			this.visible = true;
		}

		private function onCancelEditClick(event : MouseEvent) : void {
			this.visible = false;
			
			var _cancelEvent:MetaDataEvent = new MetaDataEvent(MetaDataEvent.CANCEL_EDIT, true, false);
			dispatchEvent(_cancelEvent);
		}

		private function onCancelClick(event:MouseEvent):void {
			this.visible = false;
			
			var _cancelEvent:MetaDataEvent = new MetaDataEvent(MetaDataEvent.CANCEL_CREATION, true, false);
			_cancelEvent.vo = new Object();
			_cancelEvent.vo.page = _page;
			_cancelEvent.vo.cnt = _cnt;
			dispatchEvent(_cancelEvent);
		}

		private function onSaveClick(event:MouseEvent):void {
			var _saveEvent:MetaDataEvent = new MetaDataEvent(MetaDataEvent.SAVE_DATA, true, false);
			_saveEvent.vo = new Object();
			_saveEvent.vo.page = _page;
			_saveEvent.vo.cnt = _cnt;
			_saveEvent.vo.trigger = _viewAsset.triggerTF.text;
			dispatchEvent(_saveEvent);
			
			this.visible = false;
		}

		public function hide():void {
			this.visible = false;
		}

		
	}
}
