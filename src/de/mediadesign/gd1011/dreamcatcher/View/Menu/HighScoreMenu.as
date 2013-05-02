package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
import de.mediadesign.gd1011.dreamcatcher.Gameplay.EndlessMode;
import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.View.HighScore;

    import flash.events.FocusEvent;

    import flash.events.SoftKeyboardEvent;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.ui.Keyboard;

    import org.osmf.layout.HorizontalAlign;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.text.TextField;
    import starling.utils.deg2rad;

    public class HighScoreMenu extends Sprite
    {
        private static var self:HighScoreMenu;
        private static var active:Boolean = false;

        private static var state:Boolean = false;

        private var mElements:Vector.<DisplayObject>;
        private var mHighScoreBar:Sprite;
        private var mScores:Vector.<starling.text.TextField>;
        private var score:Number;
        private var textField:flash.text.TextField;

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
                mScores[i].hAlign = HorizontalAlign.LEFT;
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
            //mElements.push(gM.getImage("DC_comicOutro1"));
            //addChild(mElements[mElements.length-1]);
            //Starling.juggler.delayCall(deleteChild, 2);
        }

        private function deleteChild():void
        {
            removeChild(mElements[mElements.length-1]);
        }

        private function onTriggered(e:Event):void
        {
			GraphicsManager.graphicsManager.playSound("MenuButton1");
            if(!state)
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
            else
                switch(e.currentTarget)
                {
                    case(mElements[0]):
                        showAndHide();
                        (GameStage.gameStage.parent as Game).startLevel(Game.currentLvl);
                        break;
                    case(mElements[1]):
                        showAndHide();
                        MainMenu.showAndHide();
                        ContinueMenu.showAndHide();
                        break;
                }
        }

        public static function get highScoreMenu():HighScoreMenu
        {
            if(!self)
                self = new HighScoreMenu();
            return self;
        }

        public static function showAndHide(ShownInMainMenu:Boolean = false):void
        {
            state = ShownInMainMenu;
            if(!active)
            {
                self = null;
                active = true;
                highScoreMenu.mElements[2].visible = !state;
                highScoreMenu.mElements[0].visible = !EndlessMode.hasInstance;
                (Starling.current.root as Game).addChild(highScoreMenu);
                highScoreMenu.changeScore();
            }
            else
            {
                active = false;
                if(highScoreMenu.textField != null)
                {
                    Starling.current.nativeOverlay.removeChild(highScoreMenu.textField);
                    highScoreMenu.textField = null;
                    Starling.current.root.stage.removeEventListeners(KeyboardEvent.KEY_DOWN);
                    highScoreMenu.mScores[6].text="";
                    highScoreMenu.mScores[7].text="";
                }
                (Starling.current.root as Game).removeChild(highScoreMenu);
            }
        }

        public function changeScore():void
        {
            var list:Array = HighScore.getHighScore(Game.currentLvl);
            for(var i:int=0;i<list.length;i++)
                mScores[i].text = "#"+(i+1)+"   " + list[i][0] +"    " +list[i][1];
        }

        public function setScore(value:Number):void
        {
            score = value;
            var newPosition:int = HighScore.checkHighScore(Game.currentLvl,score);
            var text:String;
            if(newPosition == -1)
                text = "Your Score is: ";
            else
                text = "Your new High Score is: ";
            mScores[6].text = text;
            mScores[6].width = 800; mScores[6].height = 100;
            mScores[6].x = 25; mScores[6].y = 450;
            mScores[6].fontSize = 70;
            mScores[7].text = score.toString();
            mScores[7].fontSize = 150;
            mScores[7].width = 900; mScores[7].height = 200;
            mScores[7].x = 135; mScores[7].y = 600;
            mScores[7].rotation = deg2rad(-10);
            mScores[7].touchable = true;

            if(newPosition != -1)
            {
                HighScore.saveScoreAt(Game.currentLvl, score, newPosition, "LocalPlayer");
                changeScore();
                textField = new flash.text.TextField();
                var textFormat:TextFormat = new TextFormat("MenuFont", 90, 0xff0000);
                textFormat.align = TextFormatAlign.CENTER;
                textField.defaultTextFormat = textFormat;
                textField.type = TextFieldType.INPUT;
                textField.autoSize = TextFieldAutoSize.CENTER;
                textField.x = 640;
                textField.y = 140;
                textField.embedFonts = true;
                textField.text = "Tap to type name!";
                textField.restrict = "A-Z";
                textField.needsSoftKeyboard = true;

                Starling.current.nativeOverlay.addChild(textField);
                textField.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onActivateKeyboard);
                Starling.current.root.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
                textField.addEventListener(FocusEvent.FOCUS_OUT, onInput);

                function onInput(event:FocusEvent):void
                {
                    HighScore.saveScoreAt(Game.currentLvl, score, newPosition, textField.text);
                    changeScore();
                    Starling.current.nativeOverlay.removeChild(textField);
                    textField = null;
                }
                function onKeyDown(event:KeyboardEvent):void
                {
                    if(event.keyCode == Keyboard.ENTER && textField.text.length != 0)
                    {
                        Starling.current.root.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
                        onInput(null);
                    }
                }
                function onActivateKeyboard(event:SoftKeyboardEvent):void
                {
                    (event.currentTarget as flash.text.TextField).text = "";
                }
            }
        }

        public static function isActive():Boolean
        {
            return active;
        }
    }
}
