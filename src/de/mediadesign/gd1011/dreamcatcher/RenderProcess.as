package de.mediadesign.gd1011.dreamcatcher
{
	public class RenderProcess
    {
        private var manager:EntityManager;

        public function RenderProcess(manager:EntityManager):void
        {
            this.manager = manager
        }

        public function update():void
        {
            for each (var entity:Entity in manager.entities)
				entity.render();
		}
	}
}
