package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.Game;

    import flash.media.SoundChannel;
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

        private var endless:Boolean = false;
        private var mElements:Vector.<DisplayObject>;
        //noinspection JSFieldCanBeLocal
        private var music:SoundChannel;

        public function MainMenu()
        {
            endless = Dreamcatcher.localObject.data.Endless;

            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            addChild(gM.getImage("MainMenuPicture"));

            mElements = new Vector.<DisplayObject>();

            if(!endless)
                var buttonStrings:Array =
                        ["MainMenuContinueButton", "MainMenuContinueButtonClick",
                         "MainMenuCreditsButton", "MainMenuCreditsButtonClick",
                         "MainMenuSoundButtonOn", "MainMenuSoundButtonOn",
                         "MainMenuStartButton", "MainMenuStartButtonClick",
                         "MainMenuHelpButton",  "MainMenuHelpButtonClick"];
            else
                var buttonStrings:Array =
                        ["MainMenuStoryButton", "MainMenuStoryButtonClick",
                            "MainMenuCreditsButton", "MainMenuCreditsButtonClick",
                            "MainMenuSoundButtonOn", "MainMenuSoundButtonOn",
                            "MainMenuEndlessButton", "MainMenuEndlessButtonClick",
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
                    onSwitch();
                    break;
                case(mElements[1]):
                    CreditsMenu.showAndHide();
                    break;
                case(mElements[2]):
                    if(SoundMixer.soundTransform.volume == 1)
                        SoundMixer.soundTransform = new SoundTransform(0, 0);
                    else
                        SoundMixer.soundTransform = new SoundTransform(1, 0);
                    checkSoundButton();
                    break;

                case(mElements[3]):
                    showAndHide();
                    if(endless)
                        (Starling.current.root as Game).startLevel(-1);
                    else
                        (Starling.current.root as Game).startLevel(Dreamcatcher.localObject.data.Progress);
                    break;
				case(mElements[4]):
					TutorialMenu.showAndHide();
					break;
            }
        }

        private function checkSoundButton():void
        {
            var suffix:String = (SoundMixer.soundTransform.volume != 0)?"On":"Off";
            var name:String = "MainMenuSoundButton" + suffix;
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            (mElements[2] as Button).upState = gM.getTexture(name);
            (mElements[2] as Button).downState = gM.getTexture(name);
            (mElements[2] as Button).name = name;
            Dreamcatcher.localObject.data.soundOn = (SoundMixer.soundTransform.volume != 0);
            Dreamcatcher.localObject.flush();
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
                self = null;
                active = true;
                (Starling.current.root as Game).addChild(mainMenu);
                mainMenu.checkSoundButton();
                mainMenu.music = GraphicsManager.graphicsManager.playSound("MenuMusic");
            }
            else
            {
                active = false;
                (Starling.current.root as Game).setStartTimeStamp();
                mainMenu.music.stop();
                (Starling.current.root as Game).removeChild(mainMenu);
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
