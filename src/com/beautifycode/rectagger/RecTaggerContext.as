package com.beautifycode.rectagger {
	import com.beautifycode.rectagger.commands.GenerateCodeCommand;
	import com.beautifycode.rectagger.actors.CanvasModel;
	import com.beautifycode.rectagger.actors.FileRefService;
	import com.beautifycode.rectagger.actors.ImagesModel;
	import com.beautifycode.rectagger.actors.RecTagsModel;
	import com.beautifycode.rectagger.actors.ThumbnailsModel;
	import com.beautifycode.rectagger.commands.BrowseFilesCommand;
	import com.beautifycode.rectagger.commands.CreateNewRecTagCommand;
	import com.beautifycode.rectagger.commands.DeleteRecTagCommand;
	import com.beautifycode.rectagger.commands.InitializeCommand;
	import com.beautifycode.rectagger.commands.LoadConfigCommand;
	import com.beautifycode.rectagger.commands.SaveConfigCommand;
	import com.beautifycode.rectagger.commands.SaveMetaDataCommand;
	import com.beautifycode.rectagger.components.RecTag;
	import com.beautifycode.rectagger.components.RecTagMediator;
	import com.beautifycode.rectagger.events.MetaDataEvent;
	import com.beautifycode.rectagger.events.NavigationEvent;
	import com.beautifycode.rectagger.events.RecTagEvent;
	import com.beautifycode.rectagger.views.ApplicationView;
	import com.beautifycode.rectagger.views.ApplicationViewMediator;
	import com.beautifycode.rectagger.views.CanvasView;
	import com.beautifycode.rectagger.views.CanvasViewMediator;
	import com.beautifycode.rectagger.views.ImageView;
	import com.beautifycode.rectagger.views.ImageViewMediator;
	import com.beautifycode.rectagger.views.MetaDataView;
	import com.beautifycode.rectagger.views.MetaDataViewMediator;
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
			injector.mapSingleton(RecTagsModel);
			injector.mapSingleton(CanvasModel);

			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitializeCommand, ContextEvent, true);
			commandMap.mapEvent(NavigationEvent.BROWSE_FILES, BrowseFilesCommand, NavigationEvent);
			commandMap.mapEvent(RecTagEvent.CREATE_RECTAG, CreateNewRecTagCommand, RecTagEvent);
			commandMap.mapEvent(RecTagEvent.DELETE_RECTAG, DeleteRecTagCommand, RecTagEvent);
			commandMap.mapEvent(MetaDataEvent.SAVE_DATA, SaveMetaDataCommand, MetaDataEvent);
			commandMap.mapEvent(NavigationEvent.SAVE_CONFIG, SaveConfigCommand, NavigationEvent);
			commandMap.mapEvent(NavigationEvent.LOAD_CONFIG, LoadConfigCommand, NavigationEvent);
			commandMap.mapEvent(NavigationEvent.GENERATE_CODE, GenerateCodeCommand, NavigationEvent);

			mediatorMap.mapView(NavigationView, NavigationViewMediator);
			mediatorMap.mapView(ImageView, ImageViewMediator);
			mediatorMap.mapView(CanvasView, CanvasViewMediator);
			mediatorMap.mapView(WorkspaceView, WorkspaceViewMediator);
			mediatorMap.mapView(ThumbnailView, ThumbnailViewMediator);
			mediatorMap.mapView(ApplicationView, ApplicationViewMediator);
			mediatorMap.mapView(MetaDataView, MetaDataViewMediator);
			mediatorMap.mapView(RecTag, RecTagMediator);

			applicationView = new ApplicationView();
			contextView.addChild(applicationView);

			super.startup();
		}
	}
}
