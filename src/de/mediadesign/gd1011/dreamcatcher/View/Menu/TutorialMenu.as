package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class TutorialMenu extends Sprite
	{
		private static var self:TutorialMenu;
		private static var imageList:Array = ["tutorialScreen_1", "tutorialScreen_2", "tutorialScreen_3", "tutorialScreen_4"];
		private static var tutorialContent:Vector.<Image> = new Vector.<Image>();
		private static var active:Boolean = false;

		private var mIndex:int = 0;
		private var mElements:Vector.<DisplayObject>;

		public function TutorialMenu()
		{
			var gM:GraphicsManager = GraphicsManager.graphicsManager;
			var iM:Image;

			for( var i:int=0; i<imageList.length;i++)
			{
				tutorialContent.push(gM.getImage(imageList[i]));
			}
			addChild(tutorialContent[mIndex]);

			mElements = new Vector.<DisplayObject>();

			var buttonStrings:Array = [	"TutorialBackButton", "TutorialBackButtonClick",
										"TutorialScreenBackButton","TutorialScreenBackButtonClick",
										"TutorialScreenForwardButton","TutorialScreenForwardButtonClick"];
			var positions:Array = [[40, 650],[50, 250],[1050, 250]];
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
			mElements[1].visible = false;
		}

		private function onTriggered(e:Event):void
		{
			switch(e.currentTarget)
			{
				case(mElements[0]):
					GraphicsManager.graphicsManager.playSound("MenuButton2");
					showAndHide();
					break;
				case(mElements[1]):
					trace("Back");
					removeChildAt(0);
				    mIndex -= (mIndex>0)?1:0;
					addChildAt(tutorialContent[mIndex],0);
					if (mIndex >= tutorialContent.length-2)
						mElements[2].visible = false;
					else
						mElements[2].visible = true;
					break;
				case(mElements[2]):
					trace("Forward");
					removeChildAt(0);
					mIndex += (mIndex<tutorialContent.length-1)?1:0;
					addChildAt(tutorialContent[mIndex],0);
					if (mIndex <= 1)
						mElements[1].visible = false;
					else
						mElements[1].visible = true;
					break;
			}
		}

		public static function get continueMenu():TutorialMenu
		{
			if(!self)
				self = new TutorialMenu();
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