package com.beautifycode.rectagger {
	import com.beautifycode.rectagger.actors.ButtonsModel;
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.actors.FileRefService;
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.actors.ThumbnailsModel;
	import com.beautifycode.rectagger.commands.BrowseFilesCommand;
	import com.beautifycode.rectagger.commands.InitializeCommand;
	import com.beautifycode.rectagger.commands.SaveCurrentButtonCommand;
	import com.beautifycode.rectagger.commands.StoreCurrentRectCommand;
	import com.beautifycode.rectagger.events.CanvasEvent;
	import com.beautifycode.rectagger.events.NavigationEvent;
	import com.beautifycode.rectagger.views.ApplicationView;
	import com.beautifycode.rectagger.views.ApplicationViewMediator;
	import com.beautifycode.rectagger.views.CanvasView;
	import com.beautifycode.rectagger.views.CanvasViewMediator;
	import com.beautifycode.rectagger.views.ImageView;
	import com.beautifycode.rectagger.views.ImageViewMediator;
	import com.beautifycode.rectagger.views.NavigationView;
	import com.beautifycode.rectagger.views.NavigationViewMediator;
	import com.beautifycode.rectagger.views.ThumbnailView;
	import com.beautifycode.rectagger.views.ThumbnailViewMediator;
	import com.beautifycode.rectagger.views.WorkspaceView;
	import com.beautifycode.rectagger.views.WorkspaceViewMediator;

	import flash.display.DisplayObjectContainer;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;



	/**
	 * @author Marvin
	 */
	public class RecTaggerContext extends Context {

		private var applicationView : ApplicationView;

		public function RecTaggerContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void {
			injector.mapSingleton(FileRefService);
			injector.mapSingleton(ImagesModel);
			injector.mapSingleton(ThumbnailsModel);
			injector.mapSingleton(ButtonsModel);
			injector.mapSingleton(CanvasModel);

			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitializeCommand, ContextEvent, true);
			commandMap.mapEvent(NavigationEvent.BROWSE_FILES, BrowseFilesCommand, NavigationEvent);
			commandMap.mapEvent(NavigationEvent.SAVE_COORDS, SaveCurrentButtonCommand, NavigationEvent);
			commandMap.mapEvent(CanvasEvent.STORE_CURRENT_RECT, StoreCurrentRectCommand, CanvasEvent);

			mediatorMap.mapView(NavigationView, NavigationViewMediator);
			mediatorMap.mapView(ImageView, ImageViewMediator);
			mediatorMap.mapView(CanvasView, CanvasViewMediator);
			mediatorMap.mapView(WorkspaceView, WorkspaceViewMediator);
			mediatorMap.mapView(ThumbnailView, ThumbnailViewMediator);
			mediatorMap.mapView(ApplicationView, ApplicationViewMediator);

			applicationView = new ApplicationView();
			contextView.addChild(applicationView);

			super.startup();
		}
	}
}
