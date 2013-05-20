/**
 * Created with IntelliJ IDEA.
 * User: rolehmann
 * Date: 27.02.13
 * Time: 22:35
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.AssetsClasses
{
    public class EmbeddedAssets
    {
        [Embed(source="/../assets/fonts/FriskyVampire.ttf", embedAsCFF="false", fontFamily="MenuFont")]
        public static const MenuFont:Class;

		[Embed(source="/../assets/fonts/ObelixPro-cyr.ttf", embedAsCFF="false", fontFamily="TutorialFont")]
		public static const TutorialFont:Class;
    }
}
