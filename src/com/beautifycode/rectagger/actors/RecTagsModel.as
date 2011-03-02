package com.beautifycode.rectagger.actors {
	import com.beautifycode.rectagger.components.RecTag;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Marvin
	 */
	public class RecTagsModel extends Actor {
		public var rects : Object;
		public var currentRect : RecTag;
		public var currentRectCount : int;

		public function RecTagsModel() {
			rects = new Object();
		}

		public function createRecTag(x : int, y : int, w : int, h : int, page : int) : void {
			trace('page: ' + (page));
			if (!rects[page]) {
				rects[page] = new Array();
			}
			currentRect = new RecTag(x, y, w, h, page, rects[page].length);
			rects[page].push(currentRect);
			currentRectCount = rects[page].length;
		}

		public function storeMetaData(page : int, trigger : String, cnt : int) : void {
			trace("==== STORING META DATA ====");
			trace('cnt: ' + (cnt));
			trace('trigger: ' + (trigger));
			
			rects[page][cnt].trigger = trigger;

			trace("=== DEBUG ====");
			for (var p:String in rects) {
				trace(rects[p].length + " Hotspots on page " + p + ": ");
				for (var i : int = 0; i < rects[p].length; i++) {
					trace("Hotspot Nr. " + i);
					trace("x: " + rects[p][i].posX);
					trace("y: " + rects[p][i].posY);
					trace("w: " + rects[p][i].w);
					trace("h: " + rects[p][i].h);
					trace("page: " + rects[p][i].page);
					trace("trigger: " + rects[p][i].trigger);
				}
			}
		}

		public function editMetaData(page : int, recTagID : int, trigger : String) : void {
			rects[page][recTagID].trigger = trigger;
		}

		public function removeRecTag(page : int, cnt : int) : void {
			var tmpArr : Array = rects[page].slice();
			var tmp : Array = tmpArr.splice(cnt);
			tmp.shift();
			tmpArr = tmpArr.concat(tmp);

			rects[page] = tmpArr;

			for (var i : int = 0; i < rects[page].length; i++) {
				rects[page][i].cnt = i;
			}
		}
	}
}
