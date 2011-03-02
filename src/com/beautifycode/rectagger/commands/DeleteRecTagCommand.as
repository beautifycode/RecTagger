package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.events.RecTagEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class DeleteRecTagCommand extends Command {
		[Inject]
		public var rectagsmodel : RecTagsModel;

		[Inject]
		public var event : RecTagEvent;

		override public function execute() : void {
			rectagsmodel.removeRecTag(event.vo.page, event.vo.cnt);
			
			var _e:RecTagEvent = new RecTagEvent(RecTagEvent.RECTAG_DELETED, true, false);
			dispatch(_e);
		}
	}
}
