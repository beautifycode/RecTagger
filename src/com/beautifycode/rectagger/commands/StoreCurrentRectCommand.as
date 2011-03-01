package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.events.CanvasEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class StoreCurrentRectCommand extends Command {
		[Inject]
		public var canvasmodel:CanvasModel;
		
		[Inject]
		public var canvasevent:CanvasEvent;
		
		override public function execute():void {
			trace("Storing: ");
			trace("x: " + canvasevent.vo.x);
			trace("y: " + canvasevent.vo.y);
			trace("w: " + canvasevent.vo.w);
			trace("h: " + canvasevent.vo.h);
			trace("=======");
			
			canvasmodel.store(canvasevent.vo.x, canvasevent.vo.y, canvasevent.vo.w, canvasevent.vo.h);
		}
	}
}
