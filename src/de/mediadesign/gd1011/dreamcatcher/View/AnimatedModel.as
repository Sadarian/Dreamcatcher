package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.PowerUps;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementDieHead;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;

    import flash.utils.Dictionary;
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
		public static const DIE_HEAD:String = "DieHead";

		public static const CLOSE_COMBAT:String = "CloseCombat";
		public static const HIT:String ="Hit";
		public static const SHOOT:String ="Shoot";
        public static const SHOOT_WEB:String ="ShootWeb";
		public static const EAT:String = "Eat";
		public static const FEAR:String = "Fear";
        public static const STAND:String = "Stand";

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
                    if((name == GameConstants.BOSS1  || name == GameConstants.BOSS2) && animation == CLOSE_COMBAT)
                        mC = new MovieClip(GraphicsManager.graphicsManager.getTextures(name+animation+"_"), 9);
                    else
                        mC = new MovieClip(GraphicsManager.graphicsManager.getTextures(name+animation+"_"));
                    mC.name = animation;
                    mC.stop();
                    mC.x -= mC.width/2;
                    mC.y -= mC.height/2;
                    if(animation != WALK && animation != DEAD_WALK && animation != DIE_HEAD && animation != STAND)
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
            if(actual.loop || actual.isComplete || (entity.isBoss && animation == CLOSE_COMBAT) || (animation == DIE && entity.isVictim))
            {
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
                        if(name != GameConstants.PLAYERARM)
                            GraphicsManager.graphicsManager.playSound(name+animation);

                        if(animation == DIE)
                        {
                            if(!entity.isPlayer && name != GameConstants.PLAYERARM && !entity.isBullet)
                            {
                                Score.updateScore(entity);
                                PowerUps.checkDrop(entity);
                            }
                            if(!entity.isEnemy && !entity.isBoss1 && !entity.isVictim2)
                                entity.switchMovement(null);
                            if(entity.isVictim2)
                                entity.switchMovement(new MovementDieHead((entity.movementSystem as MovementVictim).speed));
                        }

	                    if (animation == DEAD_WALK)
	                    {
		                    actual.loop = false;
		                    trace("Enemy is dead!");
	                    }
                    }
                    else
                        throw new ArgumentError("Error! No +"+animation+" animation found!");
                }
            }
        }

        private function onComplete():void
        {
            checkDefault();
            Starling.juggler.remove(actual);
            removeChild(actual);
            switch(actual.name)
            {
                case(HIT):
                    if(entity.health<=0)
                    {
                        if(entity.name == GameConstants.BOSS2_BULLET_WEB)
                        {
                            EntityManager.entityManager.addUnusedEntity(entity);
                            GameStage.gameStage.removeActor(entity.movieClip);
                            entity.removeMovieClip();
                            break;
                        }
                        if(!entity.isEnemy && name != GameConstants.PLAYERARM)
                            entity.switchMovement(null);
                        else
                            entity.collisionMode = null;
                        entity.switchWeapon(null);
                        playAnimation(DIE);
                    }
                    else
                        playAnimation(defaultType);
                    break;

                case(DIE):
                    if(!entity.isEnemy && !entity.isVictim2)
                    {
                        if(entity.isBoss2)
                        {
                            MovementBoss.resetPhase();
                            GameStage.gameStage.endLvl("Congratulations! You have passed Level " + Game.currentLvl);
                            return;
                        }
                        if(name != GameConstants.PLAYERARM)
                            EntityManager.entityManager.addUnusedEntity(entity);
                        GameStage.gameStage.removeActor(entity.movieClip);
                        entity.removeMovieClip();
                    }
                    else
                    {
                        if(!entity.isVictim2)
                            playAnimation(DEAD_WALK);
                        else
                            playAnimation(DIE_HEAD);
                    }
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
                        if(entity.isBoss)
                            (entity.movementSystem as MovementBoss).switchTo(MovementBoss.MELEE);
                        playAnimation(defaultType);
                    }
                    break;

                case(FEAR):
                    playAnimation(WALK);
                    break;

                default:
                    playAnimation(defaultType);
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
            }
            actual = mAnimations[defaultType];
        }

        public function start():void
        {
            addChild(actual);
            actual.play();
            Starling.juggler.add(actual);
        }

        public function get isDead():Boolean
        {
            return ((actual.name == DEAD_WALK) || (actual.name == DIE) || (actual.name == DIE_CLOSE_COMBAT) || (actual.name == DIE_HEAD));
        }

        public static function createByType(type:String):AnimatedModel
        {
            return new AnimatedModel(type,
                    (GameConstants[type+"_States"])?GameConstants[type+"_States"]:null,
                    (GameConstants[type+"_Default"])?GameConstants[type+"_Default"]:AnimatedModel.WALK);
        }

        private function checkDefault():void
        {
            if(name != GameConstants.PLAYERARM)
                if(defaultType != (GameConstants[name+"_Default"])?GameConstants[name+"_Default"]:AnimatedModel.WALK)
                    defaultType = (GameConstants[name+"_Default"])?GameConstants[name+"_Default"]:AnimatedModel.WALK;
        }
    }
}
