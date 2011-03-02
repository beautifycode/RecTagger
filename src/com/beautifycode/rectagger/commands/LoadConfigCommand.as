package com.beautifycode.rectagger.commands {
	import com.adobe.serialization.json.JSON;
	import com.beautifycode.rectagger.actors.FileRefService;
	import com.beautifycode.rectagger.actors.RecTagsModel;

	import org.robotlegs.mvcs.Command;

	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	/**
	 * @author Marvin
	 */
	public class LoadConfigCommand extends Command {
		private var loadFileReference:FileReference;
		private var loadedFileBA:ByteArray;
		private var loadedFileString:String;
		private var loadedFileObject:Object;
		[Inject]
		public var filerefservice:FileRefService;
		[Inject]
		public var rectagsmodel:RecTagsModel;

		override public function execute():void {
			loadFileReference = new FileReference();
			loadFileReference.addEventListener(Event.SELECT, onFileSelected);

			var swfTypeFilter:FileFilter = new FileFilter("RecTagger Config", "*.cfg");
			var allTypeFilter:FileFilter = new FileFilter("All Files (*.*)", "*.*");
			loadFileReference.browse([swfTypeFilter, allTypeFilter]);
		}

		private function onFileSelected(event:Event):void {
			loadFileReference.addEventListener(Event.COMPLETE, onFileLoaded);
			loadFileReference.load();
		}

		private function onFileLoaded(event:Event):void {
			loadFileReference = event.target as FileReference;

			loadedFileBA = loadFileReference["data"];
			loadedFileString = loadedFileBA.toString();

			loadedFileObject = JSON.decode(loadedFileString);

			loadFileReference.removeEventListener(Event.COMPLETE, onFileLoaded);

			refreshComponents();
		}

		private function refreshComponents():void {
			filerefservice.loadImagesFromConfig(loadedFileObject["imagepaths"]);

			for (var p:String in loadedFileObject["rectags"]) {
				for (var i:int = 0; i < loadedFileObject["rectags"][p].count; i++) {
					rectagsmodel.createRecTag(loadedFileObject["rectags"][p][i].posX, loadedFileObject["rectags"][p][i].posY, loadedFileObject["rectags"][p][i].w, loadedFileObject["rectags"][p][i].h, loadedFileObject["rectags"][p][i].page);
					rectagsmodel.editMetaData(loadedFileObject["rectags"][p][i].page, i, loadedFileObject["rectags"][p][i].trigger);
				}
			}
		}
	}
}
