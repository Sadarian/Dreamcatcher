/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 18.02.13
 * Time: 11:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.*;

    import flash.net.SharedObject;

    import starling.core.Starling;
	import starling.text.TextField;

	public class Score
	{
		private static var _score:Number = 0;
		private static var scoreField:TextField = new TextField(300, 100 , _score.toString(),"MenuFont", 100, 0xe87600);
		private static var initialisation:Boolean = false;

		public static function updateScore(entity:Entity):void
		{
			if (entity.health <= 0)
			{
				_score += entity.points;
				showScore(_score);
			}
		}

		public static function showScore(score:Number):void
		{
			scoreField.text = score.toString();

			if (!initialisation)
			{
				addScoreField();
				initialisation = true;
			}
		}

		public static function resetScore():void
		{
			_score = 0;
		}

		public static function addScoreField():void
		{
			GameStage.gameStage.addChild(scoreField);
			scoreField.x = Starling.current.stage.stageWidth - scoreField.width - 50;
			scoreField.y = 18;
		}

		public static function removeScoreField():void
		{
			GameStage.gameStage.removeChild(scoreField);
			resetScore();
			initialisation = false;
		}

        public static function get score():Number
        {
            return _score;
        }
    }
}
