package com.beautifycode.rectagger.views {
	import flash.display.Sprite;


	/**
	 * @author Blase
	 */
	public class ApplicationView extends Sprite {
		public var navigationView : NavigationView;
		public var imageView : ImageView;
		public var canvasView : CanvasView;

		public var workspaceView : WorkspaceView;
		public var thumbnailView : ThumbnailView;
		public var staticLayoutView : StaticLayoutView;

		public function ApplicationView() {
			thumbnailView = new ThumbnailView();
			thumbnailView.x = 1100;

			imageView = new ImageView();
			imageView.x = 0;
			imageView.y = 0;

			canvasView = new CanvasView();
			canvasView.x = 0;
			canvasView.y = 0;

			workspaceView = new WorkspaceView();
			workspaceView.x = 0;

			workspaceView.addChild(imageView);
			workspaceView.addChild(canvasView);

			staticLayoutView = new StaticLayoutView();
			staticLayoutView.y = 10;

			navigationView = new NavigationView();
			navigationView.x = 0;
			
			addChild(thumbnailView);
			addChild(workspaceView);
			addChild(staticLayoutView);
			addChild(navigationView);
		}
	}
}
