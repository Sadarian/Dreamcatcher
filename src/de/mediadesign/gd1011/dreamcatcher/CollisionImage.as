/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 12.02.13
 * Time: 11:21
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {
	import starling.display.Image;
	import starling.textures.Texture;

	public class CollisionImage extends Image{
		private var _entityName:String;
		public function CollisionImage(texture:Texture, entityName:String) {
			super(texture);
			this._entityName = entityName;
		}

		public function get entityName():String {
			return _entityName;
		}
	}
}
