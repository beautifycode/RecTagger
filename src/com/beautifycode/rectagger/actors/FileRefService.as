package com.beautifycode.rectagger.actors {
	import com.beautifycode.rectagger.events.FileRefEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;

	/**
	 * @author Marvin
	 */
	public class FileRefService extends Actor {
		[Inject]
		public var imagesmodel:ImagesModel;
		[Inject]
		public var thumbnailsmodel:ThumbnailsModel;
		private var _fileRef:FileReference;
		private var _fileFilter:FileFilter;
		private var _loader:Loader;
		private var _e:FileRefEvent;
		private var _file:File;
		private var _imgLoader:Loader;
		private var _imgReq:URLRequest;
		private var _filesCount:uint;
		private var _tmpFile:*;
		private var _currentFilesLoaded:int;
		private var _selectedFiles:Array;
		private var _imgName:*;
		private var _imgPath:*;

		public function FileRefService() {
			_fileFilter = new FileFilter("Image", "*.jpg;*.gif;*.png;");
		}

		public function browseSingleFile():void {
			imagesmodel.initialize();

			_fileRef = new FileReference() ;
			_fileRef.browse([_fileFilter]) ;
			_fileRef.addEventListener(Event.SELECT, onImageSelect) ;
		}

		private function onImageSelect(evt:Event):void {
			_fileRef.load() ;
			_fileRef.addEventListener(Event.COMPLETE, onDataLoaded) ;
		}

		private function onDataLoaded(evt:Event):void {
			var tempFileRef:FileReference = FileReference(evt.target) ;
			_loader = new Loader() ;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onImageLoaded) ;
			_loader.loadBytes(tempFileRef.data) ;
		}

		private function _onImageLoaded(evt:Event):void {
			imagesmodel.storeImage(evt.target.content.bitmapData);
		}

		public function browseMultipleFiles():void {
			imagesmodel.initialize();
			thumbnailsmodel.initialize();

			_file = new File();
			_file.addEventListener(FileListEvent.SELECT_MULTIPLE, onMultipleSelect);
			_file.browseForOpenMultiple("Please select a file or three...");
		}

		private function onMultipleSelect(event:FileListEvent):void {
			_filesCount = event.files.length;
			_selectedFiles = event.files;
			_currentFilesLoaded = 0;

			loadImage(_currentFilesLoaded);
		}

		private function loadImage(c:int):void {
			_imgReq = new URLRequest(_selectedFiles[c].url);
			_imgName = _selectedFiles[c].name;
			_imgPath = _selectedFiles[c].url;

			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			_imgLoader.load(_imgReq);
		}

		private function onImageLoaded(event:Event):void {
			imagesmodel.storeImage(event.target.content.bitmapData);
			thumbnailsmodel.createThumbnail(event.target.content.bitmapData, _imgName, _imgPath);
			_currentFilesLoaded++;

			if (_currentFilesLoaded < _filesCount) loadImage(_currentFilesLoaded);
			else onAllImagesLoaded();
		}

		private function onAllImagesLoaded():void {
			thumbnailsmodel.generateThumbnails();
		}

		public function saveFile(data:String):void {
		}

		public function loadImagesFromConfig(imagesToLoad:Array):void {
			imagesmodel.initialize();
			thumbnailsmodel.initialize();

			_selectedFiles = imagesToLoad;
			_filesCount = imagesToLoad.length;
			loadImageFromPath(_currentFilesLoaded);
		}

		private function loadImageFromPath(c:int):void {
			_imgReq = new URLRequest(_selectedFiles[c]);
			_imgName = _selectedFiles[c];
			_imgPath = _selectedFiles[c];

			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadedFromPath);
			_imgLoader.load(_imgReq);
		}

		private function onImageLoadedFromPath(event:Event):void {
			imagesmodel.storeImage(event.target.content.bitmapData);
			thumbnailsmodel.createThumbnail(event.target.content.bitmapData, _imgName, _imgPath);
			_currentFilesLoaded++;

			if (_currentFilesLoaded < _filesCount) loadImageFromPath(_currentFilesLoaded);
			else onAllImagesLoaded();
		}
	}
}
