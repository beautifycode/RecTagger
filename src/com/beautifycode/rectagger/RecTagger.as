package com.beautifycode.rectagger {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	/**
	 * @author Marvin
	 */
	[SWF(backgroundColor="#343434", frameRate="35", width="1280", height="600")]
	public class RecTagger extends Sprite {
		private var _context:RecTaggerContext;

		public function RecTagger() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_context = new RecTaggerContext(this);
		}
	}
}
