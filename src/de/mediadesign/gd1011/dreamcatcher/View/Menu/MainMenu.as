package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
	import flash.media.SoundMixer;


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

			//var music:SoundChannel = GraphicsManager.graphicsManager.playSound("MenuTheme");

            mElements = new Vector.<DisplayObject>();

            var buttonStrings:Array =
                    ["MainMenuContinueButton", "MainMenuContinueButtonClick",
                     "MainMenuCreditsButton", "MainMenuCreditsButtonClick",
                     "MainMenuSoundButtonOn", "MainMenuSoundButtonOn",
                     "MainMenuStartButton", "MainMenuStartButtonClick",
					 "MainMenuHelpButton",  "MainMenuHelpButtonClick"];
            var positions:Array = [[109, 375, deg2rad(-14.5)], [164, 455, deg2rad(-14.5)], [20, 23, deg2rad(0)], [138, 257, deg2rad(-13.5)], [260, 530, deg2rad(-13.5)]];
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
			GraphicsManager.graphicsManager.playSound("MenuButton1");
            switch(e.currentTarget)
            {
                case(mElements[0]):
					GraphicsManager.graphicsManager.playSound("MenuSlide");
                    addChild(mElements[5]);
                    (mElements[5] as MovieClip).play();
                    Starling.juggler.add(mElements[5] as MovieClip);
                    break;
                case(mElements[1]):
                    CreditsMenu.showAndHide();
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
                    (Starling.current.root as Game).startLevel(Game.currentLvl);
                    break;
				case(mElements[4]):
					TutorialMenu.showAndHide();
					break;
            }
        }

        private function onSwitch():void
        {
            (mElements[5] as MovieClip).stop();
            Starling.juggler.remove(mElements[5] as MovieClip);
            removeChild(mElements[5]);
            ContinueMenu.showAndHide()
        }

        public static function get mainMenu():MainMenu
        {
            if(!self)
                self = new MainMenu();
            return self;
        }

        public static function resetMainMain():void
        {
            if(!self) return;
            for(var i:int=0;i<self.mElements.length;i++)
                self.mElements[i].dispose();
            active = false;
            self.dispose();
            self = null;
        }

        public static function showAndHide():void
        {
            if(!active)
            {
                active = true;
                (Starling.current.root as Game).addChild(mainMenu);
            }
            else
            {
                active = false;
                (Starling.current.root as Game).setStartTimeStamp();
                (Starling.current.root as Game).removeChild(mainMenu);
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
