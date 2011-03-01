package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.events.NavigationEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;

	/**
	 * @author Marvin
	 */
	public class NavigationViewMediator extends Mediator {
		[Inject]
		public var view:NavigationView;
		private var _e:NavigationEvent;

		override public function onRegister():void {
			view.navBar.loadBtn.addEventListener(MouseEvent.CLICK, browseFiles);
			view.navBar.drawBtn.addEventListener(MouseEvent.CLICK, switchToDraw);
			view.navBar.selectBtn.addEventListener(MouseEvent.CLICK, switchToScroll);
			view.navBar.saveBtn.addEventListener(MouseEvent.CLICK, saveCurrentBtn);
			view.navBar.generateBtn.addEventListener(MouseEvent.CLICK, generateCode);
		}

		private function generateCode(event : MouseEvent) : void {
			
		}

		private function saveCurrentBtn(event:MouseEvent):void {
			_e = new NavigationEvent(NavigationEvent.SAVE_COORDS);
			dispatch(_e);
		}

		private function switchToScroll(event:MouseEvent):void {
			_e = new NavigationEvent(NavigationEvent.SWITCH_TO_SCROLL);
			dispatch(_e);
		}

		private function switchToDraw(event:MouseEvent):void {
			trace("HI");
			_e = new NavigationEvent(NavigationEvent.SWITCH_TO_DRAW);
			dispatch(_e);
		}

		private function browseFiles(event:MouseEvent):void {
			_e = new NavigationEvent(NavigationEvent.BROWSE_FILES);
			dispatch(_e);
		}
	}
}
