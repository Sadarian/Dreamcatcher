package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;

    public class ContinueMenu extends Sprite
    {
        private static var self:ContinueMenu;
        private static var active:Boolean = false;

        private var mElements:Vector.<DisplayObject>;

        public function ContinueMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            addChild(gM.getImage("MainMenuContinueScreen"));

            mElements = new Vector.<DisplayObject>();

            var buttonStrings:Array = ["MainMenuContinueScreenBackButton", "MainMenuContinueScreenBackButtonClick"];
            var positions:Array = [[840, 72]];
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
                    showAndHide();
                    break;
            }
        }

        public static function get continueMenu():ContinueMenu
        {
            if(!self)
                self = new ContinueMenu();
            return self;
        }

        public static function showAndHide():void
        {
            if(!active)
            {
                active = true;
                GameStage.gameStage.addChild(continueMenu);
            }
            else
            {
                active = false;
                GameStage.gameStage.removeChild(continueMenu);
            }
        }
    }
}
