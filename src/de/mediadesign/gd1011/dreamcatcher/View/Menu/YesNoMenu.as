package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.Game;


    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.deg2rad;

    public class YesNoMenu extends Sprite
    {
        private static var self:YesNoMenu;
        private static var active:Boolean = false;
		private static var _selectetLvl:int = 0;

        private var mElements:Vector.<DisplayObject>;

        public function YesNoMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;

            mElements = new Vector.<DisplayObject>();

            var buttonStrings:Array =
                    ["Yes", "TextBoxButton",
                     "No", "TextBoxButton"];
            var positions:Array = [[440, 400], [840, 400]];
            var button:Button;
            for(var i:int=0; i<buttonStrings.length;i+=2)
            {
                button = new Button(gM.getTexture(buttonStrings[i+1]), buttonStrings[i]);
                button.enabled = true;
				button.fontSize = 100;
				button.fontName = "MenuFont";
				button.fontColor = 0xece030b;
                button.x = positions[i/2][0];
                button.y = positions[i/2][1];
                button.name = buttonStrings[i];
                button.addEventListener(Event.TRIGGERED, onTriggered);
                addChild(button);
                mElements.push(button);
            }
			var text:TextField = new TextField(500, 200, "Do you want to finish the Tutorial?", "MenuFont", 100, 0xece030b);
			text.x = 390;
			text.y = 200;
			text.autoScale = true;
			addChild(text);
        }

        private function onTriggered(e:Event):void
        {
			GraphicsManager.graphicsManager.playSound("MenuButton1");
            switch(e.currentTarget)
            {
                case(mElements[0]):
					showAndHide();
					TutorialMenu.showAndHide();
                    break;

                case(mElements[1]):
                    showAndHide();
					if (selectetLvl != 0)
					{
						(Starling.current.root as Game).startLevel(selectetLvl);
						selectetLvl = 0;
					}
                    break;
            }
        }

        public static function get yesNoMenu():YesNoMenu
        {
            if(!self)
                self = new YesNoMenu();
            return self;
        }

        public static function showAndHide():void
        {
            if(!active)
            {
                self = null;
                active = true;
                (Starling.current.root as Game).addChild(yesNoMenu);
            }
            else
            {
                active = false;
                (Starling.current.root as Game).removeChild(yesNoMenu);
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }

		public static function get selectetLvl():int {
			return _selectetLvl;
		}

		public static function set selectetLvl(value:int):void {
			_selectetLvl = value;
		}
    }
}
