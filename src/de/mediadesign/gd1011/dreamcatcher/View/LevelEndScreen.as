/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 22.02.13
 * Time: 14:14
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
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
		private var restartButton:Button;

		private var buttonStrings:Array =
					["Touch to Continue with the next Level!",
					 "Touch to try again!"];

		public function LevelEndScreen(text:String, alpha:Number = 0)
		{
			_alpha = alpha;
			this.text = text;
			_screen = new Sprite();
			_screen.addChild(new Quad(Starling.current.viewPort.width,Starling.current.viewPort.height, 0x000000));
			_screen.alpha = _alpha;
		}

		public function createButton(text:String):Button
		{
			var tempButton:Button
			tempButton = new Button(GraphicsManager.graphicsManager.getTexture(GameConstants.TEXTBOXBUTTON), text);
			tempButton.fontName = "MenuFont";
			tempButton.fontSize = 50;
			tempButton.fontColor = 0xffffff;
			tempButton.textBounds = new Rectangle(0, 0, 300, 100);
			tempButton.x = _screen.width/2 - tempButton.width/2;
			tempButton.y = _screen.height/2 + 200;
			return tempButton;
		}

		public function createNextLevelButton():Button
		{
			continueButton = createButton(buttonStrings[0]);
			continueButton.addEventListener(Event.TRIGGERED, nextLevelClicked);
			return continueButton;
		}

		public function createRestartButton():Button
		{
			restartButton = createButton(buttonStrings[1]);
			restartButton.addEventListener(Event.TRIGGERED, restartClicked);
			return restartButton;
		}

		private function restartClicked(event:Event):void {
			deleteAll();
			(GameStage.gameStage.parent as Game).startLevel(Game.currentLvl);
		}

		private function nextLevelClicked(event:Event):void
		{
			deleteAll();
            (GameStage.gameStage.parent as Game).startLevel(Game.currentLvl+1);
		}

		private function deleteAll():void
		{
			if (continueButton != null)
			{
				continueButton.removeEventListener(Event.TRIGGERED, nextLevelClicked);
			}
			else if (restartButton != null)
			{
				restartButton.removeEventListener(Event.TRIGGERED, restartClicked);
			}

			while (_screen.numChildren > 0)
			{
				_screen.removeChildAt(0, true);
			}
			GameStage.gameStage.removeActor(_screen);
			_screen.dispose();
		}

		public function fadeIn():void
		{
			_screen.alpha = _alpha;

			if (_alpha >= 1)
			{
				if (continueButton != null)
				{
					var textField:TextField;
					_screen.addChild(textField = new TextField(500, 200, text, "MenuFont", 50, 0xffffff));
					textField.x = _screen.width/2 - textField.width/2;
					textField.y = _screen.height/2 - textField.height/2;
					_screen.addChild(continueButton);
				}
				else if (restartButton != null)
				{
					_screen.addChild(GraphicsManager.graphicsManager.getImage("DC_comicOutro2"));
					GraphicsManager.graphicsManager.playSound("Failure");
					_screen.addChild(restartButton);
				}
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
