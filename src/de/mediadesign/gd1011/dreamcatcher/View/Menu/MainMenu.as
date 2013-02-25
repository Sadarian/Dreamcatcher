package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

import flash.media.Camera;
import flash.media.SoundMixer;
import flash.media.SoundTransform;

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
        private static var active:Boolean = false;

        private var mElements:Vector.<DisplayObject>;

        public function MainMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            addChild(gM.getImage("MainMenuPicture"));

            mElements = new Vector.<DisplayObject>();

            var buttonStrings:Array =
                    ["MainMenuContinueButton", "MainMenuContinueButtonClick",
                     "MainMenuCreditsButton", "MainMenuCreditsButtonClick",
                     "MainMenuSoundButtonOn", "MainMenuSoundButtonOn",
                     "MainMenuStartButton", "MainMenuStartButtonClick"];
            var positions:Array = [[109, 375, deg2rad(-14.5)], [164, 455, deg2rad(-14.5)], [20, 23, deg2rad(0)], [138, 257, deg2rad(-13.5)]];
            var button:Button;
            for(var i:int=0; i<buttonStrings.length;i+=2)
            {
                button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]));
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
            mC.stop();
            mC.x = 662;
            mC.y = 330;
            mC.loop = false;
            mC.addEventListener(Event.COMPLETE, onSwitch);
            mElements.push(mC);
        }

        private function onTriggered(e:Event):void
        {
            switch(e.currentTarget)
            {
                case(mElements[0]):
                    addChild(mElements[4]);
                    (mElements[4] as MovieClip).play();
                    Starling.juggler.add(mElements[4] as MovieClip);
                    break;
                case(mElements[1]):
                    //Credits
                    break;
                case(mElements[2]):
                    var gM:GraphicsManager = GraphicsManager.graphicsManager;
                    SoundMixer.soundTransform.volume = (mElements[2].name == "MainMenuSoundButtonOn")?0:1;
                    (mElements[2] as Button).upState = (mElements[2].name == "MainMenuSoundButtonOn")?gM.getTexture("MainMenuSoundButtonOff"):gM.getTexture("MainMenuSoundButtonOn");
                    (mElements[2] as Button).downState = (mElements[2].name == "MainMenuSoundButtonOn")?gM.getTexture("MainMenuSoundButtonOff"):gM.getTexture("MainMenuSoundButtonOn");
                    mElements[2].name = (mElements[2].name == "MainMenuSoundButtonOn")?"MainMenuSoundButtonOff":"MainMenuSoundButtonOn";
                    break;
                case(mElements[3]):
                    showAndHide();
                    (Starling.current.root as Game).startLevel(1);
                    break;
            }
        }

        private function onSwitch():void
        {
            (mElements[4] as MovieClip).stop();
            Starling.juggler.remove(mElements[4] as MovieClip);
            removeChild(mElements[4]);
            ContinueMenu.showAndHide()
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
                GameStage.gameStage.addChild(mainMenu);
            }
            else
            {
                active = false;
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
