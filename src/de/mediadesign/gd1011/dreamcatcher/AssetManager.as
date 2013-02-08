/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 05.02.13
 * Time: 11:18
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class AssetManager
	{
		public function AssetManager()
		{
			
		}

		public static function playerWalkCycle():MovieClip
		{
			var playerWalkCycle:MovieClip = new MovieClip(Assets.createAtlasAnim("PlayerOnly", 4, 2, 6).getTextures(),12);
			Starling.juggler.add(playerWalkCycle);
			playerWalkCycle.play();
			return playerWalkCycle;
		}

		public static function background():Image
		{
			var background:Image = new Image(Assets.getTexture("Background"));
			return background;
		}

		public static function bossImage():MovieClip
		{
			var boss:MovieClip = new MovieClip(Assets.createAtlasAnim("Boss", 3, 2, 6).getTextures(),10);
			Starling.juggler.add(boss);
			boss.play();
			return boss;
		}
	}
}
