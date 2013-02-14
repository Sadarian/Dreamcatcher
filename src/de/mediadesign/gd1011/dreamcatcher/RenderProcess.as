package de.mediadesign.gd1011.dreamcatcher
{
	public class RenderProcess
    {

        public function RenderProcess():void
        {
        }

        public function update():void
        {
            for each (var entity:Entity in EntityManager.entityManager.entities)
				entity.render();
		}
	}
}
