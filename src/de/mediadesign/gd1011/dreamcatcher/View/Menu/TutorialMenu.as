package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementCharger;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPlayer;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	import flash.geom.Point;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.deg2rad;

	public class TutorialMenu extends Sprite
	{
		private static var self:TutorialMenu;
		private static var _active:Boolean = false;
		private static var player:Entity;
		private static var screen:Sprite = new Sprite();
		private static var greyScreen:Quad;
		private static var textBox:TextField;
		private static var moved:int = 0;
		private static var powerUpCollected:Boolean = false;
		private static var passedSecs:Number = 0;
		private static var repeatCount:int = 0;
		private static var allowSpawning:Boolean = false;
		private static var enemy:Entity;

		private static var introductionReminder:TextField;

		private static var arrow:Image;
		private static var finger:Image;

		public static var MOVEMENT:String = "Movement";
		public static var SHOOTING:String = "Shooting";
		public static var POWERUP:String = "PowerUp";
		public static var USEPOWERUP:String = "UsePowerUp";
		public static var STACKPOWERUP:String = "StackPowerUp";
		public static var ENEMYAPPEARS:String = "EnemyAppears";
		public static var LOSELIFE:String = "LoseLife";
		public static var GETLIFE:String = "GetLife";
		public static var THEENDE:String = "TheEnd";

		private static var _phase:String;

		public function TutorialMenu()
		{

		}

		public static function init():void
		{
			arrow = GraphicsManager.graphicsManager.getImage("tutorialArrow");
			finger = GraphicsManager.graphicsManager.getImage("tutorialFinger");
			finger.pivotX = finger.width/2;
			finger.pivotY = finger.height/2;

			player = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
			player.switchMovement(null);
			player.switchWeapon(null);

			greyScreen = new Quad(Starling.current.viewPort.width,Starling.current.viewPort.height, 0x000000);
			screen.addChild(greyScreen);
			screen.alpha = 0.5;
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
					Starling.juggler.delayCall(functionToCall, 3, args);
				else
					Starling.juggler.delayCall(functionToCall, 3);
			}
		}

		private static function switchTo(phase:String):void
		{
			if(phase == _phase)
				return;
			_phase = phase;
			switch (_phase)
			{
				case MOVEMENT:
				{
					showHideGreyScreen();
					showHideText();
					introductionReminder = new TextField(400, 200, "Drag Player to move", "TutorialFont", 30, 0xffffff, true);
					introductionReminder.x = 190;
					introductionReminder.y = 650;
					introductionReminder.pivotX = introductionReminder.width/2;
					introductionReminder.pivotY = introductionReminder.height/2;
					introductionReminder.rotation = deg2rad(20);
					tutorialMenu.addChild(introductionReminder);
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
					Starling.juggler.delayCall(EntityManager.entityManager.createEntity, 4, GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height/2));
					Starling.juggler.delayCall(tutorialMenu.addChild, 4, introductionReminder);
					introductionReminder.text = "Collect a Power up!";
					break;
				}

				case USEPOWERUP:
				{
					Starling.juggler.delayCall(switchTextTo, 1, "Trigger Power-Up by pressing the Button", showHideText);

					Starling.juggler.delayCall(tutorialMenu.addChild, 3, introductionReminder);
					introductionReminder.text = "Use The Power up!";

					tutorialMenu.addChild(arrow);
					arrow.x = 1100;
					arrow.y = 700;
					arrow.rotation = deg2rad(220);

					break;
				}

				case STACKPOWERUP:
				{
					showHideText();
					for (var i:int = 1; i <= 6; i++)
					{
						Starling.juggler.delayCall(EntityManager.entityManager.createEntity, 0.25*i, GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 50, 200+(60*i)));
					}
					Starling.juggler.delayCall(switchTextTo, 6, "Double Tapping the Dreamcatcher also triggers Power-Ups");
					Starling.juggler.delayCall(switchTextTo, 9,"Power-Ups have 3 charging states", showHideText);
					break;
				}
				case ENEMYAPPEARS:
				{
					var enemy:Entity = EntityManager.entityManager.createEntity(GameConstants.ENEMY, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
					enemy.switchWeapon(null);
					break;
				}
				case LOSELIFE:
				{
					tutorialMenu.addChild(arrow);
					arrow.x = 150;
					arrow.y = 100;
					arrow.rotation = deg2rad(45);
					switchTextTo("Doge their pucke!", showHideText);
					break;
				}
				case GETLIFE:
				{
					player.health = 10;
					Starling.juggler.delayCall(tutorialMenu.addChild, 2, introductionReminder);
					introductionReminder.text = "Collect Health to survive!";
					switchTextTo("Collect Health to survive!", showHideText);
					break;
				}
				case THEENDE:
				{
					tutorialMenu.removeChild(introductionReminder);
					switchTextTo("Your first Mission awaits!", showHideGreyScreen);
					Starling.juggler.delayCall(fadeIn, 3, screen);
					greyScreen.color = 0x000000;
					screen.alpha = 0;
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
						passedSecs += passedTime;
						if (!player.position.equals(GameConstants.playerStartPosition) && moved == 0)
						{
							moved = 1;
						}
						else if ((passedSecs >= 5|| tutorialMenu.contains(finger)) && moved == 0)
						{
							if (!tutorialMenu.contains(finger))
							{
								passedSecs = 0;
								tutorialMenu.addChild(finger);
								finger.x = GameConstants.playerStartPosition.x + 50;
								finger.y = GameConstants.playerStartPosition.y - 50;
								moveTo(finger);
							}
							else if(finger.x != GameConstants.playerStartPosition.x && passedSecs >= 2)
							{
								passedSecs = 0;
								finger.x = GameConstants.playerStartPosition.x + 50;
								finger.y = GameConstants.playerStartPosition.y - 50;
								moveTo(finger);
							}
						}
						if (moved == 1)
						{
							if (tutorialMenu.contains(finger))
							{
								tutorialMenu.removeChild(finger);
							}
							moved = 2;
							passedSecs = 0;
							tutorialMenu.removeChild(introductionReminder);
							Starling.juggler.delayCall(switchTextTo, 2, "You can move him everywhere!", switchTo, SHOOTING);
						}
						break;
					}

					case SHOOTING:
					{
						if (player.weaponSystem == Game.weaponPlayerStraight)
						{
							passedSecs = 0;
							switchTo(POWERUP);
						}
						break;
					}

					case POWERUP:
					{
						passedSecs += passedTime;
						if (PowerUpTrigger.powerUpCollected && !powerUpCollected)
						{
							tutorialMenu.removeChild(introductionReminder);
							powerUpCollected = true;
							switchTo(USEPOWERUP);
							passedSecs = 0;
						}
						if (passedSecs >= 11 && !powerUpCollected)
						{
							EntityManager.entityManager.createEntity(GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
							passedSecs = 0;
						}
						break;
					}

					case USEPOWERUP:
					{
						if (!PowerUpTrigger.powerUpCollected && powerUpCollected)
						{
							tutorialMenu.removeChild(arrow);
							tutorialMenu.removeChild(introductionReminder);
							powerUpCollected = false;
							switchTextTo("You can also stack Power-Ups");
							Starling.juggler.delayCall(switchTextTo, 3, "Stack Power-Ups and trigger them!", switchTo, STACKPOWERUP);
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
							EntityManager.entityManager.createEntity(GameConstants.POWERUP_FIRE_RATE, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
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
							Starling.juggler.delayCall(tutorialMenu.addChild, 2, introductionReminder);
							introductionReminder.text = "Kill Everything!";
							switchTo(ENEMYAPPEARS);
						}
						break;
					}
					case ENEMYAPPEARS:
					{
						passedSecs += passedTime;
						if (repeatCount == 5 && allowSpawning && passedSecs >= 2)
						{
							passedSecs = 0;
							repeatCount++;
							allowSpawning = false;
							enemy = EntityManager.entityManager.createEntity(GameConstants.ENEMY, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
							enemy.switchWeapon(null);
							enemy.switchMovement(new MovementCharger());
							enemy.maxHealth = 100;
							enemy.health = 100;
						}
						else if (repeatCount <= 4)
						{
							if (passedSecs >= 5 && !allowSpawning)
							{
								allowSpawning = true;
							}

							if (passedSecs >= 2 && allowSpawning)
							{
								repeatCount++;
								passedSecs = 0;
								enemy = EntityManager.entityManager.createEntity(GameConstants.ENEMY, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
								enemy.switchWeapon(null);
							}
						}
						else
						{
							if (player.health != player.maxHealth)
							{
								passedSecs = 0;
								repeatCount = 0;
								tutorialMenu.removeChild(introductionReminder);
								switchTextTo("Donâ€™t get hit!");
								switchTo(LOSELIFE);
							}
							else if(!enemy)
							{
								allowSpawning = true;
							}
						}
						break;
					}
					case LOSELIFE:
					{
						passedSecs += passedTime;
						if (repeatCount == 10 && allowSpawning)
						{
							passedSecs = 0;
							repeatCount = 0;
							allowSpawning = false;
							for each (var entityA:Entity in EntityManager.entityManager.entities)
							{
								if (entityA.isEnemy && entityA.health > 0)
								{
									entityA.health = 0;
								}
							}
							switchTo(GETLIFE);
						}
						else if (repeatCount < 10)
						{
							if (passedSecs >= 3 && !allowSpawning)
							{
								allowSpawning = true;
								tutorialMenu.removeChild(arrow);
							}
							if (passedSecs >= 1.5 && allowSpawning)
							{
								repeatCount++;
								passedSecs = 0;
								enemy = EntityManager.entityManager.createEntity(GameConstants.ENEMY, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
							}
						}
						break;
					}
					case GETLIFE:
					{
						passedSecs += passedTime;
						if (player.health == player.maxHealth)
						{
							player.switchMovement(null);
							player.switchWeapon(null);
							switchTo(THEENDE);
							for each (var entity:Entity in EntityManager.entityManager.entities)
							{
								if (entity.isPowerUp && entity.health > 0)
								{
									entity.health = 0;
								}
							}
						}
						else
						{
							if (passedSecs >= 3 && !allowSpawning)
							{
								allowSpawning = true;
							}
							if (passedSecs >= 1 && allowSpawning)
							{
								passedSecs = 0;
								repeatCount++;
								EntityManager.entityManager.createEntity(GameConstants.POWERUP_HEALTH, new Point(Starling.current.viewPort.width - 50, Starling.current.viewPort.height - 200 - 300 * Math.random()));
							}
						}
						break;
					}
					case THEENDE:
					{
						if (screen.alpha == 1)
						{
							GraphicsManager.graphicsManager.playSound("evilLaugh");
							showAndHide();
							GameStage.gameStage.resetAll();
							if (YesNoMenu.selectetLvl != GameConstants.TUTORIAL)
							{
								TutorialMenu.showAndHide();
								(Starling.current.root as Game).startLevel(YesNoMenu.selectetLvl);
							}
							else
							{
								GraphicsManager.graphicsManager.loadDataFor("UI", MainMenu.showAndHide);
							}
						}
						break;
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
			var text:TextField = new TextField(800, 200, s, "TutorialFont", 50 ,0xffffff, true);
			text.pivotX = text.width/2;
			text.pivotY = text.height/2;
			text.x = Starling.current.viewPort.width/2;
			text.y = Starling.current.viewPort.height/2;
			text.autoScale = true;
			return text;
		}

		private static function showHideGreyScreen():void
		{
			if (tutorialMenu.contains(screen))
			{
				tutorialMenu.removeChild(screen);
			}
			else
			{
				tutorialMenu.addChildAt(screen, 0);
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

		private static function fadeIn(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween(tweenObject,2,Transitions.EASE_IN);
			mTween.fadeTo(1);
			Starling.juggler.add(mTween);

		}

		private static function moveTo(tweenObject:DisplayObject):Function
		{
			var moveToTween:Tween = new Tween(tweenObject, 1, Transitions.EASE_IN);
			moveToTween.moveTo(GameConstants.playerStartPosition.x + 50 + 200, GameConstants.playerStartPosition.y - 50);
			Starling.juggler.add(moveToTween);
			return null;
		}

		public static function resetTutorial():void
		{
			if(!self) return;
			_phase = null;
			self.dispose();
			self = null;
		}

		public static function isActive():Boolean {
			return _active;
		}
	}
}
