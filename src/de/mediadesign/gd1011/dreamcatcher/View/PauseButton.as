package de.mediadesign.gd1011.dreamcatcher.View
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
import de.mediadesign.gd1011.dreamcatcher.View.Menu.PauseMenu;

	import starling.core.Starling;

	import starling.display.Button;
    import starling.events.Event;


    public class PauseButton extends Button
    {
        public function PauseButton()
        {
            super(GraphicsManager.graphicsManager.getTexture("PauseButton"), "", GraphicsManager.graphicsManager.getTexture("PauseButton"));
            x = Starling.current.viewPort.width - 140;
            y = 20;
            enabled = true;
            scaleWhenDown = 0.5;
            useHandCursor = true;

            addEventListener(Event.TRIGGERED, PauseMenu.showAndHide);
        }
    }
}
