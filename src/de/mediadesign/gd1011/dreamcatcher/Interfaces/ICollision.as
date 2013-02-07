/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 06.02.13
 * Time: 14:53
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
	import de.mediadesign.gd1011.dreamcatcher.Entity;

	public interface ICollision
	{
		function checkCollision(entityA:Entity, entityB:Entity):Boolean
	}
}
