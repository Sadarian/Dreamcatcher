/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 18.02.13
 * Time: 11:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.*;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.text.TextField;

	public class Score
	{
		private static var _score:Number = 0;
		private static var scoreField:TextField = new TextField(300, 100 , _score.toString(),"MenuFont", 100, 0xe87600);
		private static var entityPoints:Vector.<TextField> = new Vector.<TextField>();
		private static var addedPoints:Vector.<Number> = new Vector.<Number>();
		private static var initialisation:Boolean = false;
		private static var reShake:Boolean = false;

		public static function updateScore(entity:Entity):void
		{
			var points:TextField = new TextField(300, GameConstants.fontSize, entity.points.toString(), "MenuFont", 100);
			points.pivotX = points.width/2;
			points.pivotY = points.height/2;
			points.x = entity.position.x;
			points.y = entity.position.y;
			points.scaleX = 0.5;
			points.scaleY = 0.5;
			points.alpha = 0.5;

			if (entity.isEnemy)
			{
				points.color = 0xe215745;
			}
			else if (entity.isVictim1)
			{
				points.color = 0xe803032
			}
			else if (entity.isVictim2)
			{
				points.color = 0xe7C8130
			}
			else if (entity.isCharger)
			{
				points.color = 0xe445323
			}

			GameStage.gameStage.addChild(points);
			fadeIn(points);
			addedPoints.push(entity.points);
			entityPoints.push(points);
		}

		public static function update():void
		{
			for each (var textField:TextField in entityPoints)
			{
				if (textField.x == textField.x && textField.y == scoreField.y)
				{
					var index:Number = entityPoints.indexOf(textField);
					GameStage.gameStage.removeActor(textField);
					textField.dispose();

					_score += addedPoints[index];

					addedPoints.splice(index,1);
					entityPoints.splice(index,1);

					showScore(_score);
				}
			}
			if (reShake && scoreField.rotation == 15 * (Math.PI / 180))
			{
				shakeScore(scoreField);

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
			else
			{
				shakeScore(scoreField);
				reShake = true;
			}
		}

		private static function shakeScore(tweenObject:DisplayObject):void
		{
			var shakeTween:Tween = new Tween(tweenObject, 0.1, Transitions.EASE_IN_OUT_BOUNCE);
			if (tweenObject.rotation == 0)
			{
				shakeTween.animate("rotation",(15*(Math.PI/180)));
			}
			else
			{
				shakeTween.animate("rotation",(0));
				reShake = false;
			}
			Starling.juggler.add(shakeTween);
		}

		public static function resetScore():void
		{
			_score = 0;
		}

		public static function addScoreField():void
		{
			GameStage.gameStage.addChild(scoreField);
			scoreField.x = Starling.current.stage.stageWidth - scoreField.width - 50;
			scoreField.y = 50;
            scoreField.touchable =false;
			scoreField.pivotX = scoreField.width/2;
			scoreField.pivotY = scoreField.height/2;
		}

		public static function removeScoreField():void
		{
			GameStage.gameStage.removeChild(scoreField);
			resetScore();
			initialisation = false;
		}

		private static function fadeIn(tweenObject:DisplayObject):void
		{
			var fadeInTween:Tween = new Tween (tweenObject,GameConstants.growFadeSpeed,Transitions.EASE_IN);
			fadeInTween.scaleTo(1);
			fadeInTween.fadeTo(1);
			fadeInTween.onComplete = moveTo(tweenObject);
			Starling.juggler.add(fadeInTween);
		}

		private static function fadeOut(tweenObject:DisplayObject):void
		{
			var fadeOutTween:Tween = new Tween (tweenObject,1,Transitions.EASE_OUT);
			fadeOutTween.fadeTo(0);
			Starling.juggler.add(fadeOutTween);
		}

		private static function moveTo(tweenObject:DisplayObject):Function
		{
			var moveToTween:Tween = new Tween (tweenObject, GameConstants.moveToSpeed, Transitions.EASE_IN);
			moveToTween.moveTo(scoreField.x, scoreField.y);
			Starling.juggler.add(moveToTween);
			return null;
		}

        public static function get score():Number
        {
            return _score;
        }


	}
}
