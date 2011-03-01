package com.beautifycode.rectagger.views {
	import flash.display.Sprite;

	/**
	 * @author Marvin
	 */
	public class NavigationView extends Sprite {
		private var _navBar : NavBar;
		
		public function NavigationView() {
			draw();
		}

		private function draw():void {
			_navBar = new NavBar();
			addChild(_navBar);
		}

		public function get navBar() : NavBar {
			return _navBar;
		}

		public function set navBar(navBar : NavBar) : void {
			_navBar = navBar;
		}
	}
}
