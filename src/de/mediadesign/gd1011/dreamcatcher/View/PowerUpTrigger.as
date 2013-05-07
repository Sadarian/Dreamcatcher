/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 21.02.13
 * Time: 10:33
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerFan;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerStraight;

	import starling.animation.Transitions;
	import starling.animation.Tween;

	import starling.core.Starling;

	import starling.display.Button;
	import starling.display.DisplayObject;

	import starling.display.Image;
	import starling.events.Event;

	public class PowerUpTrigger
	{

		private static var powerUpIcon:Image;
		private static var activeIcon:String;
		private static var stack:int = 0;
		private static var _activeStack:int = 0;
		private static var _powerUpButton:Button;
		private static var _activePowerUp:String;
		private static var durationTime:Number;
		private static var _powerUpActive:Boolean = false;
		private static var player:Entity;
		private static var initialized:Boolean = false;
		private static var freezeOverlay:Image;
		private static var healthIncrease:AnimatedModel;
		private static var playerHealthIncrease:AnimatedModel;
		private static var _healthIncreased:Boolean = false;

		public static function addPowerUp(powerUp:Entity, playerE:Entity):void
		{
			player = playerE;
			GraphicsManager.graphicsManager.playSound("PickUpPowerUp");

			switch (powerUp.name)
			{
				case GameConstants.POWERUP_FIRE_RATE:
				{
					if (activeIcon != GameConstants.POWERUP_FIRE_RATE)
					{
						createPowerUpIcon(GameConstants.POWERUP_FIRE_RATE, powerUp, stack+1);

						stack++;
					}
					else
					{
						if (stack < 3)
						{
                            powerUpIcon.texture = GraphicsManager.graphicsManager.getTexture(GameConstants.POWERUP_FIRE_RATE+(stack+1));

							stack++;
						}
					}
					trace(stack);

					break;
				}
				case GameConstants.POWERUP_FREEZE:
				{
					createPowerUpIcon(GameConstants.POWERUP_FREEZE, powerUp);
					break;
				}
				case GameConstants.POWERUP_HEALTH:
				{
					_healthIncreased = true;

					player.health += GameConstants.healthGiven;
                    GraphicsManager.graphicsManager.playSound("HealthIncrease");

					if (healthIncrease == null)
					{
						healthIncrease = new AnimatedModel("LifebarHealthIncrease", new Array(), "Default");

						healthIncrease.start();
						healthIncrease.x = 142;
						healthIncrease.y = 122;
						healthIncrease.ActualAnimation.loop = false;
						GameStage.gameStage.addChild(healthIncrease);

						playerHealthIncrease = new AnimatedModel("PlayerHealthIncrease", new Array(), "Default");
						playerHealthIncrease.start();
						playerHealthIncrease.x = playerE.position.x;
						playerHealthIncrease.y = playerE.position.y;
						playerHealthIncrease.ActualAnimation.loop = false;
						GameStage.gameStage.addChild(playerHealthIncrease);
					}
					else
					{
						healthIncrease.alpha = 1;
						healthIncrease.start();

						playerHealthIncrease.alpha = 1;
						playerHealthIncrease.start();
						playerHealthIncrease.x = playerE.position.x;
						playerHealthIncrease.y = playerE.position.y;
					}
				}
			}
		}

		public static function init():void
		{
			createButton();
			initialized = true;

			freezeOverlay = new Image(GraphicsManager.graphicsManager.getTexture("FreezeFeedback"));
			freezeOverlay.alpha = 0;
			freezeOverlay.touchable = false;
			GameStage.gameStage.addChild(freezeOverlay);
		}

		private static function createPowerUpIcon(name:String, powerUp:Entity, stackCount:int = 1):void
		{
			if (activeIcon == null)
			{
				activeIcon = name;

				if (powerUpIcon == null)
				{
					powerUpIcon = new Image(GraphicsManager.graphicsManager.getTexture((stackCount>1)?name+stackCount:name));
					GameStage.gameStage.addChild(powerUpIcon);
					powerUpIcon.x = powerUp.collisionValues.x - 9;
					powerUpIcon.y = powerUp.collisionValues.y * 2 + 40;
					powerUpIcon.scaleX = 0.93;
					powerUpIcon.scaleY = 0.93;
				}
				else
				{
					GameStage.gameStage.addChild(powerUpIcon);
					powerUpIcon.texture = GraphicsManager.graphicsManager.getTexture((stackCount>1)?name+stackCount:name);
				}

				if (!_powerUpActive)
				{
					_powerUpButton.enabled = true;
					_powerUpButton.upState = GraphicsManager.graphicsManager.getTexture("UsePower_2");
				}
			}
			else if(activeIcon != name)
			{
				activeIcon = name;
				GameStage.gameStage.addChild(powerUpIcon);
				powerUpIcon.texture = GraphicsManager.graphicsManager.getTexture(name);
				stackCount = 1;

				if (!_powerUpActive)
				{
					_powerUpButton.enabled = true;
					_powerUpButton.upState = GraphicsManager.graphicsManager.getTexture("UsePower_2");
				}
			}
		}

		private static function createButton():void
		{
			_powerUpButton = new Button(GraphicsManager.graphicsManager.getTexture("UsePower_1"));
			_powerUpButton.x = Starling.current.viewPort.width - _powerUpButton.width;
			_powerUpButton.y = Starling.current.viewPort.height - _powerUpButton.height;
			_powerUpButton.addEventListener(Event.TRIGGERED, onButtonClick);
			_powerUpButton.alphaWhenDisabled = 0.5;
			deactivateButton();
			GameStage.gameStage.addChild(_powerUpButton);
		}

		private static function onButtonClick(event:Event):void
		{
			if (_powerUpButton.enabled)
			{
				GraphicsManager.graphicsManager.playSound("UseUpPowerUp");
				_powerUpActive = true;
				_activeStack = stack;
				switch (activeIcon) {
					case GameConstants.POWERUP_FIRE_RATE:
					{
						increaseFireRate();
						break;
					}
					case GameConstants.POWERUP_FREEZE:
					{
						freeze();
						break;
					}
				}
				deactivateButton();
				trace(stack);
				stack = 0;
			}
		}

		private static function deactivateButton():void
		{
			activeIcon = null;
			GameStage.gameStage.removeActor(powerUpIcon);
			_powerUpButton.enabled = false;
			_powerUpButton.upState = GraphicsManager.graphicsManager.getTexture("UsePower_1");
		}

		public static function deleteButton():void
		{
			if (activeIcon != null)
				activeIcon = null;

			if (powerUpIcon != null)
			{
				GameStage.gameStage.removeActor(powerUpIcon);
				powerUpIcon.dispose();
			}
			GameStage.gameStage.removeActor(_powerUpButton);
			_powerUpButton.removeEventListener(Event.TRIGGERED, onButtonClick);
			_powerUpButton.dispose();
		}

		private static function increaseFireRate():void
		{
			_activePowerUp = GameConstants.POWERUP_FIRE_RATE;
			durationTime = GameConstants.durationFireRate;

			switch(_activeStack)
			{
				case 1:
				{
					player.increaseWeaponSpeed(GameConstants.fireRateIncrease);
					break;
				}

				case 2:
				{
					player.increaseWeaponSpeed(GameConstants.fireRateIncrease/2);
					break;
				}

				case 3:
				{
					player.switchWeapon(Game.weaponPlayerFan);
					player.setWeaponSpeed();
					break;
				}
			}
		}

		private static function freeze():void
		{
			_activePowerUp = GameConstants.POWERUP_FREEZE;
			durationTime = GameConstants.durationFreeze;

			fadeIn(freezeOverlay);

			for each (var entity:Entity in EntityManager.entityManager.entities)
			{
				if (entity.name.search(GameConstants.PLAYER) == -1 && !entity.isSlowed)
				{
					entity.increaseMovementSpeed(GameConstants.slowEffect);
					entity.increaseWeaponSpeed(GameConstants.slowEffect);
					entity.isSlowed = true;
				}
			}
		}

		public static function updateDuration(deltaTime:Number):void
		{
			durationTime -= deltaTime;

			var entity:Entity;

			if (durationTime <= 0)
			{
				endPowerUp();
			}
            else if(_activePowerUp == GameConstants.POWERUP_FIRE_RATE)
            {
                for each (entity in EntityManager.entityManager.entities)
                    if (entity.name == GameConstants.PLAYER_BULLET && entity.movementSystem)
                    {
                        entity.movementSystem.speed = GameConstants.playerBulletsPowerUpSpeed;
                        (entity.movementSystem as MovementBullet).updateVelocity();
                    }

            }
			else if (_activePowerUp == GameConstants.POWERUP_FREEZE)
			{
				for each (entity in EntityManager.entityManager.entities)
				{
					if (entity.name.search(GameConstants.PLAYER) == -1 && !entity.isSlowed)
					{
						entity.increaseMovementSpeed(GameConstants.slowEffect);
						entity.increaseWeaponSpeed(GameConstants.slowEffect);
						entity.isSlowed = true;
					}
				}
			}
		}

		public static function updateHealthIncrease():void
		{
			playerHealthIncrease.x = player.position.x;
			playerHealthIncrease.y = player.position.y;

			if (healthIncrease.ActualAnimation.isComplete)
			{
				healthIncrease.ActualAnimation.stop()
				healthIncrease.alpha = 0;
			}

			if (playerHealthIncrease.ActualAnimation.isComplete)
			{
				playerHealthIncrease.ActualAnimation.stop()
				playerHealthIncrease.alpha = 0;
			}

			if (healthIncrease.ActualAnimation.isComplete && playerHealthIncrease.ActualAnimation.isComplete)
			{
				_healthIncreased = false;
			}
		}

		private static function endPowerUp():void
		{
			_powerUpActive = false;

			if (activeIcon != null)
			{
				_powerUpButton.enabled = true;
				_powerUpButton.upState = GraphicsManager.graphicsManager.getTexture("UsePower_2");
			}

			switch (_activePowerUp)
			{
				case GameConstants.POWERUP_FIRE_RATE:
				{
					if(_activeStack == 3)player.switchWeapon(Game.weaponPlayerStraight);
					player.setWeaponSpeed();

					_activeStack = 0;
					_activePowerUp = null;
					break;
				}
				case GameConstants.POWERUP_FREEZE:
				{
					fadeOut(freezeOverlay);
					for each (var entity:Entity in EntityManager.entityManager.entities)
					{
						if (!(entity.name.search(GameConstants.PLAYER) >= 0))
						{
							entity.setMovementSpeed();
							entity.setWeaponSpeed();
						}
					}
					_activeStack = 0;
					_activePowerUp = null;
					break;
				}
			}
		}

		private static function fadeIn(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,1.5,Transitions.EASE_IN);
			mTween.fadeTo(1);
			Starling.juggler.add(mTween);

		}

		private static function fadeOut(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,1,Transitions.EASE_OUT);
			mTween.fadeTo(0);
			Starling.juggler.add(mTween);
		}

		public static function get powerUpActive():Boolean
		{
			return _powerUpActive;
		}

        public static function get powerUpButton():Button
        {
            return _powerUpButton;
        }

		public static function get activeStack():int
		{
			return _activeStack;
		}

		public static function get activePowerUp():String
		{
			return _activePowerUp;
		}

		public static function get healthIncreased():Boolean {
			return _healthIncreased;
		}
	}
}
