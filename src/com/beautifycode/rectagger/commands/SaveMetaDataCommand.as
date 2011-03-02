package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.events.MetaDataEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class SaveMetaDataCommand extends Command {
		[Inject]
		public var metadataevent:MetaDataEvent;
		
		[Inject]
		public var rectagsmodel:RecTagsModel;
		
		override public function execute():void {
			rectagsmodel.storeMetaData(metadataevent.vo.page, metadataevent.vo.trigger, metadataevent.vo.cnt);
		}
	}
}
