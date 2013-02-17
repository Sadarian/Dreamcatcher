package de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision
{
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;

	public interface ICollision
	{
		function checkCollision(entityA:Entity, entityB:Entity):Boolean
	}
}
