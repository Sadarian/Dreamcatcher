/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 21.02.13
 * Time: 10:33
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.events.Event;

	public class PowerUpTrigger
	{
		private static var powerUpButton:Button;
		private static var activeButton:String;
		private static var activePowerUp:String;
		private static var durationTime:Number;
		private static var _powerUpActive:Boolean = false;
		private static var player:Entity;

		public static function addPowerUp(powerUp:Entity, playerE:Entity):void
		{
			player = playerE;

			switch (powerUp.name)
			{
				case GameConstants.POWERUP_FIRE_RATE:
				{

					if (activeButton != null && activeButton != powerUp.name)
					{
						deleteButton();
					}

					if (activeButton == null)
					{
						createButton(GameConstants.POWERUP_FIRE_RATE, powerUp);
					}

					break;
				}
				case GameConstants.POWERUP_FREEZE:
				{

					if (activeButton != null && activeButton != powerUp.name)
					{
						deleteButton();
					}

					if (activeButton == null)
					{
						createButton(GameConstants.POWERUP_FREEZE, powerUp);
					}
					break;
				}
				case GameConstants.POWERUP_HEALTH:
				{
					player.health += GameConstants.healthGiven;
				}
			}
		}

		private static function createButton(name:String, powerUp:Entity):void
		{
			if (activeButton == null)
			{
				activeButton = name;
				powerUpButton = new Button(GraphicsManager.graphicsManager.getTexture(name));
				powerUpButton.x = Starling.current.viewPort.width  - powerUp.collisionValues.x * 2 - 20;
				powerUpButton.y = Starling.current.viewPort.height - powerUp.collisionValues.y * 2 - 20;
				GameStage.gameStage.addChild(powerUpButton);
				powerUpButton.addEventListener(Event.TRIGGERED, onButtonClick)
			}
		}

		private static function onButtonClick(event:Event):void
		{
			_powerUpActive = true;
			switch (activeButton)
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
			deleteButton();
		}



		private static function deleteButton():void
		{
			activeButton = null;
			GameStage.gameStage.removeActor(powerUpButton);
			powerUpButton.addEventListener(Event.TRIGGERED, onButtonClick);
			powerUpButton = null;
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
				if (!(entity.name.search(GameConstants.PLAYER) >= 0))
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
	}
}
