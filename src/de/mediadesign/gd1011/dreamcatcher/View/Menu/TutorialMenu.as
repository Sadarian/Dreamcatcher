package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPlayer;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	import flash.geom.Point;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class TutorialMenu extends Sprite
	{
		private static var self:TutorialMenu;
		private static var _active:Boolean = false;
		private static var player:Entity;
		private static var greyScreen:Sprite = new Sprite();
		private static var textBox:TextField;
		private static var moved:int = 0;
		private static var powerUpCollected:Boolean = false;
		private static var passedSecs:Number = 0;
		private static var repeatCount:int = 0;
		private static var allowSpawning:Boolean = false;

		public static var MOVEMENT:String = "Movement";
		public static var SHOOTING:String = "Shooting";
		public static var POWERUP:String = "PowerUp";
		public static var USEPOWERUP:String = "UsePowerUp";
		public static var STACKPOWERUP:String = "StackPowerUp";
		public static var ENEMYAPPEARS:String = "EnemyAppears";

		private static var _phase:String;

		private static var mElements:Vector.<DisplayObject>;

		public function TutorialMenu()
		{
			(Starling.current.root as Game).startLevel(GameConstants.TUTORIAL);
		}

		public static function init():void
		{
			var gM:GraphicsManager = GraphicsManager.graphicsManager;
			player = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
			player.switchMovement(null);
			player.switchWeapon(null);

			mElements = new Vector.<DisplayObject>();

			var buttonStrings:Array = [	"TutorialBackButton", "TutorialBackButtonClick"];
			var positions:Array = [[40, 650]];
			var button:Button;
			for(var i:int = 0; i<buttonStrings.length;i+=2)
			{
				button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]));
				button.enabled = true;
				button.x = positions[i/2][0];
				button.y = positions[i/2][1];
				button.name = buttonStrings[i];
				button.addEventListener(Event.TRIGGERED, onTriggered);
				tutorialMenu.addChild(button);
				mElements.push(button);
			}

			greyScreen.addChild(new Quad(Starling.current.viewPort.width,Starling.current.viewPort.height, 0x000000));
			greyScreen.alpha = 0.5;
			showHideGreyScreen();

			textBox = createTextField("Welcome to the Tutorial");
			showHideText();

			Starling.juggler.delayCall(switchTextTo, 2, "Drag the Dreamcatcher to move", switchTo, MOVEMENT);

		}

		private static function switchTextTo(s:String,functionToCall:Function = null,...args):void
		{
			if (!tutorialMenu.contains(textBox))
			{
				showHideText()
			}
			textBox.text = s;

			if (functionToCall != null)
			{
				if (args.length > 0)
					Starling.juggler.delayCall(functionToCall, 2, args);
				else
					Starling.juggler.delayCall(functionToCall, 2);
			}
		}

		private static function switchTo(phase:String):void
		{
			if(phase == _phase)
				return;
			_phase = phase
			switch (_phase)
			{
				case MOVEMENT:
				{
					showHideGreyScreen();
					showHideText();
					player.switchMovement(new MovementPlayer());
					break;
				}
				case SHOOTING:
				{
					Starling.juggler.delayCall(switchTextTo, 2, "You shoot automaticly!", showHideText);
					Starling.juggler.delayCall(player.switchWeapon, 4, Game.weaponPlayerStraight);
					break;
				}

				case POWERUP:
				{
					Starling.juggler.delayCall(switchTextTo, 2, "Collect a Power up!", showHideText);
					Starling.juggler.delayCall(EntityManager.entityManager.createEntity, 4, GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 100, Starling.current.viewPort.height/2));
					break;
				}

				case USEPOWERUP:
				{
					Starling.juggler.delayCall(showHideText, 3);
					break;
				}

				case STACKPOWERUP:
				{
					for (var i:int = 1; i <= 6; i++)
					{
						Starling.juggler.delayCall(EntityManager.entityManager.createEntity, 0.25*i, GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 100, 200+(60*i)));
					}
					Starling.juggler.delayCall(switchTextTo, 3, "Double Tapping the Dreamcatcher also triggers Power-Ups");
					Starling.juggler.delayCall(switchTextTo, 6,"Power-Ups have 3 charging states", showHideText);
					break;
				}
				case ENEMYAPPEARS:
				{
					var enemy:Entity = EntityManager.entityManager.createEntity(GameConstants.ENEMY, new Point(Starling.current.viewPort.width - 100, Starling.current.viewPort.height/2));
					enemy.switchWeapon(null);
					break;
				}
			}
		}

		public static function update(passedTime:Number):void
		{
			if (_phase)
			{
				switch (_phase)
				{
					case MOVEMENT:
					{
						if (!player.position.equals(GameConstants.playerStartPosition) && moved == 0)
						{
							moved = 1;
						}
						if (moved == 1)
						{
							moved = 2;
							Starling.juggler.delayCall(switchTextTo, 2, "You can move him everywhere!", switchTo, SHOOTING);
						}
						break;
					}

					case SHOOTING:
					{
						if (player.weaponSystem == Game.weaponPlayerStraight)
						{
							switchTo(POWERUP);
						}
						break;
					}

					case POWERUP:
					{
						passedSecs += passedTime;
						if (PowerUpTrigger.powerUpCollected && !powerUpCollected)
						{
							powerUpCollected = true;
							switchTextTo("Trigger Power-Up by pressing the Button");
							switchTo(USEPOWERUP);
							passedSecs = 0;
						}
						if (passedSecs >= 11 && !powerUpCollected)
						{
							EntityManager.entityManager.createEntity(GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 100, Starling.current.viewPort.height/2));
							passedSecs = 0;
						}
						break;
					}

					case USEPOWERUP:
					{
						if (!PowerUpTrigger.powerUpCollected && powerUpCollected)
						{
							powerUpCollected = false;
							switchTextTo("You can also stack Power-Ups");
							Starling.juggler.delayCall(switchTextTo, 2, "Stack Power-Ups and trigger them!", switchTo, STACKPOWERUP);
						}
						break;
					}

					case STACKPOWERUP:
					{
						passedSecs += passedTime;
						if (passedSecs >= 7 && !allowSpawning)
						{
							allowSpawning = true;
						}
						if (passedSecs >= 2 && allowSpawning)
						{
							passedSecs = 0;
							repeatCount++;
							EntityManager.entityManager.createEntity(GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 100, Starling.current.viewPort.height/2));
						}
						if (repeatCount == 7 && allowSpawning)
						{
							passedSecs = 0;
							allowSpawning = false;
						}

						if(passedSecs >= 6 && repeatCount == 7)
						{
							repeatCount = 0;
							passedSecs = 0;
							switchTextTo("Kill Everything!", showHideText);
							switchTo(ENEMYAPPEARS);
						}
					}
				}

			}
		}

		private static function showHideText():void
		{
			if (tutorialMenu.contains(textBox))
			{
				tutorialMenu.removeChild(textBox);
			}
			else
			{
				tutorialMenu.addChild(textBox);
			}
		}

		private static function createTextField(s:String):TextField
		{
			var text:TextField = new TextField(500, 200, s, "TutorialFont", 50 ,0xffffff, true);
			text.pivotX = text.width/2;
			text.pivotY = text.height/2;
			text.x = Starling.current.viewPort.width/2;
			text.y = Starling.current.viewPort.height/2;
			text.autoScale = true;
			return text;
		}

		private static function showHideGreyScreen():void
		{
			if (tutorialMenu.contains(greyScreen))
			{
				tutorialMenu.removeChild(greyScreen);
			}
			else
			{
				tutorialMenu.addChildAt(greyScreen, 0);
			}
		}

		private static function onTriggered(e:Event):void
		{
			switch(e.currentTarget)
			{
				case(mElements[0]):
					GraphicsManager.graphicsManager.playSound("evilLaugh");
					showAndHide();
					GameStage.gameStage.resetAll();
					(Starling.current.root as Game).startLevel(YesNoMenu.selectetLvl);
					break;
				case(mElements[1]):

					break;
			}
		}

		public static function get tutorialMenu():TutorialMenu
		{
			if(!self)
				self = new TutorialMenu();
			return self;
		}

		public static function showAndHide():void
		{
			if(!_active)
			{
                self = null;
				_active = true;
				(Starling.current.root as Game).addChild(tutorialMenu);
			}
			else
			{
				_active = false;
				(Starling.current.root as Game).removeChild(tutorialMenu);

			}
		}

		private function fadeIn(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,2,Transitions.EASE_IN);
			mTween.fadeTo(1);
			Starling.juggler.add(mTween);

		}

		private function fadeOut(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,2,Transitions.EASE_OUT);
			mTween.fadeTo(0);
			Starling.juggler.add(mTween);
		}

		public static function isActive():Boolean {
			return _active;
		}
	}
}
