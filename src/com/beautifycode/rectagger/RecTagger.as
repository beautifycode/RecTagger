package com.beautifycode.rectagger {
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;

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
