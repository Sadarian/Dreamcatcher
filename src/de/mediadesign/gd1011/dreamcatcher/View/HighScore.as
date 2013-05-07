package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;

    import flash.net.SharedObject;

    public class HighScore
    {
        public static function initHighScore():void
        {
            var local:SharedObject = Dreamcatcher.localObject;
            for(var j:int = -1;j<3;j++)
                for(var i:int = 0; i<5; i++)
                {
                    if(!local.data["Level_"+j+"_Score_"+i])
                    {
                        local.data["Level_"+j+"_Score_"+i] = 10000-i*2000;
                        local.data["Level_"+j+"_Score_"+i+"_Name"] = "Frankenstein the "+(i+1)+".";
                    }
                }
            local.flush();
        }

        public static function resetHighScore():void
        {
            var local:SharedObject = Dreamcatcher.localObject;
            for(var j:int = -1;j<3;j++)
                for(var i:int = 0; i<5; i++)
                {
                    local.data["Level_"+j+"_Score_"+i] = 10000-i*2000;
                    local.data["Level_"+j+"_Score_"+i+"_Name"] = "Frankenstein the "+(i+1)+".";
                }
            local.flush();
        }

        public static function getHighScore(l:int):Array
        {
            var output:Array = [];
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
            {
                var temp:Array = [];
                temp.push(local.data["Level_"+l+"_Score_"+i], local.data["Level_"+l+"_Score_"+i+"_Name"]);
                output.push(temp);
            }
            return output;
        }

        public static function traceOutput(l:int):void
        {
            var output:Array = [];
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
            {
                var temp:Array = [];
                temp.push(local.data["Level_"+l+"_Score_"+i], local.data["Level_"+l+"_Score_"+i+"_Name"]);
                output.push(temp);
            }
            trace(output);
        }

        public static function checkHighScore(l:int, value:Number):int
        {
            var local:SharedObject = Dreamcatcher.localObject;
            for(var i:int = 0; i<5; i++)
                if(value>local.data["Level_"+l+"_Score_"+i])
                    return i;
            return -1;
        }

        public static function saveScoreAt(level:int, value:Number, pos:int, user:String = "LocalPlayer"):void
        {
            var local:SharedObject = Dreamcatcher.localObject;
            local.data["Level_"+level+"_Score_"+pos] = value;
            local.data["Level_"+level+"_Score_"+pos+"_Name"] = user;
            local.flush();
        }
    }
}
