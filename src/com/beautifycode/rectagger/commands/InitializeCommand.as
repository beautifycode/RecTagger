package com.beautifycode.rectagger.commands {
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class InitializeCommand extends Command {
		override public function execute():void {
			trace("startup");
		}
	}
}
