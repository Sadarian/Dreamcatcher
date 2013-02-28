package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

	import flash.display.BitmapData;

	import flash.display.GradientType;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.media.SoundChannel;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

	public class LifeBarHandling
	{
		private var lifeBar:Image;
		private var playerIcon:Image;
        private var playerBar:Sprite;
		private var bossLifeIcon:Image;
        private var entity:Entity;
        private var life:Number;
		private var lifePercent:Number;
		private var exhaustSound:SoundChannel;
		private var color:uint;
		private var size:Number;
		private var exhaustOverlay:Image;

		public function LifeBarHandling(entity:Entity, position:Point = null)
		{
			if (entity.isPlayer)
			{
				position = new Point(161, 43);
				color = 0xFF0505;
				size = 41
				lifeBar = new Image(createLifeShape(0));
				playerIcon = GraphicsManager.graphicsManager.getImage("PlayerLifeBarState_1");
			}
			else if (entity.isBoss)
			{
				position = new Point(550, 30);
				color = 0x4c1796;
				size = 80;
				lifeBar = new Image(createLifeShape(0));
				bossLifeIcon = GraphicsManager.graphicsManager.getImage("BossLifeBarFrame");
				bossLifeIcon.x = position.x-10;
				bossLifeIcon.y = position.y-10;
			}

			life = entity.health;
            this.entity = entity;

			lifeBar.x = position.x;
			lifeBar.y = position.y;


			GameStage.gameStage.addChild(lifeBar);

			if (entity.isBoss)
				GameStage.gameStage.addChild(bossLifeIcon);
            if (entity.isPlayer)
            {
                playerBar = new Sprite();
                playerBar.addChild(GraphicsManager.graphicsManager.getImage("PlayerLifeBarFrame"));
                playerBar.y = 10;
                GameStage.gameStage.addChild(playerBar);
                GameStage.gameStage.addChild(playerIcon);
            }

			exhaustOverlay = new Image(GraphicsManager.graphicsManager.getTexture("ExhaustFeedback"));
			exhaustOverlay.alpha = 0;
			GameStage.gameStage.addChild(exhaustOverlay);

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

		private function soundCompleteHandler(event:Event):void
		{
			if (lifePercent <= 0.25)
			GraphicsManager.graphicsManager.playSound("PlayerExhaust",0)
		}

		private function createLifeShape(number:Number):Texture
		{
            if(number==0)number = 0.1;
			var shape:Shape = new Shape();
			var matr:Matrix = new Matrix();
			matr.createGradientBox(50, number, -(Math.PI / 2), 0, number/4);
			shape.graphics.beginGradientFill(GradientType.LINEAR, [color, 0x000000],[1,1], [0,125], matr);
			shape.graphics.drawCircle(size, size, size);
			shape.graphics.endFill();
			var bitmapData:BitmapData = new BitmapData(size*3, size*3, true, 0x00FFFFFF);
			bitmapData.draw(shape);

			return Texture.fromBitmapData(bitmapData);
		}

		public function removeLiveBar():void
		{
			GameStage.gameStage.removeActor(lifeBar);
            lifeBar.dispose();
            GameStage.gameStage.removeActor(playerIcon);
			GameStage.gameStage.removeActor(bossLifeIcon);
            GameStage.gameStage.removeActor(playerBar);
		}

		public function updateHealthBar():void
		{

			if (lifePercent != entity.health / life)
			{
				lifePercent = entity.health / life;

				if (entity.isPlayer)
				{
					changeIcon();
					lifeBar.texture = createLifeShape(life - entity.health);
				}

				if (entity.isBoss)
				{
					lifeBar.texture = createLifeShape((life - entity.health)/3);
				}



				lifePercent = entity.health / life;
			}



            if(entity.health <= 0)
            {
                GameStage.gameStage.removeActor(lifeBar);
				if(exhaustSound)
                    exhaustSound.stop();
					exhaustOverlay.alpha =0;

	            if (entity.name == GameConstants.PLAYER)
	                GameStage.gameStage.removeActor(playerIcon);
            }
		}

		private function changeIcon():void
		{
			if (lifePercent <= 0.75 && lifePercent > 0.5)
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_2");
				if (exhaustSound)
					exhaustSound.stop();
					exhaustOverlay.alpha =0;
			}
			else if (lifePercent <= 0.5 && lifePercent > 0.25)
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_3");
				if (exhaustSound)
					exhaustSound.stop();
					exhaustOverlay.alpha =0;
			}
			else if (lifePercent <= 0.25)
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_4");
				exhaustSound = GraphicsManager.graphicsManager.playSound("PlayerExhaust",0);
				exhaustSound.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				fadeIn(exhaustOverlay);
			}
			else
			{
				playerIcon.texture = GraphicsManager.graphicsManager.getTexture("PlayerLifeBarState_1");
				if (exhaustSound)
					exhaustSound.stop();
			}
		}
	}
}
