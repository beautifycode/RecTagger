package com.beautifycode.rectagger.commands {
	import com.beautifycode.rectagger.actors.ButtonsModel;
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.events.NavigationEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class SaveCurrentButtonCommand extends Command {
		[Inject]
		public var buttonsModel:ButtonsModel;

		[Inject]
		public var canvasmodel:CanvasModel;
		
		[Inject]
		public var navigationevent:NavigationEvent;
			
		//tooltipmodel => trigger
		//interfacemodel => page nach savebtn eintragen
				
		override public function execute():void {
			// get current data to provide the new button as coords
//			var page:int = 1;
//			var x:int = canvasmodel.x;
//			var y:int = canvasmodel.y;
//			var w:int = canvasmodel.w;
//			var h:int = canvasmodel.h;
//			var trigger:String = "";
//			
//			buttonsModel.saveNewButton(page, x, y, w, h, trigger);
		}
	}
}
