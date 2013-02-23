package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
	import de.mediadesign.gd1011.dreamcatcher.View.LevelEndScreen;

	import starling.animation.DelayedCall;
    import starling.core.Starling;
    import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class GameStage  extends Sprite
	{
		private static var self:GameStage;
		private static var typeImage:Vector.<Boolean> = new <Boolean>[true, true, false, false, true, true];

		private var containerGroup:Vector.<StageContainer>;

		public var bossStage:Boolean;

		private var movementSpeeds:Vector.<Number>;

		private var lvlEnd:Boolean;

		private var endScreen:LevelEndScreen;

        public static function get gameStage():GameStage
        {
            if(!self)
            {
                self = new GameStage();
            }
            return self;
        }

		public function init():void
		{
			bossStage = false;
			lvlEnd = false;

			containerGroup = new Vector.<StageContainer>(6);
			movementSpeeds = GameConstants.GAME_STAGE_MOVMENT_SPEEDS.concat();

            addChild(GraphicsManager.graphicsManager.getImage(GameConstants.BACKGROUND));

			for(var i:int = 0;i<containerGroup.length;i++)
            {
                containerGroup[i] = new StageContainer((typeImage[i]?StageContainer.LIST_TYPE_IMAGE:StageContainer.LIST_TYPE_CONTAINER));
                containerGroup[i].touchable = false;
                addChild(containerGroup[i]);
            }
		}

		public function resetAll():void
		{
			for each (var stageContainer:StageContainer in containerGroup)
			{
				stageContainer.dispose();
			}
			containerGroup = null;

			bossStage = false;

			movementSpeeds = null;


		}

		public function loadLevel(levelIndex:int = 1):void
		{
			var vector:Array = [];
			var vectorBoss:Array = [];
			switch(levelIndex)
			{
				case 1:
				{
					vector.push(GameConstants.BACKGROUND_IMAGE_LIST,
								GameConstants.MAIN_STAGE_IMAGE_LIST,
								GameConstants.ANIMATIONS_LIST,
								GameConstants.FOG_LIST,
								GameConstants.BUSH_IMAGE_LIST,
								GameConstants.FOREGROUND_IMAGE_LIST);

					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,
									GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
									GameConstants.ANIMATIONS_LIST_BOSS,
									GameConstants.FOG_LIST_BOSS,
									GameConstants.BUSH_IMAGE_LIST_BOSS,
									GameConstants.FOREGROUND_IMAGE_LIST_BOSS);
					break;
				}
				case 2:
				{
					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST,
									GameConstants.MAIN_STAGE_IMAGE_LIST,
									GameConstants.ANIMATIONS_LIST,
									GameConstants.FOG_LIST,
									GameConstants.BUSH_IMAGE_LIST,
									GameConstants.FOREGROUND_IMAGE_LIST);

					vector.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,
								GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
								GameConstants.ANIMATIONS_LIST_BOSS,
								GameConstants.FOG_LIST_BOSS,
								GameConstants.BUSH_IMAGE_LIST_BOSS,
								GameConstants.FOREGROUND_IMAGE_LIST_BOSS);
					break;
				}
			}
            for(var i:int = 0;i<containerGroup.length;i++)
            {
                containerGroup[i].fill(vector[i], false);
                containerGroup[i].fill(vectorBoss[i], true);
            }
		}

		public function update(now:Number):void
		{
			if (!lvlEnd)
			{
				for (var i:int = 0; i < containerGroup.length; i++) {
					containerGroup[i].move(movementSpeeds[i]);
					containerGroup[i].swap(bossStage);
				}
				if ((!bossStage) && (now.toFixed() == "50")) {
					switchToBoss();
				}
			}

			if (MovementBoss.phase == "Flee")
			{
				if ((EntityManager.entityManager.getEntity(GameConstants.BOSS)) == null && !lvlEnd)
				{
					endLvl()
				}
			}

			if (lvlEnd && endScreen.alpha <= 1)
			{
				endScreen.alpha += 0.02;
				endScreen.fadeIn();
				if (endScreen.alpha >= 1)
				{
					EntityManager.entityManager.removeAll();
					resetAll();
				}
			}
		}

		public function removeActor(object:DisplayObject):void
		{
			removeChild(object);
		}

		public function switchToBoss():void
		{
            var delay:Number;

			if(containerGroup[0].getChildAt(0).x < containerGroup[0].getChildAt(1).x)
			{
                delay = containerGroup[0].getChildAt(0).x + (2*containerGroup[0].getChildAt(1).width);
				delay /= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[0];
			}
            else
            {
                delay = containerGroup[0].getChildAt(1).x + (2*containerGroup[0].getChildAt(0).width);
                delay /= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[0];
            }

			bossStage = true;
            Starling.juggler.delayCall(beginReduction, delay/60);
            function beginReduction():void
            {
                var call:DelayedCall = Starling.juggler.delayCall(reduceMovementSpeed, GameConstants.BOSS_SPEED_REDUCTION);
                call.repeatCount = 100;
            }
            function reduceMovementSpeed():void
            {
                for (var i:int = 0; i < movementSpeeds.length; i++)
                    movementSpeeds[i] -= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[i]/100;
            }
		}

		private function endLvl():void
		{
			lvlEnd = true;
			endScreen = new LevelEndScreen("Congratulations!");
			addChild(endScreen.screen);
		}
	}
}