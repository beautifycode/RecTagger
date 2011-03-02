package com.beautifycode.rectagger.actors {
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Tobias Oberrauch <tob@derpunkt.de>
	 */

	public class Debug {

		
		public static function Dtrace(param:*):void {
			var pattern:RegExp = /at.*[^)](\/.*())/gim;
			try {
				throw new Error();
			}
			catch (e:Error) {
				var result:String = e.getStackTrace().match(pattern)[1];
				trace(param + " (was called from: " + result.replace(pattern, "$1") + ")");
			}
		}

		public static function alert(content:*):void {
			var _req:URLRequest = new URLRequest();
			_req.url = "javascript:alert('"+content+"')";
			navigateToURL(_req, "_self");
		}
		

		public static function dump(element:*):void {
			trace(_dump(element));
		}
		
		
		private static function _dump(element:*, depth:int = 1):String {
			var alert:String = "";
			for(var key:String in element) {
				if(element.numChildren > 0) {
					depth++;
					alert += _dump(element, depth) + "\n";
					depth--;
				} 
				else if(typeof element[key] == "object") {
					alert += _space(depth) + key + "\n";
					depth++;
					alert += _dump(element[key], depth) + "\n";
					depth--;
				} else {
					alert += _space(depth) + key + ": " + element[key] + "\n";
				}
			}
			return alert;
		}


		
		private static function _space(depth:int = 1):String {
			var space:String = '';
			for(var i:int = 1;i < depth;i++) {
				space += '  ';
			}
			return space;
		}
	}
}