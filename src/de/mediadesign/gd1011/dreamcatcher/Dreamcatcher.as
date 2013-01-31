package de.mediadesign.gd1011.dreamcatcher {


	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.events.Event;

	[SWF(width="1280", height="800", frameRate="60", backgroundColor="#ffffff")]
	public class Dreamcatcher extends Sprite {
		private var _starling:Starling;


		public function Dreamcatcher() {
			Starling.handleLostContext = true;


			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;

			handelScaling();

			init();
		}

		private function handelScaling():void {
			var guiSize:Rectangle = new Rectangle(0, 0, 1280, 800);
			var deviceSize:Rectangle = new Rectangle(0, 0,
					Math.max(stage.fullScreenWidth, stage.fullScreenHeight),
					Math.min(stage.fullScreenWidth, stage.fullScreenHeight));
		}



		private function init():void {
			_starling = new Starling(Game, stage);
			_starling.showStats = true;
			_starling.addEventListener(Event.ROOT_CREATED, startStarling);

		}

		private function startStarling(event:Event):void {
			_starling.start();
		}
	}
}
