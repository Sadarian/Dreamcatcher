package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
	import de.mediadesign.gd1011.dreamcatcher.Game;

	import flash.net.FileFilter;

	import starling.animation.DelayedCall;

	import starling.core.Starling;
	import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.deg2rad;

	public class ContinueMenu extends Sprite
    {
        private static var self:ContinueMenu;
        private static var _active:Boolean = false;

        private var mElements:Vector.<DisplayObject>;

        public function ContinueMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            addChild(gM.getImage("MainMenuContinueScreen"));



            mElements = new Vector.<DisplayObject>();

            var buttonStrings:Array = [	"MainMenuContinueScreenBackButton", "MainMenuContinueScreenBackButtonClick",
										"StageSelectScreenLV1",null,
										"StageSelectScreenLV2", null,
										"StageSelectScreenLV2 Lock", null];
            var positions:Array = [[40, 660],[322, 177],[322, 438],[322, 438]];
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

			if (Dreamcatcher.localObject.data.Progress >= 2)
			{
				mElements[2].visible = true;
				mElements[3].visible = false;
			}
			else
			{
				mElements[2].visible = false;
				mElements[3].visible = true;
			}

			var caseOne:TextField = insertNumbers(980,100,"1");
			var levelOne:TextField = insertNumbers(940,280,"1");
			var levelTwo:TextField = insertNumbers(940,550,"2");

			addChild(caseOne);
			addChild(levelOne);
			addChild(levelTwo);

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
					GraphicsManager.graphicsManager.playSound("MenuButton2");
					showAndHide();
					MainMenu.showAndHide();
					(Starling.current.root as Game).startLevel(1);
					break;
				case(mElements[2]):
					GraphicsManager.graphicsManager.playSound("MenuButton2");
					showAndHide();
					MainMenu.showAndHide();
					(Starling.current.root as Game).startLevel(2);
					break;
				case(mElements[3]):
					GraphicsManager.graphicsManager.playSound("EnemyDie");
					lockedMessage();
					break;
            }
        }

		private function insertNumbers(x:Number,y:Number,value:String):TextField
		{
			var writtenNumber:TextField = new TextField(100,300,value,"MenuFont",80)
			writtenNumber.pivotY = writtenNumber.height/2;
			writtenNumber.pivotX = writtenNumber.width/2;
			writtenNumber.x = x;
			writtenNumber.y = y;

			return writtenNumber;
		}


		private function lockedMessage():void
		{
			var text = new TextField(800,300,"Play level "+Dreamcatcher.localObject.data.Progress+" to unlock","MenuFont",60);
			text.pivotY = text.height/2;
			text.pivotX = text.width/2;
			text.x = Starling.current.viewPort.width/2;
			text.y = Starling.current.viewPort.height/2;
			text.rotation = deg2rad(26);
			text.color = Color.RED;
			addChild(text);

			Starling.juggler.delayCall(removeText,1, text);
		}

		private function removeText(element:TextField):void
		{
			removeChild(element,true);
		}

        public static function get continueMenu():ContinueMenu
        {
            if(!self)
                self = new ContinueMenu();
            return self;
        }

        public static function showAndHide():void
        {
            if(!_active)
            {
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
