package de.mediadesign.gd1011.dreamcatcher.View
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
        private var mElements:Vector.<DisplayObject>;

        public function PauseMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            var buttonStrings:Array = ["PauseMenuPlay", "PauseMenuPlay", "PauseMenuEndGame", "PauseMenuEndGame", "PauseMenuSoundOn", "PauseMenuSoundOn"];
            var positions:Array = [[37, 38], [435, 19], [188,444]];
            mElements = new Vector.<DisplayObject>();
            mElements.push(addChild(gM.getImage("PauseMenuBackground")));
            var button:Button;
            for(var i:int=0; i<buttonStrings.length;i+=2)
            {
                button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]))
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
                case(mElements[1]):
                    showAndHide();
                    break;
                case(mElements[2]):
                    //mainMenu
                    break;
                case(mElements[3]):
                    var gM:GraphicsManager = GraphicsManager.graphicsManager;
                    (mElements[3] as Button).upState = (mElements[3].name == "PauseMenuSoundOn")?gM.getTexture("PauseMenuSoundOff"):gM.getTexture("PauseMenuSoundOn");
                    (mElements[3] as Button).downState = (mElements[3].name == "PauseMenuSoundOn")?gM.getTexture("PauseMenuSoundOff"):gM.getTexture("PauseMenuSoundOn");
                    mElements[3].name = (mElements[3].name == "PauseMenuSoundOn")?"PauseMenuSoundOff":"PauseMenuSoundOn";
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
            if(Starling.juggler.isActive)
            {
                Starling.juggler.stop();
                GameStage.gameStage.addChild(pauseMenu);
            }
            else
            {
                Starling.juggler.start();
                (Starling.current.root as Game).setStartTimeStamp();
                GameStage.gameStage.removeChild(pauseMenu);
            }
        }
    }
}
