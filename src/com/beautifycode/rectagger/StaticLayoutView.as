package com.beautifycode.rectagger {
	import flash.display.Sprite;

	/**
	 * @author Blase
	 */
	public class StaticLayoutView extends Sprite {
		
		private var _topGradient:TopGradient; 
		
		public function StaticLayoutView() {
			_topGradient = new TopGradient();
			addChild(_topGradient);
		}
	}
}
