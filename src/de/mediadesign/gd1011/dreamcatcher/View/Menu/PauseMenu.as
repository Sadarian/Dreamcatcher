package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;

    public class PauseMenu extends Sprite
    {
        private static var self:PauseMenu;
        private static var active:Boolean = false;

        private var mElements:Vector.<DisplayObject>;

        public function PauseMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            addChild(gM.getImage("PauseMenuBackground"));

            mElements = new Vector.<DisplayObject>();

            var buttonStrings:Array = ["PauseMenuPlay", "PauseMenuPlay", "PauseMenuEndGame", "PauseMenuEndGame", "PauseMenuSoundOn", "PauseMenuSoundOn"];
            var positions:Array = [[37, 38], [435, 19], [188,444]];
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
                case(mElements[1]):
                    showAndHide();
                    MainMenu.showAndHide();
                    break;
                case(mElements[2]):
                    var gM:GraphicsManager = GraphicsManager.graphicsManager;
                    (mElements[2] as Button).upState = (mElements[2].name == "PauseMenuSoundOn")?gM.getTexture("PauseMenuSoundOff"):gM.getTexture("PauseMenuSoundOn");
                    (mElements[2] as Button).downState = (mElements[2].name == "PauseMenuSoundOn")?gM.getTexture("PauseMenuSoundOff"):gM.getTexture("PauseMenuSoundOn");
                    mElements[2].name = (mElements[2].name == "PauseMenuSoundOn")?"PauseMenuSoundOff":"PauseMenuSoundOn";
                    //soundOFF
                    break;
            }
        }

        public static function get pauseMenu():PauseMenu
        {
            if(!self)
                self = new PauseMenu();
            return self;
        }

        public static function showAndHide():void
        {
            if(!active)
            {
                active = true;
                Starling.juggler.stop();
                GameStage.gameStage.addChild(pauseMenu);
            }
            else
            {
                active = false;
                Starling.juggler.start();
                (Starling.current.root as Game).setStartTimeStamp();
                GameStage.gameStage.removeChild(pauseMenu);
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
