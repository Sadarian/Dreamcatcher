package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
import de.mediadesign.gd1011.dreamcatcher.Gameplay.PowerUps;

import flash.utils.Dictionary;

import mx.core.FlexMovieClip;

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
		public static const EAT:String = "Eat";
		public static const FEAR:String = "Fear";

        private var mAnimations:Dictionary;
        private var actual:MovieClip;
        private var defaultType:String;
        private var entity:Entity;

        public function AnimatedModel(name:String, usedAnimations:Array, defaultAnimation:String)
        {
            this.name = name;
            mAnimations = new Dictionary();
            var mC:MovieClip;

            if(!name)
                throw new ArgumentError("Error! Name is not set!");

            for each (var animation:String in usedAnimations)
            {
                if(animation in mAnimations)
                    throw  new Error("Duplicate animation name: " + animation);
                else
                {
                    mC = new MovieClip(GraphicsManager.graphicsManager.getTextures(name+animation+"_"));
                    mC.name = animation;
                    mC.stop();
                    mC.x -= mC.width/2;
                    mC.y -= mC.height/2;
                    if(animation != WALK && animation != DEAD_WALK)
                    {
                        mC.loop = false;
                        mC.addEventListener(Event.COMPLETE, onComplete);
                    }
                    mAnimations[animation] = mC;
                }
            }

            if(defaultAnimation)
            {
                if(defaultAnimation in mAnimations)
                    throw  new Error("Duplicate animation name: " + defaultAnimation);
                else
                {
                    defaultType = defaultAnimation;
                    mC = new MovieClip(GraphicsManager.graphicsManager.getTextures(name+defaultAnimation));
                    mC.name = defaultAnimation;
                    mC.stop();
                    mC.x -= mC.width/2;
                    mC.y -= mC.height/2;
                    mAnimations[defaultType] = mC;
                    actual = mC;
                    actual.play();
                    addChild(actual);
                    Starling.juggler.add(actual);
                }
            }
            else
                throw new ArgumentError("Error! No default animation has been set or animation is not available!");
        }

        public function playAnimation(animation:String):void
        {
            if(actual == mAnimations[WALK] || actual == mAnimations[defaultType] || actual.isComplete)
            {
                if(animation in mAnimations)
                {
                    Starling.juggler.remove(actual);
                    removeChild(actual);
                    actual.stop();
                    actual = mAnimations[animation];
                    addChild(actual);
                    actual.play();
                    Starling.juggler.add(actual);
                    if(animation == DIE_CLOSE_COMBAT)
                    {
                        entity.switchMovement(null);
                        entity.switchWeapon(null);
                    }
                }
                else
                    throw new ArgumentError("Error! No +"+animation+" animation found!");
            }
        }

        private function onComplete(event:Event):void
        {
            Starling.juggler.remove(actual);
            removeChild(actual);
            switch(actual.name)
            {
                case(HIT):
                    if(entity.health<=0)
                    {
                        if(!entity.isEnemy && name != GameConstants.PLAYERARM)
                            entity.switchMovement(null);
                        else
                            entity.collisionMode = null;
                        entity.switchWeapon(null);
                        playAnimation(DIE);
                    }
                    else if(entity.isPlayer)
                    {
                        actual = mAnimations[defaultType];
                        addChild(actual);
                        actual.play();
                        Starling.juggler.add(actual);
                    }
                    break;

                case(DIE):
                    if(!entity.isPlayer && name != GameConstants.PLAYERARM)
                    {
                        Score.updateScore(entity);
                        PowerUps.checkDrop(entity);
                    }

                    if(!entity.isEnemy)
                    {
                        if(!entity.isEnemy && name != GameConstants.PLAYERARM)
                            EntityManager.entityManager.addUnusedEntity(entity);
                        GameStage.gameStage.removeActor(entity.movieClip);
                        entity.removeMovieClip();
                    }
                    else
                        playAnimation(DEAD_WALK);
                    break;

                case(DIE_CLOSE_COMBAT):
                    EntityManager.entityManager.addUnusedEntity(entity);
                    GameStage.gameStage.removeActor(entity.movieClip);
                    entity.removeMovieClip();
                    break;

                case(CLOSE_COMBAT):
                    if(entity.health<=0)
                        playAnimation(DIE);
                    else
                    {
                        actual = mAnimations[defaultType];
                        addChild(actual);
                        actual.play();
                        Starling.juggler.add(actual);
                    }
                    break;

                case(FEAR):
                    playAnimation(WALK);
                    break;

                default:
                    actual = mAnimations[defaultType];
                    addChild(actual);
                    actual.play();
                    Starling.juggler.add(actual);
            }
        }

        public function get ActualAnimation():MovieClip
        {
            return actual;
        }

        public function set owner(entity:Entity):void
        {
            this.entity = entity;
        }

        public function reset():void
        {
            entity = null;
            for each (var animation:MovieClip in mAnimations)
            {
                Starling.juggler.remove(animation);
                animation.stop();
                removeChild(animation);
                actual = mAnimations[defaultType];
            }
        }

        public function start():void
        {
            addChild(actual);
            actual.play();
            Starling.juggler.add(actual);
        }
    }
}
