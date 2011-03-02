package com.beautifycode.rectagger.commands {
	import com.adobe.serialization.json.JSON;
	import com.beautifycode.rectagger.actors.Debug;
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.actors.ThumbnailsModel;

	import org.robotlegs.mvcs.Command;

	import flash.net.FileReference;

	/**
	 * @author Marvin
	 */
	public class SaveConfigCommand extends Command {
		private var _configObj:Object;
		private var _saveFileString:String;
		private var _saveFileReference:FileReference;
		[Inject]
		public var thumbnailsmodel:ThumbnailsModel;
		[Inject]
		public var rectagsmodel:RecTagsModel;

		override public function execute():void {
			_configObj = new Object();
			_configObj["imagepaths"] = new Array();
			_configObj["rectags"] = new Array();

			for (var i:int; i < thumbnailsmodel.thumbnails.length; i++) {
				_configObj["imagepaths"][i] = thumbnailsmodel.thumbnails[i].path;
			}

			for (var page:String in rectagsmodel.rects) {
				_configObj["rectags"][page] = new Object();
				_configObj["rectags"][page].count = rectagsmodel.rects[page].length;
				for (var j:int = 0; j < rectagsmodel.rects[page].length; j++) {
					_configObj["rectags"][page][j] = new Object();
					_configObj["rectags"][page][j].posX = rectagsmodel.rects[page][j].posX;
					_configObj["rectags"][page][j].posY = rectagsmodel.rects[page][j].posY;
					_configObj["rectags"][page][j].w = rectagsmodel.rects[page][j].w;
					_configObj["rectags"][page][j].h = rectagsmodel.rects[page][j].h;
					_configObj["rectags"][page][j].trigger = rectagsmodel.rects[page][j].trigger;
					_configObj["rectags"][page][j].page = page;
				}
			}

			_saveFileString = JSON.encode(_configObj);

			_saveFileReference = new FileReference();
			_saveFileReference.save(_saveFileString, "recTagger.cfg");
		}
	}
}
