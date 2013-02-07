package de.mediadesign.gd1011.dreamcatcher
{

    import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
    import starling.extensions.ParticleSystem;
	import starling.core.Starling;

	public class ParticleManager extends Sprite
	{
        public static const WEAPON_ONE:String = "Bullet";

		public static function startParticleSystem(type:String):ParticleSystem
        {
            var system:ParticleSystem = new PDParticleSystem(AssetsLoader.getXML(type+"Config"), AssetsLoader.getTexture(type+"Particle"));
            system.start();
            Starling.juggler.add(system);
            return system;
        }

        public static function stopParticleSystem(system:ParticleSystem):void
        {
            system.stop();
            system.removeFromParent();
            Starling.juggler.remove(system);
            system.dispose();
        }
	}
}