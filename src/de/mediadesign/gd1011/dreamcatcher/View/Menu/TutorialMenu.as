package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

	import starling.animation.Transitions;
	import starling.animation.Tween;

	import starling.core.Starling;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class TutorialMenu extends Sprite
	{
		private static var self:TutorialMenu;
		private static var _active:Boolean = false;

		private var mIndex:int = 0;
		private var mElements:Vector.<DisplayObject>;

		public function TutorialMenu()
		{
			var gM:GraphicsManager = GraphicsManager.graphicsManager;
			var iM:Image;
            var i:int;

			(Starling.current.root as Game).startLevel(YesNoMenu.selectetLvl);

			mElements = new Vector.<DisplayObject>();

			var buttonStrings:Array = [	"TutorialBackButton", "TutorialBackButtonClick"];
			var positions:Array = [[40, 650]];
			var button:Button;
//			for(i=0; i<buttonStrings.length;i+=2)
//			{
//				button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]));
//				button.enabled = true;
//				button.x = positions[i/2][0];
//				button.y = positions[i/2][1];
//				button.name = buttonStrings[i];
//				button.addEventListener(Event.TRIGGERED, onTriggered);
//				addChild(button);
//				mElements.push(button);
//			}
//			mElements[1].visible = false;
		}

		private function onTriggered(e:Event):void
		{
			switch(e.currentTarget)
			{
				case(mElements[0]):
					GraphicsManager.graphicsManager.playSound("evilLaugh");
					showAndHide();
					(Starling.current.root as Game).startLevel(YesNoMenu.selectetLvl);
					break;
				case(mElements[1]):

					break;
				case(mElements[2]):

					break;
			}
		}

		public static function get tutorialMenu():TutorialMenu
		{
			if(!self)
				self = new TutorialMenu();
			return self;
		}

		public static function showAndHide():void
		{
			if(!_active)
			{
                self = null;
				_active = true;
				(Starling.current.root as Game).addChild(tutorialMenu);
			}
			else
			{
				_active = false;
				(Starling.current.root as Game).removeChild(tutorialMenu);

			}
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

		public static function isActive():Boolean {
			return _active;
		}
	}
}
