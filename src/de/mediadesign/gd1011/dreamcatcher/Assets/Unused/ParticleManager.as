package de.mediadesign.gd1011.dreamcatcher.Assets.Unused
{
import de.mediadesign.gd1011.dreamcatcher.Assets.*;
    import starling.display.Sprite;
    import starling.extensions.ParticleSystem;
	import starling.core.Starling;

	public class ParticleManager extends Sprite
	{
        public static const PARTICLE:String = "Particle";
	 	public static var testParticle:ParticleSystem;
		private static var _isUsed:Boolean = false;

		public static function start():void
        {
			//Loading ParticleSystems
			testParticle = GraphicsManager.getParticleSystem("Particle");
        }

		public static function get isUsed():Boolean
		{
			return _isUsed;
		}

		public static function getParticleSystem(item:String):ParticleSystem
		{
			if (_isUsed != true)
			{
				switch (item)
				{
					case PARTICLE:
					{
						if (testParticle != null )
						{
							trace("Particle System was given from List");
							_isUsed = true;
							testParticle.start();
							return testParticle;
						}
						else
							throw new ArgumentError(item + " already in use! Return the Particle System to the manager before pulling a new one");
					}
					default :
						throw new ArgumentError(item + " does not Exist! Only 'Particle' is valid");
				}
			}
			else
                throw new ArgumentError(item + " already in use! Return the Particle System to the manager before pulling a new one");
		}

		public static function addParticleSystem(item:String, system:ParticleSystem):void
		{
			_isUsed = false;
			switch (item)
			{
				case PARTICLE:
				{
					if(testParticle = null)
					{
						testParticle = system;
						testParticle.stop();
						testParticle.removeFromParent();
						Starling.juggler.remove(testParticle);
						system.dispose();
						trace("Particle was added to Manager")
					}
					else
					{
						system.stop();
						system.removeFromParent();
						Starling.juggler.remove(system);
						system.dispose();
						trace(item + " has been disposed since there already exists a system of this type" )
					}
				}
				default :
					throw new ArgumentError(item + " does not Exist! Only 'Particle' can be added.");
			}
		}
	}
}