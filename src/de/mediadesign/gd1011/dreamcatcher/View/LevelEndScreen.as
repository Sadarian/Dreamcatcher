/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 22.02.13
 * Time: 14:14
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.View
{
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class LevelEndScreen
	{
		private var _alpha:Number;
		private var text:String;
		private var _screen:Sprite;

		public function LevelEndScreen(text:String, alpha:Number = 0)
		{
			_alpha = alpha;
			this.text = text;
			_screen = new Sprite();
			_screen.addChild(new Quad(Starling.current.viewPort.width,Starling.current.viewPort.height, 0x000000));
			_screen.alpha = _alpha;

		}

		public function fadeIn():void {
			_screen.alpha = _alpha;
			if (_alpha >= 1)
			{
				var textField:TextField;
				_screen.addChild(textField = new TextField(300, 100, text, "FriskyVampire", 50, 0xffffff));
				textField.x = _screen.width/2;
				textField.y = _screen.height/2;
			}
		}

		public function get alpha():Number {
			return _alpha;
		}

		public function set alpha(value:Number):void {
			_alpha = value;
		}

		public function get screen():Sprite {
			return _screen;
		}
	}
}
