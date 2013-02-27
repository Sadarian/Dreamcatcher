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
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;

    import starling.core.Starling;

	import starling.display.Button;

	import starling.display.Image;
	import starling.events.Event;

	public class PowerUpTrigger
	{

		private static var powerUpIcon:Image;
		private static var activeIcon:String;
		private static var _powerUpButton:Button;
		private static var activeButton:String;
		private static var activePowerUp:String;
		private static var durationTime:Number;
		private static var _powerUpActive:Boolean = false;
		private static var player:Entity;
		private static var initialized:Boolean = false;

		public static function addPowerUp(powerUp:Entity, playerE:Entity):void
		{
			player = playerE;
			GraphicsManager.graphicsManager.playSound("PickUpPowerUp");

			switch (powerUp.name)
			{
				case GameConstants.POWERUP_FIRE_RATE:
				{
					createPowerUpIcon(GameConstants.POWERUP_FIRE_RATE, powerUp);

					break;
				}
				case GameConstants.POWERUP_FREEZE:
				{
					createPowerUpIcon(GameConstants.POWERUP_FREEZE, powerUp);
					break;
				}
				case GameConstants.POWERUP_HEALTH:
				{
					player.health += GameConstants.healthGiven;
				}
			}
		}

		public static function init():void
		{
			createButton();
			initialized = true;
		}

		private static function createPowerUpIcon(name:String, powerUp:Entity):void
		{
			if (activeIcon == null)
			{

				activeIcon = name;

				if (powerUpIcon == null)
				{
					powerUpIcon = new Image(GraphicsManager.graphicsManager.getTexture(name));
					GameStage.gameStage.addChild(powerUpIcon);
					powerUpIcon.x = powerUp.collisionValues.x * 2 - 9;
					powerUpIcon.y = powerUp.collisionValues.y * 2 + 12;
					powerUpIcon.scaleX = 0.93;
					powerUpIcon.scaleY = 0.93;
				}
				else
				{
					GameStage.gameStage.addChild(powerUpIcon);
					powerUpIcon.texture = GraphicsManager.graphicsManager.getTexture(name);
				}
				_powerUpButton.enabled = true;
				_powerUpButton.upState = GraphicsManager.graphicsManager.getTexture("UsePower_2");

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
			GraphicsManager.graphicsManager.playSound("UseUpPowerUp");
			_powerUpActive = true;
			switch (activeIcon)
			{
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
			activePowerUp = GameConstants.POWERUP_FIRE_RATE;
			durationTime = GameConstants.durationFireRate;

			player.increaseWeaponSpeed(GameConstants.fireRateIncrease);
		}

		private static function freeze():void
		{
			activePowerUp = GameConstants.POWERUP_FREEZE;
			durationTime = GameConstants.durationFreeze;

			for each (var entity:Entity in EntityManager.entityManager.entities)
			{
				if (entity.name.search(GameConstants.PLAYER) == -1)
				{
					entity.increaseMovementSpeed(GameConstants.slowEffect);
					entity.increaseWeaponSpeed(GameConstants.slowEffect);
				}
			}
		}

		public static function updateDuration(deltaTime:Number):void
		{
			durationTime -= deltaTime;

			if (durationTime <= 0)
			{
				endPowerUp();
			}
            else if(activePowerUp == GameConstants.POWERUP_FIRE_RATE)
            {
                for each (var entity:Entity in EntityManager.entityManager.entities)
                    if (entity.name == GameConstants.PLAYER_BULLET && entity.movementSystem)
                    {
                        entity.movementSystem.speed = GameConstants.playerBulletsPowerUpSpeed;
                        (entity.movementSystem as MovementBullet).updateVelocity();
                    }

            }
		}

		private static function endPowerUp():void
		{
			_powerUpActive = false;

			switch (activePowerUp)
			{
				case GameConstants.POWERUP_FIRE_RATE:
				{
					player.setWeaponSpeed();
					break;
				}
				case GameConstants.POWERUP_FREEZE:
				{
					for each (var entity:Entity in EntityManager.entityManager.entities)
					{
						if (!(entity.name.search(GameConstants.PLAYER) >= 0))
						{
							entity.setMovementSpeed();
							entity.setWeaponSpeed();
						}
					}
					break;
				}
			}
		}

		public static function get powerUpActive():Boolean
		{
			return _powerUpActive;
		}

        public static function get powerUpButton():Button
        {
            return _powerUpButton;
        }
    }
}
