package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;

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
		private static var _active:Boolean = false;

		private var mIndex:int = 0;
		private var mElements:Vector.<DisplayObject>;

		public function TutorialMenu()
		{
			var gM:GraphicsManager = GraphicsManager.graphicsManager;
            var i:int;
			for(i=0; i<imageList.length;i++)
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
			for(i=0; i<buttonStrings.length;i+=2)
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
					removeChildAt(0);
				    mIndex -= (mIndex>0)?1:0;
					addChildAt(tutorialContent[mIndex],0);
                    showArrows();

					break;
				case(mElements[2]):
					removeChildAt(0);
					mIndex += (mIndex<tutorialContent.length-1)?1:0;
					addChildAt(tutorialContent[mIndex],0);
                    showArrows();

					break;
			}
		}

        private function showArrows():void
        {
            mElements[1].visible = mIndex > 0;
            mElements[2].visible = mIndex < tutorialContent.length - 1;
        }

		public static function get continueMenu():TutorialMenu
		{
			if(!self)
				self = new TutorialMenu();
			return self;
		}

		public static function showAndHide():void
		{
			if(!_active)
			{
                self = null;
				_active = true;
				MainMenu.mainMenu.addChild(continueMenu);
			}
			else
			{
				_active = false;
				MainMenu.mainMenu.removeChild(continueMenu);

			}
		}

		public static function isActive():Boolean {
			return _active;
		}
	}
}
