/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 31.01.13
 * Time: 10:21
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {

	import starling.display.Sprite;
	import starling.text.TextField;

	public class Game extends Sprite{
		public function Game() {
			var text:String = FileManger.data().test;
			var textfield:TextField = new TextField(200, 200, text);
			addChild(textfield);
		}
	}
}
