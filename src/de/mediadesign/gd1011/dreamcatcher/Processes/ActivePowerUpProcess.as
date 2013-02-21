/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 21.02.13
 * Time: 11:37
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.Processes
{
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	public class ActivePowerUpProcess
	{
		public static function update(deltaTime:Number):void
		{
			PowerUpTrigger.updateDuration(deltaTime);
		}
	}
}
