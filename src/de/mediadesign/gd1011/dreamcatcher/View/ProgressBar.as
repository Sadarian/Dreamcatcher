package de.mediadesign.gd1011.dreamcatcher.View
{
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class ProgressBar extends Sprite
    {
        [Embed(source="/../assets/textures/Splashscreen.xml", mimeType="application/octet-stream")]
        public static const SplashscreenXML:Class;

        [Embed(source="/../assets/textures/Splashscreen.png")]
        public static const SplashscreenTexture:Class;

        public static var splashScreenAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SplashscreenTexture()), XML(new SplashscreenXML()));

        private var mBar:Quad;
        public var ratios:Array;
        
        public function ProgressBar(ratioAmounts:int = 1)
        {
            ratios = new Array(1);
            mBar = new Quad(330, 260, 0xff6600);
            mBar.x = 480;
            mBar.y = 760;
            mBar.scaleY = 0;
            addChild(mBar);
            addChild(new Image(splashScreenAtlas.getTexture("LoadingScreen")));
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