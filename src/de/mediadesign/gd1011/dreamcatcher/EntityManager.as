package de.mediadesign.gd1011.dreamcatcher
{
    import flash.utils.getQualifiedClassName;

    import starling.display.Sprite;
    import starling.events.Event;

    public class EntityManager extends Sprite
    {
        private var entities:Vector.<Entity>;

        public function EntityManager()
        {
            entities = new Vector.<Entity>();

            addEventListener(Event.ENTER_FRAME, update);
        }

        public function update(e:Event):void
        {
            for (var i:int = 0;i<entities.length;i++)
                entities[i].update()
        }

        public function destroy():void
        {
            for (var i:int=0;i<entities.length;i++)
                entities[i].destroy();

            removeEventListener(Event.ENTER_FRAME, update);
        }
    }
}
