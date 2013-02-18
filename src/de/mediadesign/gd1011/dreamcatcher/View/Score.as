/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 18.02.13
 * Time: 11:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.*;

	import starling.core.Starling;
	import starling.text.TextField;

	public class Score
	{
		private static var score:Number = 0;
		private static var scoreField:TextField = new TextField(100, 30 , score.toString(),"Verdana", 24, 0x00FFFF);
		private static var initialisation:Boolean = false;

		public static function updateScore(entity:Entity):void
		{
			if (entity.health <= 0)
			{
				score += entity.points;
				showScore(score);
			}
		}

		private static function showScore(score:Number):void
		{
			scoreField.text = score.toString();

			if (!initialisation)
			{
				addScorField();
				initialisation = true;
			}
		}

		public static function resetScore():void
		{
			score = 0;
		}

		public static function addScorField():void
		{
			GameStage.gameStage.addChild(scoreField);
			scoreField.x = Starling.current.stage.stageWidth/ 2;
			scoreField.y = 20;
		}

		public static function removeScoreField():void
		{
			GameStage.gameStage.removeChild(scoreField);
		}
	}
}
