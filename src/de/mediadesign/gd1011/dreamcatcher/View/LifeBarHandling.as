package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

	import flash.display.BitmapData;

	import flash.display.GradientType;

	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;

	public class LifeBarHandling
	{
		private var lifeBar:Image;
		private var playerIcon:Image;
        private var entity:Entity;
        private var life:Number;
		private var lifePercent:Number;

		public function LifeBarHandling(entity:Entity, position:Point = null)
		{
			if (entity.name == GameConstants.PLAYER)
			{
				position = new Point(137, 35);
				lifeBar = new Image(createLifeShape(0));
				playerIcon = GraphicsManager.graphicsManager.getImage("PlayerLifeBarState_1");
				GameStage.gameStage.addChild(playerIcon);
			}
			else if (entity.name == GameConstants.BOSS1)
			{
				position = new Point(1100, 30);
				lifeBar = GraphicsManager.graphicsManager.getImage("LifeBar");
			}

			life = entity.health;
            this.entity = entity;

			lifeBar.x = position.x;
			lifeBar.y = position.y;

			GameStage.gameStage.addChild(lifeBar);
		}

		private function createLifeShape(number:Number):Texture
		{
			var shape:Shape = new Shape();
			var matr:Matrix = new Matrix();
			matr.createGradientBox(30, 0, -(Math.PI / 2), number);
			shape.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0505, 0x000000],[1,1], [0,255], matr);
			shape.graphics.drawCircle(34, 34, 34);
			shape.graphics.endFill();
			var bitmapData:BitmapData = new BitmapData(100, 100, true, 0x00FFFFFF);
			bitmapData.draw(shape);

			return Texture.fromBitmapData(bitmapData);
		}

		public function removeLiveBar():void
		{
			GameStage.gameStage.removeActor(lifeBar)
		}

		public function updateHealthBar():void
		{
			if (entity.name == GameConstants.PLAYER)
			{
				if (lifePercent != entity.health / life)
				{
					lifePercent = entity.health / life;
					changeIcon();

					lifeBar.texture = createLifeShape(life - entity.health);
				}

				lifePercent = entity.health / life;
			}
			else
			{
				lifeBar.scaleX = (entity.health / life);
			}

            if(entity.health <= 0)
            {
                GameStage.gameStage.removeActor(lifeBar);

	            if (entity.name == GameConstants.PLAYER)
	                GameStage.gameStage.removeActor(playerIcon);
            }
		}

		private function changeIcon():void
		{
			if (lifePercent <= 0.75 && lifePercent > 0.5)
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_2");
			}
			else if (lifePercent <= 0.5 && lifePercent > 0.25)
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_3");
			}
			else if (lifePercent <= 0.25)
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_4");
			}
			else
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_1");
			}
		}
	}
}
