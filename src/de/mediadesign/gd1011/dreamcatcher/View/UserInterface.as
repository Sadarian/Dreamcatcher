/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 25.02.13
 * Time: 12:22
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

	import starling.display.Sprite;

	public class UserInterface
	{
		private static var self:UserInterface;
		private var playerBar:Sprite = new Sprite();

		public static function get userInterface():UserInterface
		{
			if(!self)
			{
				self = new UserInterface();
			}
			return self;
		}

		public function init():void
		{
			playerBar.addChild(GraphicsManager.graphicsManager.getImage("PlayerLifeBarFrame"));
			playerBar.y = 10;
			GameStage.gameStage.addChild(playerBar);
		}

		public function removePlayerBar():void
		{
			GameStage.gameStage.removeActor(playerBar);
		}

	}
}
