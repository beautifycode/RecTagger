package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.actors.ThumbnailsModel;
	import com.beautifycode.rectagger.events.FileRefEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class RefreshDataFromConfigCommand extends Command {
		[Inject]
		public var rectagsmodel : RecTagsModel;

		[Inject]
		public var thumbnailsmodel : ThumbnailsModel;

		[Inject]
		public var event : FileRefEvent;

		private var _loadedFileObject : Object;


		override public function execute() : void {
			var totalCount : int;
			_loadedFileObject = event.vo;

			for (var p:String in _loadedFileObject["rectags"]) {
				if (_loadedFileObject["rectags"][p]) {
					for (var i : int = 0; i < _loadedFileObject["rectags"][p].count; i++) {
						rectagsmodel.createRecTag(_loadedFileObject["rectags"][p][i].posX, _loadedFileObject["rectags"][p][i].posY, _loadedFileObject["rectags"][p][i].w, _loadedFileObject["rectags"][p][i].h, _loadedFileObject["rectags"][p][i].page);
						rectagsmodel.editMetaData(_loadedFileObject["rectags"][p][i].page, i, _loadedFileObject["rectags"][p][i].trigger);
						thumbnailsmodel.createInfos(p, i, _loadedFileObject["rectags"][p].count, _loadedFileObject["rectags"][p][i].trigger);
						totalCount++;
					}
				}
			}
		}
	}
}
