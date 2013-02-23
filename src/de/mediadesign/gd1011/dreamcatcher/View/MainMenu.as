package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.deg2rad;

    public class MainMenu extends Sprite
    {
        private static var self:MainMenu;
        private static var active:Boolean = false;;

        private var mElements:Vector.<DisplayObject>;

        public function MainMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            var buttonStrings:Array = ["MainMenuContinueButton", "MainMenuContinueButtonClick", "MainMenuCreditsButton", "MainMenuCreditsButtonClick",
                "MainMenuSoundButtonOn", "MainMenuSoundButtonOn", "MainMenuStartButton", "MainMenuStartButtonClick"];
            var positions:Array = [[109, 375, deg2rad(-14.5)], [164, 455, deg2rad(-14.5)], [20, 23, deg2rad(0)], [138, 257, deg2rad(-13.5)]];
            mElements = new Vector.<DisplayObject>();
            mElements.push(addChild(gM.getImage("MainMenuPicture")));
            var button:Button;
            for(var i:int=0; i<buttonStrings.length;i+=2)
            {
                button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]))
                button.enabled = true;
                button.x = positions[i/2][0];
                button.y = positions[i/2][1];
                button.rotation = positions[i/2][2];
                button.name = buttonStrings[i];
                button.addEventListener(Event.TRIGGERED, onTriggered);
                addChild(button);
                mElements.push(button);
            }
            var mC:MovieClip = new MovieClip(gM.getTextures("MainMenuDrawerAnim_"));
            mC.x = 662;
            mC.y = 330;
            mC.stop();
            mC.loop = false;
            mC.addEventListener(Event.COMPLETE, switchToContinue);
            mElements.push(mC);
        }

        private function onTriggered(e:Event):void
        {
            switch(e.currentTarget)
            {
                case(mElements[1]):
                    addChild(mElements[5] as MovieClip);
                    (mElements[5] as MovieClip).play();
                    //Continue
                    break;
                case(mElements[2]):
                    //Credits
                    break;
                case(mElements[3]):
                    var gM:GraphicsManager = GraphicsManager.graphicsManager;
                    (mElements[3] as Button).upState = (mElements[3].name == "MainMenuSoundButtonOn")?gM.getTexture("MainMenuSoundButtonOff"):gM.getTexture("MainMenuSoundButtonOn");
                    (mElements[3] as Button).downState = (mElements[3].name == "MainMenuSoundButtonOn")?gM.getTexture("MainMenuSoundButtonOff"):gM.getTexture("MainMenuSoundButtonOn");
                    mElements[3].name = (mElements[3].name == "MainMenuSoundButtonOn")?"MainMenuSoundButtonOff":"MainMenuSoundButtonOn";
                    //soundOFF
                    break;
                case(mElements[4]):
                    //Start
                    break;
                default:
                    break;
            }
        }

        private function switchToContinue(e:Event):void
        {

        }

        public static function get mainMenu():MainMenu
        {
            if(!self)
                self = new MainMenu();
            return self;
        }

        public static function showAndHide():void
        {
            if(!active)
            {
                active = true;
                //Starling.juggler.stop();
                GameStage.gameStage.addChild(mainMenu);
            }
            else
            {
                active = false;
                //Starling.juggler.start();
                (Starling.current.root as Game).setStartTimeStamp();
                GameStage.gameStage.removeChild(mainMenu);
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
