package de.mediadesign.gd1011.dreamcatcher.Assets
{
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundManager
    {

		private static var soundsLoaded:Boolean = false;
		private static var LoadedSoundList:Vector.<Sound> = new Vector.<Sound>();

		public static function createChannels():void
		{
			if(!soundsLoaded)
			{
				for each (var SoundEntry:String in GameConstants.SOUND_LIST)
				{

					LoadedSoundList.push(AssetsManager.getSound(SoundEntry));
					trace("Number of Sounds"+LoadedSoundList.length);
					soundsLoaded = true;
				}
			}
		}

		public static function getSoundChannel(item:String):SoundChannel
		{
			switch (item)
			{
				case GameConstants.TEST_SOUND:
				{
					if (LoadedSoundList.length != 0 )
					{
						trace("Number of Sounds"+(LoadedSoundList.length-1));
						trace("TEST_SOUND SoundChannel was given from the LoadedSoundList");
						return intoChannel(LoadedSoundList.shift() as Sound);
					}
					else
					{
						LoadedSoundList.push(AssetsManager.getSound(item));
						trace("TEST_SOUND SoundChannel was created");
						return intoChannel(LoadedSoundList.shift());
					}
				}

				default :
				{
					throw new ArgumentError(item + " does not Exist!");
				}
			}
		}

		private static function intoChannel(soundObject:Sound):SoundChannel
		{
			var newSoundChannel:SoundChannel = soundObject.play();
			return newSoundChannel;
		}

		private static function intoSound(soundObject:SoundChannel):Sound
		{
			var newSound:Sound = soundObject.stop() as Sound;
			return newSound;
		}

		public static  function  addSound(soundChannelObject:SoundChannel,item:String):void
		{
			switch (item)
			{
				case GameConstants.TEST_SOUND:
				{
					LoadedSoundList.push(intoSound(soundChannelObject));
					trace("TEST_SOUND was added to LoadedSoundList")
				}
			}
        }
	}
}