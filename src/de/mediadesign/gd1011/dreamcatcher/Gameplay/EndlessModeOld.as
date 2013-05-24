package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;

    import flash.geom.Point;
    import starling.core.Starling;

    public class EndlessModeOld
    {
        private static const activateHarderEntities:Number = 90;
        private static var damageMultiplier:Number = 1;

        private static var self:EndlessMode;

        private var timeTilNextEntity:Number;
        private var lastEntityTypes:Array;
        private var activePlayTime:Number;
        private var viewWidth:Number;
        private var viewHeight:Number;
        private var difficultOffsets:Array;
        private var difficultMultiplier:Array;
        private var difficult:int;
        private var allowedChargers:int;
        private var chargerCountRange:int;
        private var allowedVictims:int;
        private var victimCountRange:int;
        private var healthForVictims:Number;

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

        public function EndlessModeOld()
        {
            timeTilNextEntity = 2.5;
            lastEntityTypes = [];
            activePlayTime = 0.0;
            viewWidth = Starling.current.viewPort.width*1.1;
            viewHeight = Starling.current.viewPort.height;
            difficultOffsets = [0.3, 0.1, 0.7, 0.5];
            difficultMultiplier = [1.50, 0.66, 1.33, 1.00];
            difficult = 0;
            allowedChargers = 2;
            chargerCountRange = 2;
            allowedVictims = 4;
            victimCountRange = 5;
            healthForVictims = 0.9;
        }

        public function update(passedTime:Number):void
        {
            activePlayTime += passedTime;
            timeTilNextEntity -= passedTime;
            checkDifficulty(activePlayTime);
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
            }
            return -1;
        }

        private function checkDifficulty(time:Number):void
        {
            if(difficult == 0 && time>120)
            {
                difficultOffsets = [0.25, 0.35, 0.60, 0.75];
                difficultMultiplier = [1.25, 1.00, 1.16, 1.20];
                allowedChargers = 3;
                chargerCountRange = 3;
                healthForVictims = 0.8;
                difficult = 1;
            }

            if(difficult == 1 && time>180)
            {
                difficultOffsets = [0.20, 0.50, 0.50, 0.90];
                difficultMultiplier = [1.00, 1.20, 1.00, 1.40];
                allowedVictims = 3;
                healthForVictims = 0.75;
                difficult = 2;
            }

            if(difficult == 2 && time>240)
            {
                difficultOffsets = [0.15, 0.65, 0.40, 1.05];
                difficultMultiplier = [0.75, 1.40, 0.83, 1.60];
                victimCountRange = 6;
                healthForVictims = 0.7;
                difficult = 3;
            }
        }

        private function get AllowedTypes():Array
        {
            var output:Array = [GameConstants.ENEMY];

            if(activePlayTime>activateHarderEntities && (lastTypeAmount(GameConstants.CHARGER, chargerCountRange) < allowedChargers))
                output.push(GameConstants.CHARGER);

            var player:Entity = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
            if(player.health / player.maxHealth < healthForVictims)
            {
                if(lastTypeAmount(GameConstants.VICTIM1, victimCountRange)+lastTypeAmount(GameConstants.VICTIM2, victimCountRange) < allowedVictims)
                    output.push(GameConstants.VICTIM1);

                if(activePlayTime>activateHarderEntities && lastTypeAmount(GameConstants.VICTIM2, victimCountRange) < allowedVictims)
                    output.push(GameConstants.VICTIM2);
            }
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
        }

        public static function getDamageMultiplier(target:String):Number
        {
            if(target == GameConstants.PLAYER)
                return damageMultiplier;
            return 1;
        }
    }
}
