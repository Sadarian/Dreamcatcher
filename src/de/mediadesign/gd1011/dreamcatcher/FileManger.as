/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 31.01.13
 * Time: 10:51
 * To change this template use File | Settings | File Templates.
 */

package de.mediadesign.gd1011.dreamcatcher {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class FileManger {

		public function FileManger() {
			readFile();
		}

		private static function readFile():String {
			var file:File = File.applicationDirectory.resolvePath("tempconfig.json");
			var stream:FileStream = new FileStream();

			stream.open(file, FileMode.READ);
			var dataString:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			return dataString;
		}

		public static function data():Object {
			var dataString:String = readFile();
			var fileData:Object = JSON.parse(dataString);
			return fileData;
		}
	}
}
