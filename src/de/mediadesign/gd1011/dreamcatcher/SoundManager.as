package de.mediadesign.gd1011.dreamcatcher
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundManager
    {
		public static const TEST_SOUND:String = "TestSound";

		private static var soundsLoaded:Boolean = false;
		private static var LoadedSoundList:Vector.<Sound> = new Vector.<Sound>();
		private static var SoundList:Vector.<String> = new <String>[TEST_SOUND];


		public function SoundManager()
		{
		}

		public static function createChannels():void
		{
			if(!soundsLoaded)
			{
				for each (var SoundEntry:String in SoundList)
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
				case TEST_SOUND:
				{
					if (LoadedSoundList.length != 0 )
					{
						var givenSound:Sound = LoadedSoundList.shift() as Sound;
						trace("Number of Sounds"+LoadedSoundList.length);
						var newSoundChannel:SoundChannel = intoChannel(givenSound);
						trace("TEST_SOUND SoundChannel was given from the LoadedSoundList");
						return  newSoundChannel;
					}
					else
					{
						LoadedSoundList.push(AssetsManager.getSound(item));
						var newSound:Sound = LoadedSoundList.shift();
						var newSoundChannel:SoundChannel = intoChannel(newSound);
						trace("TEST_SOUND SoundChannel was created");
						return newSoundChannel;
					}
				}

				default :
				{
					throw new ArgumentError(item + " does not Exist!");
					return null;
				}
			}
			return null;
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
				case TEST_SOUND:
				{
					LoadedSoundList.push(intoSound(soundChannelObject));
					trace("TEST_SOUND was added to LoadedSoundList")
				}
			}
        }
	}
}