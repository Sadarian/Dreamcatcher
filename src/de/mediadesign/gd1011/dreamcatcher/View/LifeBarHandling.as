package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import flash.geom.Point;
	import starling.display.Image;

	public class LifeBarHandling
	{
		private var lifeBar:Image;
        private var entity:Entity;
        private var life:Number;

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

			lifeBar = GraphicsManager.graphicsManager.getImage("LifeBar");

			life = entity.health;
            this.entity = entity;

			lifeBar.x = position.x;
			lifeBar.y = position.y;

			GameStage.gameStage.addChild(lifeBar);
		}

		public function removeLiveBar():void
		{
			GameStage.gameStage.removeActor(lifeBar)
		}

		public function updateHealthBar():void
		{
            lifeBar.scaleX = (entity.health / life);

            if(entity.health <= 0)
                GameStage.gameStage.removeActor(lifeBar);
		}
	}
}
