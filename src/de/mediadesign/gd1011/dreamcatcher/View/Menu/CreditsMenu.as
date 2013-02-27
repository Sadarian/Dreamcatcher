package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;

	public class CreditsMenu extends Sprite
	{
		private static var self:CreditsMenu;
		private static var active:Boolean = false;

		private var mElements:Vector.<DisplayObject>;

		public function CreditsMenu()
		{
			var gM:GraphicsManager = GraphicsManager.graphicsManager;
			addChild(gM.getImage("Main_1"));

			mElements = new Vector.<DisplayObject>();

			var buttonStrings:Array = ["MainMenuContinueScreenBackButton", "MainMenuContinueScreenBackButtonClick"];
			var positions:Array = [[40, 700]];
			var button:Button;
			for(var i:int=0; i<buttonStrings.length;i+=2)
			{
				button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]));
				button.enabled = true;
				button.x = positions[i/2][0];
				button.y = positions[i/2][1];
				button.name = buttonStrings[i];
				button.addEventListener(Event.TRIGGERED, onTriggered);
				addChild(button);
				mElements.push(button);
			}

		}

		private function onTriggered(e:Event):void
		{
			switch(e.currentTarget)
			{
				case(mElements[0]):
					GraphicsManager.graphicsManager.playSound("MenuButton2");
					showAndHide();
					break;
			}
		}

		public static function get continueMenu():CreditsMenu
		{
			if(!self)
				self = new CreditsMenu();
			return self;
		}

		public static function showAndHide():void
		{
			if(!active)
			{
				active = true;
				MainMenu.mainMenu.addChild(continueMenu);
			}
			else
			{
				active = false;
				MainMenu.mainMenu.removeChild(continueMenu);
			}
		}
	}
}
