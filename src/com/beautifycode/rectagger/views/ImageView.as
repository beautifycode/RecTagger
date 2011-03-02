package com.beautifycode.rectagger.views {
	import com.beautifycode.rectagger.components.RecTag;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author Marvin
	 */
	public class ImageView extends Sprite {
		public var clipContainer:Sprite;
		
		public function ImageView() {
			clipContainer = new Sprite();
			addChild(clipContainer);
					}

		public function addImage(vo:Bitmap):void {
			clipContainer.addChild(vo);
		}

		public function removeCurrentImage():void {
			if(clipContainer.numChildren > 0) clipContainer.removeChildAt(0);
		}
	}
}
