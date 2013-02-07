package de.mediadesign.gd1011.dreamcatcher
{

    import flash.media.Sound;

    public class SoundHandler
    {
		private static var soundsLoaded:Boolean = false;
		private static var ChanelList:Vector.<Sound> = new Vector.<Sound>();
		private static var SoundList:Vector.<String> = new new <String>["TestSound"];


		public static function createChannels():void
		{

			if(!soundsLoaded)
			{
				for each (var SoundEntry:String in SoundList)
				{
					ChanelList.push(AssetsManager.getSound(SoundEntry));
					soundsLoaded = true;
				}
			}
		}

		public static function getSound(item:String):Sound
		{
			switch (item)
			{
				case "TestSound":
				{
					if (ChanelList.length != 0 )
					{
					var transformedSound:Sound = ChanelList.shift();
					trace("Sound was given from the ChanelList")
					return  transformedSound;
					}
					else
					{
						ChanelList.push(AssetsManager.getSound(item));
						var newSound:Sound = ChanelList.shift();
						trace("Enemy was created")
						return newSound;
					}
				}

				default :
				{
					throw new ArgumentError(item+" does not Exist!");
					return null;
				}
			}
			return null;
		}
    }
}