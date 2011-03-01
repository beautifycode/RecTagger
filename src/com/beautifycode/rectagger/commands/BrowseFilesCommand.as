package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.FileRefService;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class BrowseFilesCommand extends Command {
		[Inject]
		public var filerefservice:FileRefService;
			
		override public function execute():void {
			filerefservice.browseMultipleFiles();
//			filerefservice.browseSingleFile();
		}
	}
}
