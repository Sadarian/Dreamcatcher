package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import starling.animation.DelayedCall;
    import starling.core.Starling;
    import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class GameStage  extends Sprite
	{
		private static var self:GameStage;
		private static var typeImage:Vector.<Boolean> = new <Boolean>[true, true, false, false, true, true];

		private var containerGroup:Vector.<StageContainer>;

		public var bossStage:Boolean = false;

		private var movementSpeeds:Vector.<Number>;

		public function GameStage()
		{

			//GameStage On which the Actors move
			movementSpeeds = GameConstants.GAME_STAGE_MOVMENT_SPEEDS.concat();

			containerGroup = new Vector.<StageContainer>(6);
		}

		public function init():void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
            {
                containerGroup[i] = new StageContainer((typeImage[i]?StageContainer.LIST_TYPE_IMAGE:StageContainer.LIST_TYPE_CONTAINER));
                containerGroup[i].touchable = false;
            }
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

					createLevel(vector, vectorBoss);
					break;
				}
			}
		}

		private function createLevel(vector:Array, vectorBoss:Array):void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
			{
				containerGroup[i].fill(vector[i], false);
				containerGroup[i].fill(vectorBoss[i], true);
				addChild(containerGroup[i]);
			}
		}

		public function moveGameStage():void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
			{
				containerGroup[i].move(movementSpeeds[i]);
				containerGroup[i].swap(bossStage);
			}
		}

		public static function get gameStage():GameStage {
			if(self == null)
			{
				self = new GameStage();
			}
			return self;
		}

		public function removeActor(object:DisplayObject):void
		{
			removeChild(object);
		}

		public function switchToBoss():void
		{
			if(containerGroup[0].getChildAt(0).x < containerGroup[0].getChildAt(1).x)
			{
				var delay:Number = containerGroup[0].getChildAt(0).x + (2*containerGroup[0].getChildAt(0).width);
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
	}
}