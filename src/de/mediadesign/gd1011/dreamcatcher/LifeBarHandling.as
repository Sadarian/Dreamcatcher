/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 14.02.13
 * Time: 08:01
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {
	import de.mediadesign.gd1011.dreamcatcher.GameStage;

	import flash.geom.Point;
	import flash.html.ControlInitializationError;

	import starling.display.Image;

	public class LifeBarHandling
	{
		private var lifeBar:Image;
		private var life:Number;
		private var name:String;

		public function LifeBarHandling(entity:Entity, position:Point = null)
		{
			if (entity.name == GameConstants.PLAYER)
			{
				position = new Point(20, 30);
			}
			else if (entity.name == GameConstants.BOSS)
			{
				position = new Point(1100, 30);
			}
			lifeBar = AssetsManager.getImage("LifeBar");

			name = entity.name;
			life = entity.health;

			lifeBar.x = position.x;
			lifeBar.y = position.y;

			GameStage.gameStage.addChild(lifeBar);
		}



		public function updateHealthBar():void
		{
			for each (var entity:Entity in EntityManager.entityManager.entities) {
				if (entity.name == name) {
					lifeBar.scaleX = (entity.health / life);

					if(entity.health <= 0)
					{
						GameStage.gameStage.removeActor(lifeBar);
						name = null;
					}
				}
			}
		}
	}
}
