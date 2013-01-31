package de.mediadesign.gd1011.dreamcatcher
{
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Game extends Sprite
    {
        private var entityManager:EntityManager;

		public function Game()
        {
            entityManager = new EntityManager();

            if(GameConstants.testBoolean)
            {
                var textfield:TextField = new TextField(GameConstants.testNumber, GameConstants.testNumber, GameConstants.testString);
                addChild(textfield);
            }
		}
	}
}
