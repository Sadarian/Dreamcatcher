package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;

    import flash.net.SharedObject;

    public class HighScore
    {
        public static function initHighScore():void
        {
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
            {
                if(!local.data["Score_"+i])
                    local.data["Score_"+i] = [10000-i*2000, "Frankenstein the "+(i+1)+"."];
            }
            local.flush();
        }

        public static function resetHighScore():void
        {
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
            {
                local.data["Score_"+i] = [10000-i*2000, "Frankenstein the "+(i+1)+"."];
            }
            local.flush();
        }

        public static function getHighScore():Array
        {
            var output:Array = [];
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
                output.push(local.data["Score_"+i]);
            return output;
        }

        public static function checkHighScore(value:Number):int
        {
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
                if(value>local.data["Score_"+i][0])
                    return i;
            return -1;
        }

        public static function saveScoreAt(value:Number, pos:int, user:String = "LocalPlayer"):void
        {
            var local:SharedObject = Dreamcatcher.localObject;
                local.data["Score_"+pos] = [value, user];
            local.flush();
        }
    }
}
