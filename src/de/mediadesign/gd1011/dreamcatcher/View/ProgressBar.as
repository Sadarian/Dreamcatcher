package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class ProgressBar extends Sprite
    {
        [Embed(source="/../assets/textures/HD/Splashscreen.xml", mimeType="application/octet-stream")]
        public static const SplashscreenXML_HD:Class;

        [Embed(source="/../assets/textures/HD/Splashscreen.png")]
        public static const SplashscreenTexture_HD:Class;

        [Embed(source="/../assets/textures/SD/Splashscreen.xml", mimeType="application/octet-stream")]
        public static const SplashscreenXML_SD:Class;

        [Embed(source="/../assets/textures/SD/Splashscreen.png")]
        public static const SplashscreenTexture_SD:Class;

        public static var splashScreenAtlas_HD:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SplashscreenTexture_HD()), XML(new SplashscreenXML_HD()));
        public static var splashScreenAtlas_SD:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SplashscreenTexture_SD()), XML(new SplashscreenXML_SD()));

        private var mBar:Quad;
        public var ratios:Array;
        
        public function ProgressBar(ratioAmounts:int = 1)
        {
            ratios = new Array(ratioAmounts);
            mBar = new Quad(380, 260, 0xff6600);
            mBar.x = 480;
            mBar.y = 760;
            mBar.scaleY = 0;
            var currentAtlas:TextureAtlas = (Dreamcatcher.scaleFactor == 1)?splashScreenAtlas_HD:splashScreenAtlas_SD;
            addChild(mBar);
            addChild(new Image(currentAtlas.getTexture("Splashscreen")));
        }

        public function setRatio(index:int, value:Number):void
        { 
            ratios[index] = Math.max(0.0, Math.min(1.0, value));
            setSumRatio();
        }

        private function setSumRatio():void
        {
            var total:Number = 0;
            for(var i:int=0;i<ratios.length;i++)
                total += ratios[i];
            mBar.scaleY = -1*Math.max(0.0, Math.min(1.0, total));
        }
    }
}