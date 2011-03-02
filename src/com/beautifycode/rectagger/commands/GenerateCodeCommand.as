package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.actors.RecTagsModel;

	import org.robotlegs.mvcs.Command;

	import flash.net.FileReference;

	/**
	 * @author Blase
	 */
	public class GenerateCodeCommand extends Command {
		[Inject]
		public var imagesmodel : ImagesModel;

		[Inject]
		public var rectagsmodel : RecTagsModel;
		private var _codeStr : String;
		private var _saveConfigReference : FileReference;
		private var _totalCount : int;


		override public function execute() : void {
			_codeStr = new String();
			_totalCount = 0;
			

			for (var p:String in rectagsmodel.rects) {
				for (var i : int = 0; i < rectagsmodel.rects[p].length; i++) {
					var x : int = rectagsmodel.rects[p][i].posX * imagesmodel.resizeRatio;
					var y : int = rectagsmodel.rects[p][i].posY * imagesmodel.resizeRatio;
					var w : int = rectagsmodel.rects[p][i].w * imagesmodel.resizeRatio;
					var h : int = rectagsmodel.rects[p][i].h * imagesmodel.resizeRatio;
					var trigger : String = rectagsmodel.rects[p][i].trigger;
					_codeStr += 'linkContainer.attachMovie("linkMC", "link' + _totalCount + '",' + _totalCount + ',{_x:' + x + ' ,_y:' + y + ' ,_width:' + w + ' ,_height:' + h + ' ,url:"' + trigger + '"});\n';
					
					_totalCount++;
				}
			}

			_codeStr += "\r";
			_codeStr += "\r";

			for (p in rectagsmodel.rects) {
				_codeStr += 'links[' + p + '] = new Array();\n';
			}

			_codeStr += "\r";
			_codeStr += "\r";

			_totalCount = 0;

			for (p in rectagsmodel.rects) {
				for (i = 0; i < rectagsmodel.rects[p].length; i++) {
					_codeStr += 'links['+p+']['+i+'] = linkContainer.link'+_totalCount+'\n';
					_totalCount++;
				}
			}

			_saveConfigReference = new FileReference();
			_saveConfigReference.save(_codeStr, "generatedCode.rtf");

		}
	}
}
