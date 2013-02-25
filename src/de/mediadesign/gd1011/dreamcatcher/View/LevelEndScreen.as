/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 22.02.13
 * Time: 14:14
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class LevelEndScreen
	{
		private var _alpha:Number;
		private var text:String;
		private var _screen:Sprite;
		private var continueButton:Button;

		public function LevelEndScreen(text:String, alpha:Number = 0)
		{
			_alpha = alpha;
			this.text = text;
			_screen = new Sprite();
			_screen.addChild(new Quad(Starling.current.viewPort.width,Starling.current.viewPort.height, 0x000000));
			_screen.alpha = _alpha;

			createContinueButton();
		}

		private function createContinueButton():void
		{
			continueButton = new Button(GraphicsManager.graphicsManager.getTexture("Quad"), "Touch to Continue");
			continueButton.fontName = "FriskyVampire";
			continueButton.fontSize = 50;
			continueButton.fontColor = 0xffffff;
			continueButton.textBounds = new Rectangle(0, 0, 300, 100);
			continueButton.x = _screen.width/2 - continueButton.width/2;
			continueButton.y = _screen.height/2 + 200 - continueButton.height/2;
		}

		private function continueClicked(event:Event):void
		{
			continueButton.removeEventListener("TRIGGERED", continueClicked);

			while (_screen.numChildren > 0)
			{
				_screen.removeChildAt(0, true);
			}
			GameStage.gameStage.removeActor(_screen);
			(GameStage.gameStage.parent as Game).nextLevel();
		}

		public function fadeIn():void {
			_screen.alpha = _alpha;

			if (_alpha >= 1)
			{
				var textField:TextField;
				_screen.addChild(textField = new TextField(500, 200, text, "FriskyVampire", 50, 0xffffff));
				textField.x = _screen.width/2 - textField.width/2;
				textField.y = _screen.height/2 - textField.height/2;

				continueButton.addEventListener(Event.TRIGGERED, continueClicked);
				_screen.addChild(continueButton);
			}
		}

		public function get alpha():Number {
			return _alpha;
		}

		public function set alpha(value:Number):void {
			_alpha = value;
		}

		public function get screen():Sprite {
			return _screen;
		}
	}
}
