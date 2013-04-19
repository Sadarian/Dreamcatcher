package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerPowershot;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerStraight;
    import de.mediadesign.gd1011.dreamcatcher.Processes.ActivePowerUpProcess;
	import de.mediadesign.gd1011.dreamcatcher.TestStuff.CollisionDummyBoxes;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPlayer;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerFan;
    import de.mediadesign.gd1011.dreamcatcher.Processes.CollisionProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.DestroyProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.MoveProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.RenderProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.ShootingProcess;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.ContinueMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.CreditsMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.HighScoreMenu;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.PauseMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.TutorialMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.PauseButton;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;
	import de.mediadesign.gd1011.dreamcatcher.View.Score;

    import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.net.InterfaceAddress;
	import flash.ui.Keyboard;
    import flash.utils.getTimer;
    import starling.core.Starling;
	import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.text.TextField;

	public class Game extends Sprite
    {
        private var graphicsManager:GraphicsManager;
        private var entityManager:EntityManager;
        private var gameStage:GameStage;


        private var moveProcess:MoveProcess;
		private var shootingProcess:ShootingProcess;
		private var collisionProcess:CollisionProcess;
        private var destroyProcess:DestroyProcess;
		private var renderProcess:RenderProcess;

	    public static var currentLvl:Number;
		private var lastFrameTimeStamp:Number;
		private var now:Number = 0;
		public var noPlayTime:Number = 0;
		private var passedLvlTime:Number = 0;
		private static var _weaponPlayerStraight:WeaponPlayerStraight = new WeaponPlayerStraight();
		private static var _weaponPlayerFan:WeaponPlayerFan = new WeaponPlayerFan();
		private static var _weaponPlayerPowershot:WeaponPlayerPowershot = new WeaponPlayerPowershot();

        //DEBUG:
        private var touchPosition:Point = new Point();

		public function Game()
        {
            graphicsManager = GraphicsManager.graphicsManager;
            gameStage = GameStage.gameStage;
	        entityManager = EntityManager.entityManager;

	        moveProcess = new MoveProcess();
	        shootingProcess = new ShootingProcess();
	        collisionProcess = new CollisionProcess();
	        destroyProcess = new DestroyProcess();
	        renderProcess = new RenderProcess();
	        addEventListener(Event.ENTER_FRAME, update);
		}

        public function init():void
        {
            currentLvl = Dreamcatcher.localObject.data.Progress;
            graphicsManager.init();
            stage.addEventListener(KeyboardEvent.KEY_DOWN, debugFunction);
        }

        public function resumeInit():void
        {
            graphicsManager.initCompleted = true;
            addChild(gameStage);
            MainMenu.showAndHide();
			var musicTransform:SoundTransform = new SoundTransform(0.5);
			GraphicsManager.graphicsManager.playSound("GreySkies", 0, 10, musicTransform);


			//GraphicsManager.graphicsManager.playSound("Slayer",0,0,musicTransform);
			//GraphicsManager.graphicsManager.playSound("Slayer");
        }

		public function startLevel(levelIndex:int = 1):void
		{
			passedLvlTime += now;
            currentLvl = (levelIndex>2)?2:levelIndex;
            if(GameConstants.Player_Default != "Walk")
                GameConstants.Player_Default = "Walk";
            graphicsManager.loadDataFor("LEVEL"+currentLvl, (currentLvl!=1)?resumeStartLevel:comic);

		}

        private function comic():void
        {
            var img:Image = GraphicsManager.graphicsManager.getImage("DC_comicIntroPanel2");
            addChild(img);
            var img2:Image = GraphicsManager.graphicsManager.getImage("DC_comicIntroPanel1");
            addChild(img2);
            Starling.juggler.delayCall(deleteChild, 6, img);
            Starling.juggler.delayCall(deleteChild, 3, img2);
        }

        private function deleteChild(img:Image):void
        {
            removeChild(img);
            if(img.name == "DC_comicIntroPanel2")
                resumeStartLevel();
        }

        public function resumeStartLevel():void
        {
            if(!hasEventListener(Event.ENTER_FRAME))
                addEventListener(Event.ENTER_FRAME, update);
            if(!hasEventListener(TouchEvent.TOUCH))
                addEventListener(TouchEvent.TOUCH, onTouch);
            gameStage.init();
            entityManager.init();
            PowerUpTrigger.init();
            Score.showScore(0);

			var text:TextField;

			switch (currentLvl)
			{
				case 1:
				{
					text = createTextField(GameConstants.introTextLvl1);
					GameStage.gameStage.addChild(text);
					Starling.juggler.delayCall(deleteText, 2, text);
					trace("lvl1");
					break;
				}

				case 2:
				{
					text = createTextField(GameConstants.introTextLvl2);
					GameStage.gameStage.addChild(text);
					Starling.juggler.delayCall(deleteText, 2, text);
					trace("lvl2");
					break;
				}

				default:
				{
					text = createTextField(GameConstants.introTextLvlEndless);
					GameStage.gameStage.addChild(text);
					Starling.juggler.delayCall(deleteText, 2, text);
					trace("lvl3");
					break;
				}
			}

			gameStage.loadLevel(currentLvl);
            entityManager.loadEntities(currentLvl);
            graphicsManager.initCompleted = true;
            Starling.juggler.delayCall(allowShooting, 1);

        }

		private function deleteText(text:TextField):void
		{
			GameStage.gameStage.removeActor(text);
			text.dispose();
		}

		private function createTextField(s:String):TextField
		{
			var text:TextField = new TextField(500, 200, s, "MenuFont", GameConstants.introTextSize,0xece030b, true);
			text.pivotX = text.width/2;
			text.pivotY = text.height/2;
			text.x = Starling.current.viewPort.width/2;
			text.y = Starling.current.viewPort.height/2;
			text.autoScale = true;

			if (GameConstants.introTextRotation > 0 || GameConstants.introTextRotation < 0)
			{
				text.rotation = GameConstants.introTextRotation*(Math.PI/180);
			}

			return text;
		}

        private function allowShooting():void
        {
            entityManager.entities[0].switchWeapon(new WeaponPlayerStraight());

            entityManager.entities[0].switchWeapon(weaponPlayerStraight);
            entityManager.entities[0].setWeaponSpeed();
        }

        public function setStartTimeStamp():void
        {
            lastFrameTimeStamp = getTimer() / 1000 - noPlayTime - passedLvlTime;
        }

		public function getNoPlayTime():void
		{
			noPlayTime = (getTimer()/1000) - now - passedLvlTime;
		}

		private function update():void
		{
			if (MainMenu.isActive() || PauseMenu.isActive() || HighScoreMenu.isActive() || ContinueMenu.isActive() || CreditsMenu.isActive() || TutorialMenu.isActive())
			{
				getNoPlayTime();
			}
			else if(Starling.juggler.isActive && !MainMenu.isActive() && graphicsManager.initCompleted && !HighScoreMenu.isActive())
            {

                now = getTimer() / 1000 - noPlayTime - passedLvlTime;
                var passedTime:Number = (now - lastFrameTimeStamp);
                lastFrameTimeStamp = now;

//                entityManager.rotatePowerUps(passedTime);
                moveProcess.update(passedTime);
                shootingProcess.update(passedTime);
                collisionProcess.update();
                destroyProcess.update();
                renderProcess.update();
                gameStage.update(now);

				Score.update();

				ActivePowerUpProcess.update(passedTime);

                if(Dreamcatcher.debugMode)
                {
                    CollisionDummyBoxes.update();
                }
            }
		}

        private function onTouch(e:TouchEvent):void
        {
			if(e.getTouch(stage, TouchPhase.BEGAN) && e.getTouch(stage, TouchPhase.BEGAN).tapCount >= 2)
			    PowerUpTrigger.powerUpButton.dispatchEventWith(Event.TRIGGERED);

            var touches:Vector.<Touch> = new Vector.<Touch>();
	        e.getTouches(stage, TouchPhase.BEGAN, touches);
	        e.getTouches(stage, TouchPhase.MOVED, touches);
	        e.getTouches(stage, TouchPhase.ENDED, touches);
	        e.getTouches(stage, TouchPhase.STATIONARY, touches);

            MovementPlayer.touch = null;

	        var player:Entity = entityManager.getEntity(GameConstants.PLAYER);

	        for (var i:int = 0; i < touches.length; i++) {
		        switch (i)
		        {
			        case 0:
			        {
				        if(touches[0].getLocation(stage).x < GameConstants.playerMovementBorder.width)
				        {
					        MovementPlayer.touch = touches[0];
				        }

				        if (touches.length < 2 && player != null && !PowerUpTrigger.powerUpActive && player.weaponSystem != _weaponPlayerStraight && player.weaponSystem != null)
				        {
					        _weaponPlayerPowershot.shootNow();
					        player.switchWeapon(null);
					        Starling.juggler.delayCall(allowShooting, 0.5);
				        }
				        break;
			        }
			        case 1:
			        {
				        if (!PowerUpTrigger.powerUpActive && touches[1].target != PowerUpTrigger.powerUpButton
						  && touches[1].target != GameStage.gameStage.pauseButton)
				        {
					        player.switchWeapon(_weaponPlayerPowershot);
				        }
				        break;
			        }
		        }
	        }

            if(Dreamcatcher.debugMode)
                if(e.getTouch(stage, TouchPhase.HOVER))
                    touchPosition = e.getTouch(stage, TouchPhase.HOVER).getLocation(stage);
        }

        //DEBUG:
        private function debugFunction(e:KeyboardEvent):void
        {
            if(e.keyCode==Keyboard.F1 && (entityManager.getEntity(GameConstants.PLAYER) == null))
                entityManager.createEntity(GameConstants.PLAYER, touchPosition);
            if(e.keyCode==Keyboard.F2)
                entityManager.createEntity(GameConstants.ENEMY, touchPosition);
            if(e.keyCode==Keyboard.F3)
                entityManager.createEntity(GameConstants.VICTIM1, touchPosition);
            if(e.keyCode==Keyboard.F4)
                entityManager.createEntity(GameConstants.BOSS1, touchPosition);
            if(e.keyCode==Keyboard.F5)
                entityManager.createEntity(GameConstants.CHARGER, touchPosition);
            if(e.keyCode==Keyboard.F6)
                entityManager.createEntity(GameConstants.VICTIM2, touchPosition);
            if(e.keyCode==Keyboard.F7)
                entityManager.loadEntities();
            if(e.keyCode==Keyboard.F8)
            {
                if(GameConstants.Player_Default == "Stand")
                    GameConstants.Player_Default = "Walk";
                else
                    GameConstants.Player_Default = "Stand";
            }
            if(e.keyCode==Keyboard.F9)
            {
                entityManager.createEntity(GameConstants.BOSS2, touchPosition);
            }
            if(e.keyCode==Keyboard.F10)
            {
                currentLvl = 1;
            }
            if(e.keyCode==Keyboard.F11)
            {
                HighScoreMenu.showAndHide();
                HighScoreMenu.highScoreMenu.setScore(123456);
            }
            if(e.keyCode==Keyboard.F12)
            {
                entityManager.getEntity("Player").blink(GameConstants.blinkAmount("Player"));
            }
        }

		public static function get weaponPlayerFan():WeaponPlayerFan {
			return _weaponPlayerFan;
		}

		public static function get weaponPlayerPowershot():WeaponPlayerPowershot {
			return _weaponPlayerPowershot;
		}

		public static function get weaponPlayerStraight():WeaponPlayerStraight {
			return _weaponPlayerStraight;
		}
	}
}
