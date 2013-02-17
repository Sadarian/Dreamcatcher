package de.mediadesign.gd1011.dreamcatcher.Assets
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
    import starling.core.Starling;
    import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AssetsLoader
	{

// TTF-Fonts
		[Embed(source="/../assets/fonts/defused.ttf", embedAsCFF="false", fontFamily="TestFont")]
		private static const TestFont:Class;

// Sounds
		[Embed(source="/../assets/audio/testSound.mp3")]
		private static const TestSound:Class;

//BitmMapFonts

//Texture cache
		private static var sContentScaleFactor:int = Starling.current.contentScaleFactor;
		private static var sTextures:Dictionary = new Dictionary();
		private static var sTextureAtlas:TextureAtlas;
		private static var sSounds:Dictionary = new Dictionary();

//This sets the single Frames of an Animation-Sprite and stores it in the atlas?
		public static function createAtlasAnim(name:String,w:int,h:int,frames:int):TextureAtlas
		{
			var texture:Texture = getTexture(name);

			var atlas:TextureAtlas = new TextureAtlas (texture);
			var hNew:int = texture.height / h;
			var wNew:int = texture.width / w;

			for (var i:int = 0; i < frames; i++)
			{
				var x:int = i%w;
				var y:int = i/w;

				var nameNew:String = String(i);
				while ( nameNew.length < 3 )
				{
					nameNew = "0" + nameNew;
				}
				atlas.addRegion(name+nameNew, new Rectangle(x*wNew,y*hNew, wNew, hNew));

			}
			return atlas;
		}

//Prepares the Sounds for the game
		public static function getSound(name:String):Sound
		{
			var sound:Sound = sSounds[name] as Sound;
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + name);
		}

		public static function prepareSounds():void
		{
			sSounds["TestSound"] = new TestSound();
		}


//Gets the texture from files (Target,Player, etc..)
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object = createTextureClass(name);

				if (data is Bitmap)
                {
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, false, false, sContentScaleFactor);
                    (data as Bitmap).bitmapData.dispose();
                }
				else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor, false);
				else throw new ArgumentError("Texure not found: " + name);
			}
			return sTextures[name];
		}

		public static function getXML(name:String):XML
		{
			if (XML[name] == undefined)
			{
				XML[name] = XML(createTextureClass(name));
				if(XML[name] != undefined)
					trace(name+" XML created");
				else throw new ArgumentError(name+" XML not created: " + name);
			}
			return XML[name];
		}

		public static function getTextureAtlas(textureName:String,xmlName:String):TextureAtlas
		{
			if (sTextureAtlas == null)
			{
				var texture:Texture = getTexture(textureName);
				var xml:XML = XML(createTextureClass(xmlName));
				sTextureAtlas = new TextureAtlas(texture, xml);
			}
			return sTextureAtlas;
		}

//Prepares Fonts for Usage
		public static function loadBitmapFonts(fontTextureName:String,fontXmlName:String):void
		{
				var texture:Texture = getTexture(fontTextureName);
				var xml:XML = XML(createTextureClass(fontXmlName));
				TextField.registerBitmapFont(new BitmapFont(texture, xml));
		}

		private static function createTextureClass(name:String):Object
		{
			var textureClass:Class = sContentScaleFactor == 1 ? AssetsTextureEmbeds_1x : AssetsTextureEmbeds_2x;
			return new textureClass[name];
		}

	}
}
