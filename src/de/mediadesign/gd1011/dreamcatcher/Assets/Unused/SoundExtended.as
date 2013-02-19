package de.mediadesign.gd1011.dreamcatcher.Assets.Unused
{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.utils.getQualifiedClassName;

    public class SoundExtended extends Sound
    {
		private static var SoundObject:Object;
		private static var channal:SoundChannel;

		public static function playSound(InputSound:Object, solo:Boolean=false,length:int = 0):void
		{
			if (!solo)
				(InputSound as Sound).play();
			else if ((getQualifiedClassName(SoundObject) != getQualifiedClassName(InputSound) || channal.position >= length))
			{
				SoundObject = InputSound;
				channal = (InputSound as Sound).play();
			}
		}
    }
}