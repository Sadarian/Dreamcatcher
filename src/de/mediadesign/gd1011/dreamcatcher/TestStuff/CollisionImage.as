package de.mediadesign.gd1011.dreamcatcher.TestStuff
{
	import starling.display.Image;
	import starling.textures.Texture;

	public class CollisionImage extends Image
    {
		private var _entityName:String;

		public function CollisionImage(texture:Texture, entityName:String)
        {
			super(texture);
			this._entityName = entityName;
		}

		public function get entityName():String
        {
			return _entityName;
		}
	}
}
