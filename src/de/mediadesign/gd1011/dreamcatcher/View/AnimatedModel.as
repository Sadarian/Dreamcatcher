package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import starling.display.DisplayObjectContainer;
    import starling.display.MovieClip;
    import starling.events.Event;

    public class AnimatedModel extends DisplayObjectContainer
    {
        public static const WALK:String = "walk";
        public static const DIE:String = "die";

        private var die:MovieClip;
        private var walk:MovieClip;

        private var actual:MovieClip;
        private var defaultType:String;

        public function AnimatedModel(name:String, usedAnimations:Vector.<String>, defaultAnimation:String)
        {
            if(!name)
                throw new ArgumentError("Error! Name is not set!");

            for each (var animation:String in usedAnimations)
            {
                if(AnimatedModel[animation])
                {
                    this[animation] = new MovieClip(GraphicsManager.graphicsManager.getTextures(name+"_"+animation));
                    this[animation].stop();
                    if(animation != WALK && animation != defaultAnimation);
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
            }

            else
                throw new ArgumentError("Error! No default animation has been set or animation is not available!");

        }

        public function playAnimation(animation:String):void
        {
            if(actual == walk || actual.isComplete)
            {
                if(this[animation])
                {
                    removeChild(actual);
                    actual.stop();
                    actual = this[animation];
                    addChild(actual);
                    actual.play();
                }
                else
                    throw new ArgumentError("Error! Animation does not exists!");
            }
        }

        private function onComplete(event:Event):void
        {
            removeChild(actual);
            actual.stop();
            actual = this[defaultType];
            addChild(actual);
            actual.play();
        }
    }
}
