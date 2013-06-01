package de.mediadesign.gd1011.dreamcatcher.View.Menu
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.View.ProgressBar;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	public class CreditsMenu extends Sprite
	{
		private static var self:CreditsMenu;
		private static var _active:Boolean = false;
		private static var dancer:MovieClip;
		private static var creditCount:int = 1;

		private var mElements:Vector.<DisplayObject>;

		public function CreditsMenu()
		{
			var gM:GraphicsManager = GraphicsManager.graphicsManager;
			addChild(gM.getImage("Background"));

			mElements = new Vector.<DisplayObject>();

			var buttonStrings:Array = ["MainMenuContinueScreenBackButton", "MainMenuContinueScreenBackButtonClick"];
			var positions:Array = [[40, 660]];
			var button:Button;

			var logo:Image = new Image(ProgressBar.splashScreenAtlas.getTexture("Splashscreen"));
			addChild(logo);
			fadeOut(logo);

			for(var i:int=0; i<buttonStrings.length;i+=2)
			{
				button = new Button(gM.getTexture(buttonStrings[i]),"", gM.getTexture(buttonStrings[i+1]));
				button.enabled = true;
				button.x = positions[i/2][0];
				button.y = positions[i/2][1];
				button.name = buttonStrings[i];
				button.addEventListener(Event.TRIGGERED, onTriggered);
				addChild(button);
				mElements.push(button);
			}

			Starling.juggler.delayCall(dancingCleaner,3);
			Starling.juggler.delayCall(nextCredit,2);

		}

		public static function resetCreditsMenu():void
		{
			if(!self) return;
			for(var i:int=0;i<self.mElements.length;i++)
			{
				self.mElements[i].dispose();
			}
			_active = false;
			self.dispose();
			self = null;
			Starling.juggler.purge();
		}

		private function nextCredit():void
		{
			var mImage:Image = GraphicsManager.graphicsManager.getImage(GameConstants.CREDITS+creditCount);
			mImage.alpha = 0;
			addChild(mImage);
			fadeIn(mImage);

			if (creditCount == 9)
				creditCount = 1;
			else
				creditCount++;

			//if(active == true)
				Starling.juggler.delayCall(nextCredit,2);
		}

		private function fadeIn(tweenObject:DisplayObject):void
		{
			if(tweenObject != dancer)
			{
				tweenObject.pivotX = tweenObject.width/2;
				tweenObject.pivotY = tweenObject.height/2;

				tweenObject.x = Starling.current.viewPort.width/2;
				tweenObject.y = Starling.current.viewPort.height/2;
			}

			var mTween:Tween = new Tween (tweenObject,2,Transitions.EASE_IN);
			mTween.fadeTo(1);
			Starling.juggler.add(mTween);

			if(tweenObject != dancer)
				Starling.juggler.delayCall(fadeOut,3, tweenObject);
		}

		private function dancingCleaner():void
		{
			dancer = new MovieClip(GraphicsManager.graphicsManager.getTextures("CreditsDance_"));
			dancer.x = 820;
			dancer.y = 80;
			dancer.loop = true;
			dancer.alpha = 0;
			addChild(dancer);
			Starling.juggler.add(dancer);
			fadeIn(dancer);
		}

		private function fadeOut(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,2,Transitions.EASE_OUT);
			mTween.fadeTo(0);
			Starling.juggler.add(mTween);

			Starling.juggler.delayCall(removeObject,2, tweenObject);
		}

		private function removeObject(object:DisplayObject):void
		{
			removeChild(object,true);
		}

		private function onTriggered(e:Event):void
		{
			switch(e.currentTarget)
			{
				case(mElements[0]):
					GraphicsManager.graphicsManager.playSound("MenuButton2");
					showAndHide();
					break;
			}
		}

		public static function get creditsMenu():CreditsMenu
		{
			if(!self)
				self = new CreditsMenu();
			return self;
		}

		public static function showAndHide():void
		{
			if(!_active)
			{
                self = null;
				_active = true;
				MainMenu.mainMenu.addChild(creditsMenu);
			}
			else
			{
				_active = false;
				MainMenu.mainMenu.removeChild(creditsMenu);
				CreditsMenu.resetCreditsMenu();
			}
		}

		public static function isActive():Boolean
		{
			return _active;
		}
	}
}
