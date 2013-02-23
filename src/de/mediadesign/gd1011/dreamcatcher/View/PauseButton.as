/**
 * Created with IntelliJ IDEA.
 * User: rolehmann
 * Date: 23.02.13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import starling.display.Button;
    import starling.events.Event;


    public class PauseButton extends Button
    {
        public function PauseButton()
        {
            super(GraphicsManager.graphicsManager.getTexture("PauseButton"), "", GraphicsManager.graphicsManager.getTexture("PauseButton"));
            x = 560;
            y = 500;
            enabled = true;
            scaleWhenDown = 0.5;
            useHandCursor = true;

            addEventListener(Event.TRIGGERED, PauseMenu.showAndHide);
        }
    }
}
