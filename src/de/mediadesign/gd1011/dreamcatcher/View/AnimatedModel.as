package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.display.MovieClip;
    import starling.events.Event;

    public class AnimatedModel extends DisplayObjectContainer
    {
        public static const WALK:String = "Walk";

		public static const DEAD_WALK:String ="DeadWalk";
        public static const DIE:String = "Die";
		public static const DIE_CLOSE_COMBAT:String ="DieCloseCombat";
		public static const DIE_SHOOT:String = "DieShoot";
		public static const DIE_HEAD:String = "DieHead";

		public static const CLOSE_COMBAT:String = "CloseCombat";
		public static const HIT:String ="Hit";
		public static const SHOOT:String ="Shoot";
		public static const BULLET:String ="Bullet";
		public static const EAT:String = "Eat";
		public static const FEAR:String = "Fear";

        private var Walk:MovieClip = null;

        private var DeadWalk:MovieClip = null;
        private var Die:MovieClip = null;
		private var DieCloseCombat:MovieClip = null;
		private var DieShoot:MovieClip = null;
		private var DieHead:MovieClip = null;

		private var CloseCombat:MovieClip = null;
		private var Hit:MovieClip = null;
		private var Shoot:MovieClip = null;
		private var Bullet:MovieClip = null;
		private var Eat:MovieClip = null;
		private var Fear:MovieClip = null;


        private var actual:MovieClip;
        private var defaultType:String;

        public function AnimatedModel(name:String = null, usedAnimations:Array = null, defaultAnimation:String = WALK)
        {
            if(!name)
                throw new ArgumentError("Error! Name is not set!");

            for each (var animation:String in usedAnimations)
            {
                if(this[animation] == null)
                {
                    this[animation] = new MovieClip(GraphicsManager.graphicsManager.getTextures(name+animation));
                    this[animation].name = animation;
                    this[animation].stop();
                    if(animation != WALK && animation != defaultAnimation)
                    {
                        (this[animation] as MovieClip).loop = false;
                        this[animation].addEventListener(Event.COMPLETE, onComplete);
                    }
                }
                else
                    throw new ArgumentError("Error! Animation does not exists!");
            }

            if(defaultAnimation && this[defaultAnimation])
            {

                defaultType = defaultAnimation;
                actual = this[defaultType];
				actual.play();
				addChild(actual);
                Starling.juggler.add(actual);
            }

            else
                throw new ArgumentError("Error! No default animation has been set or animation is not available!");

        }

        public function playAnimation(animation:String):void
        {
            if(actual == Walk || actual == this[defaultType] || actual.isComplete)
            {
                if(this[animation])
                {
                    Starling.juggler.remove(actual);
                    removeChild(actual);
                    actual.stop();
                    actual = this[animation];
                    addChild(actual);
                    actual.play();
                    Starling.juggler.add(actual);
                }
                else
                    throw new ArgumentError("Error! Animation does not exists!");
            }
        }

        private function onComplete(event:Event):void
        {
            Starling.juggler.remove(actual);
            removeChild(actual);
            actual.stop();
            if(actual.name.search("Die") == -1 && actual.name.search("Dead") == -1)
            {
                actual = this[defaultType];
                addChild(actual);
                actual.play();
                Starling.juggler.add(actual);
            }
        }

        public function getActualAnimation():MovieClip
        {
            return actual;
        }
    }
}
