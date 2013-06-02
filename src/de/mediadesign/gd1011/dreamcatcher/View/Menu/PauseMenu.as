package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;

    import flash.media.SoundMixer;
    import flash.media.SoundTransform;

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

            var buttonStrings:Array =
                    ["PauseMenuPlay", "PauseMenuPlay",
                    "PauseMenuEndGame", "PauseMenuEndGame",
                    "PauseMenuSoundOn", "PauseMenuSoundOn"];

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
			GraphicsManager.graphicsManager.playSound("MenuButton1");
            switch(e.currentTarget)
            {
                case(mElements[0]):
                    showAndHide();
                    break;
                case(mElements[1]):
                    showAndHide();
                    GameStage.gameStage.resetAll();
	                if (Game.currentLvl == GameConstants.TUTORIAL && YesNoMenu.selectetLvl != GameConstants.TUTORIAL)
	                {
		                TutorialMenu.showAndHide();
		                (Starling.current.root as Game).startLevel(YesNoMenu.selectetLvl);
	                }
		            else
	                {
		                GraphicsManager.graphicsManager.loadDataFor("UI", MainMenu.showAndHide);
	                }
                    break;
                case(mElements[2]):
                    if(SoundMixer.soundTransform.volume == 1)
                        SoundMixer.soundTransform = new SoundTransform(0, 0);
                    else
                        SoundMixer.soundTransform = new SoundTransform(1, 0);
                    checkSoundButton();
                    break;
            }
        }

        private function checkSoundButton():void
        {
            var suffix:String = (SoundMixer.soundTransform.volume != 0)?"On":"Off";
            var name:String = "PauseMenuSound"+suffix;
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            (mElements[2] as Button).upState = gM.getTexture(name);
            (mElements[2] as Button).downState = gM.getTexture(name);
            (mElements[2] as Button).name = name;
            Dreamcatcher.localObject.data.soundOn = (SoundMixer.soundTransform.volume != 0);
            Dreamcatcher.localObject.flush();
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
                self = null;
                active = true;
                Starling.juggler.stop();
                (Starling.current.root as Game).addChild(pauseMenu);
                pauseMenu.checkSoundButton();
            }
            else
            {
                active = false;
                Starling.juggler.start();
                (Starling.current.root as Game).setStartTimeStamp();
                (Starling.current.root as Game).removeChild(pauseMenu);
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
