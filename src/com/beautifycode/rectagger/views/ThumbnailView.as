package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.components.Thumbnail;

	import flash.display.Sprite;

	/**
	 * @author Marvin
	 */
	public class ThumbnailView extends Sprite {
		public function ThumbnailView() {
		}

		public function addThumbnail(tmpThumbnail:Thumbnail):void {
			addChild(tmpThumbnail);
		}
	}
}
