package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.events.MetaDataEvent;
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.actors.ThumbnailsModel;
	import com.beautifycode.rectagger.events.RecTagEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class DeleteLastRectCommand extends Command {

		[Inject]
		public var rectagsmodel : RecTagsModel;

		[Inject]
		public var thumbnailsmodel : ThumbnailsModel;

		[Inject]
		public var event : MetaDataEvent;

		override public function execute() : void {
			trace('event.vo.cnt: ' + (event.vo.cnt));
			trace('event.vo.page: ' + (event.vo.page));
			rectagsmodel.removeRecTag(event.vo.page, event.vo.cnt);

			var _e : RecTagEvent = new RecTagEvent(RecTagEvent.RECTAG_DELETED, true, false);
			_e.vo = new Object();
			_e.vo.page = event.vo.page;
			_e.vo.cnt = event.vo.cnt;
			dispatch(_e);
		}
	}
}
