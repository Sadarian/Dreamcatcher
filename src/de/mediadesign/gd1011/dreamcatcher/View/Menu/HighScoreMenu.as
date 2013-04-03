package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.View.HighScore;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;
    import de.mediadesign.gd1011.dreamcatcher.View.Score;

    import flash.events.SoftKeyboardEvent;

    import flash.events.SoftKeyboardTrigger;

    import flash.media.SoundMixer;
    import flash.media.SoundTransform;
    import flash.system.System;
    import flash.text.TextColorType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.utils.deg2rad;

    public class HighScoreMenu extends Sprite
    {
        private static var self:HighScoreMenu;
        private static var active:Boolean = false;

        private var mElements:Vector.<DisplayObject>;
        private var mHighScoreBar:Sprite;
        private var mScores:Vector.<starling.text.TextField>;
        private var score:Number;

        public function HighScoreMenu()
        {
            var gM:GraphicsManager = GraphicsManager.graphicsManager;
            addChild(gM.getImage("highscore_background"));

            mElements = new Vector.<DisplayObject>();
            mHighScoreBar = new Sprite();
            mScores = new Vector.<starling.text.TextField>(8);
            mHighScoreBar.addChild(gM.getImage("highscore_bar"));
            var i:int;
            for(i=0;i<mScores.length;i++)
            {
                mScores[i] = new starling.text.TextField(380, 100, "", "MenuFont", 35, 0xe87600);
                mScores[i].x = 15;
                mScores[i].y = 110+i*35;
                mHighScoreBar.addChild(mScores[i]);
            }
            mScores[5].y = -10;
            mScores[5].fontSize = 70;
            mScores[5].text="High  Score";

            addChild(mHighScoreBar);

            var buttonStrings:Array =
                    ["highscore_play", "highscore_play",
                    "highscore_end", "highscore_end",
                    "highscore_again", "highscore_again"];
            var positions:Array = [[895, 41], [931, 447], [600, 288]];
            var button:Button;
            for(i=0; i<buttonStrings.length;i+=2)
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
//            mElements.push(gM.getImage("DC_comicOutro1"));
//            addChild(mElements[mElements.length-1]);
//            Starling.juggler.delayCall(deleteChild, 2);
        }

        private function deleteChild():void
        {
            removeChild(mElements[mElements.length-1]);
        }

        private function onTriggered(e:Event):void
        {
			GraphicsManager.graphicsManager.playSound("MenuButton1");
            switch(e.currentTarget)
            {
                case(mElements[0]):
                    showAndHide();
                    (GameStage.gameStage.parent as Game).startLevel(Game.currentLvl+1);
                    break;
                case(mElements[1]):
                    showAndHide();
                    GraphicsManager.graphicsManager.loadDataFor("UI", MainMenu.showAndHide);
                    break;
                case(mElements[2]):
                    showAndHide();
                    (GameStage.gameStage.parent as Game).startLevel(Game.currentLvl);
                    break;
            }
        }

        public static function get highScoreMenu():HighScoreMenu
        {
            if(!self)
                self = new HighScoreMenu();
            return self;
        }

        public static function showAndHide():void
        {
            if(!active)
            {
                active = true;
                (Starling.current.root as Game).addChild(highScoreMenu);
                highScoreMenu.changeScore();
            }
            else
            {
                active = false;
                (Starling.current.root as Game).removeChild(highScoreMenu);
            }
        }

        public function changeScore():void
        {
            var list:Array = HighScore.getHighScore();
            for(var i:int=0;i<list.length;i++)
                mScores[i].text = "#"+(i+1)+"   " + list[i][0] +"    " +list[i][1];
        }

        public function setScore(value:Number):void
        {
            score = value;
            var newPosition:int = HighScore.checkHighScore(score);
            var text:String;
            if(newPosition == -1)
                text = "Your Score is: ";
            else
                text = "Your new High Score is: ";
            mScores[6].text = text;
            mScores[6].width = 800; mScores[6].height = 100;
            mScores[6].x = -100; mScores[6].y = 450;
            mScores[6].fontSize = 70;
            mScores[7].text = score.toString();
            mScores[7].fontSize = 150;
            mScores[7].width = 900; mScores[7].height = 200;
            mScores[7].x = 0; mScores[7].y = 620;
            mScores[7].rotation = deg2rad(-10);
            mScores[7].touchable = true;

            if(newPosition == -1)
                HighScore.saveScoreAt(score, newPosition);
            changeScore();
            /*
            var textField:flash.text.TextField = new flash.text.TextField();
            var textFormat:TextFormat = new TextFormat("MenuFont", 90, 0xff0000);
            textFormat.align = TextFormatAlign.CENTER;
            textField.defaultTextFormat = textFormat;
            textField.type = TextFieldType.INPUT;
            textField.autoSize = TextFieldAutoSize.CENTER;
            textField.x = 230;
            textField.y = 620;
            textField.embedFonts = true;
            textField.rotation = -30;
            textField.text = "Tap to type name!";
            textField.restrict = "A-Z";
            textField.needsSoftKeyboard = true;

            Starling.current.nativeOverlay.addChild(textField);
            textField.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onActivateKeyboard);
            */
        }

        private function onActivateKeyboard(event:SoftKeyboardEvent):void
        {
            if( (Starling.current.nativeStage.softKeyboardRect.y != 0) && (event.currentTarget.y + event.currentTarget.height > Starling.current.nativeStage.softKeyboardRect.y) )
                event.currentTarget.y -= event.currentTarget.y + event.currentTarget.height - Starling.current.nativeStage.softKeyboardRect.y;
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
