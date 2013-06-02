package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.Score;

    import flash.geom.Point;
    import starling.core.Starling;

    public class EndlessMode
    {
        private static var damageMultiplier:Number = 1;
        private static var _pointMultiplier:Number = 1;

        private static var self:EndlessMode;

        private var timeTilNextBoss:Number;
        private var timeTilNextEntity:Number;
        private var lastEntityTypes:Array;
        private var activePlayTime:Number;
        private var viewWidth:Number;
        private var viewHeight:Number;
        private var difficultOffsets:Array;
        private var difficultMultiplier:Array;
        private var difficult:int;
        private var activateHarderEntities:Boolean;
        private var activateEvenHarderEntities:Boolean;
        private var allowedChargers:int;
        private var chargerCountRange:int;
        private var allowedVictims:int;
        private var victimCountRange:int;
        private var allowedMiniBosses:int;
        private var miniBossesCountRange:int;
        private var healthForVictims:Number;
        private var bossActive:Boolean;
        private var boss:Entity;

        public static function get instance():EndlessMode
        {
            if(!self)
            {
                self = new EndlessMode();
            }
            return self;
        }

        public static function get hasInstance():Boolean
        {
            return (self != null);
        }

        public function EndlessMode()
        {
            _pointMultiplier = 1;
            timeTilNextBoss = 5+GameConstants.endlessBossWait;
            timeTilNextEntity = 5;
            lastEntityTypes = [];
            activePlayTime = 0.0;
            viewWidth = Starling.current.viewPort.width*1.1;
            viewHeight = Starling.current.viewPort.height;
            difficultOffsets = [0.3, 0.1, 0.7, 0.5, 0.4];
            difficultMultiplier = [1.50, 0.66, 1.33, 1.00, 0.80];
            difficult = 0;
            activateHarderEntities = false;
            activateEvenHarderEntities = false;
            allowedChargers = 2;
            chargerCountRange = 2;
            allowedVictims = 4;
            victimCountRange = 5;
            allowedMiniBosses = 2;
            miniBossesCountRange = 5;
            healthForVictims = 0.9;
            bossActive = false;
            boss = null;
        }

        public function update(passedTime:Number):void
        {
            if(!bossActive)
            {
                activePlayTime += passedTime;

                timeTilNextBoss -= passedTime;
                if(timeTilNextBoss<=0)
                {
                    timeTilNextBoss = GameConstants.endlessBossWait;
                    bossActive = true;
                    boss = EntityManager.entityManager.createEntity(GameConstants.BOSS2, new Point(viewWidth/1.1, 480));
                    Starling.juggler.delayCall(stopInit, 3.00);
                    function stopInit():void
                    {
                        MovementBoss.incoming = false;
                    }
                    return;
                }

                timeTilNextEntity -= passedTime;
                if(timeTilNextEntity<=0)
                {
                    var types:Array = AllowedTypes;
                    var entityType:String = types.splice(Math.random()*types.length, 1);
                    lastEntityTypes.unshift(entityType);
                    if(lastEntityTypes.length>50)
                        lastEntityTypes = lastEntityTypes.slice(0, 50);
                    EntityManager.entityManager.createEntity(entityType, new Point(viewWidth, (0.3+(Math.random()*0.4))*viewHeight));
                    var i:int = getIntByType(entityType);
                    timeTilNextEntity += difficultOffsets[i] + (difficultMultiplier[i] * Math.random());
                }
            }
            else
                if(boss.getAnimatedModel().ActualAnimation.name == AnimatedModel.DIE)
                {
                    bossActive = false;
                    boss = null;
                    increaseDifficulty();
                }
        }

        private static function getIntByType(type:String):int
        {
            switch (type)
            {
                case(GameConstants.ENEMY):
                    return 0;
                case(GameConstants.VICTIM1):
                    return 1;
                case(GameConstants.CHARGER):
                    return 2;
                case(GameConstants.VICTIM2):
                    return 3;
                case(GameConstants.MINIBOSS):
                    return 4;
            }
            return -1;
        }

        private function increaseDifficulty():void
        {
            difficult++;
            switch(difficult)
            {
                case(1):
                {
                    difficultOffsets = [0.25, 0.35, 0.60, 0.75, 0.4];
                    difficultMultiplier = [1.25, 1.00, 1.16, 1.20, 0.80];
                    activateHarderEntities = true;
                    healthForVictims = 0.8;
                    break;
                }
                case(2):
                {
                    difficultOffsets = [0.20, 0.50, 0.50, 0.90, 0.4];
                    difficultMultiplier = [1.00, 1.20, 1.00, 1.40, 0.80];
                    activateEvenHarderEntities = true;
                    allowedChargers = 3;
                    chargerCountRange = 3;
                    allowedVictims = 3;
                    healthForVictims = 0.75;
                    break;
                }
                case(3):
                {
                    difficultOffsets = [0.15, 0.65, 0.40, 1.05, 0.4];
                    difficultMultiplier = [0.75, 1.40, 0.83, 1.60, 0.80];
                    victimCountRange = 6;
                    allowedMiniBosses = 3;
                    healthForVictims = 0.7;
                    break;
                }
                case(4):
                {
                    difficultOffsets = [0.3, 0.1, 0.7, 0.5, 0.4];
                    difficultMultiplier = [1.50, 0.66, 1.33, 1.00, 0.80];
                    activateHarderEntities = false;
                    activateEvenHarderEntities = false;
                    allowedChargers = 2;
                    chargerCountRange = 2;
                    allowedVictims = 4;
                    victimCountRange = 5;
                    healthForVictims += 0.1;
                    damageMultiplier += 0.5;
                    difficult = 0;
                }
            }
            trace("Difficulty " + difficult + " actual Damage Multiplier: " + damageMultiplier);
        }

        private function get AllowedTypes():Array
        {
            var output:Array = [GameConstants.ENEMY];

            if(activateHarderEntities && (lastTypeAmount(GameConstants.CHARGER, chargerCountRange) < allowedChargers))
                output.push(GameConstants.CHARGER);

            var player:Entity = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
            if(player.health / player.maxHealth < healthForVictims)
            {
                if(lastTypeAmount(GameConstants.VICTIM1, victimCountRange)+lastTypeAmount(GameConstants.VICTIM2, victimCountRange) < allowedVictims)
                    output.push(GameConstants.VICTIM1);

                if(activateHarderEntities && lastTypeAmount(GameConstants.VICTIM2, victimCountRange) < allowedVictims)
                    output.push(GameConstants.VICTIM2);
            }

            if(activateEvenHarderEntities && lastTypeAmount(GameConstants.MINIBOSS, miniBossesCountRange) < allowedMiniBosses)
                output.push(GameConstants.MINIBOSS);

            return output;
        }

        private function lastTypeAmount(checkFor:String, checkLength:int):int
        {
            var amount:int = 0;
            if(lastEntityTypes.length == 0)
                return amount;
            var i:int;
            for(i = 0;i<((checkLength>lastEntityTypes.length)?lastEntityTypes.length:checkLength);i++)
                if(lastEntityTypes[i] == checkFor)
                    amount++;
            return amount;
        }

        public static function reset():void
        {
            self = null;
            damageMultiplier = 1;
            Score.updateMultiplier();
        }

        public static function getDamageMultiplier(target:String):Number
        {
            if(target == GameConstants.PLAYER)
                return damageMultiplier;
            return 1;
        }

        public static function get pointMultiplier():Number
        {
            return _pointMultiplier;
        }

        public static function set pointMultiplier(value:Number):void
        {
            _pointMultiplier = value;
        }
    }
}
