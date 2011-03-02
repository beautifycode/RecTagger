package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.events.RecTagEvent;
	import org.robotlegs.mvcs.Command;


	/**
	 * @author Marvin
	 */
	public class CreateNewRecTagCommand extends Command {
		[Inject]
		public var rectagevent:RecTagEvent;

		[Inject]
		public var rectagsmodel:RecTagsModel;
		
		
		override public function execute():void {
			rectagsmodel.createRecTag(rectagevent.vo.x, rectagevent.vo.y, rectagevent.vo.w, rectagevent.vo.h, rectagevent.vo.page);
		}
	}
}
