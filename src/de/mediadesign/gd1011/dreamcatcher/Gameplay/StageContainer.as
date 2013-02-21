package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class StageContainer extends Sprite
	{
		public static const LIST_TYPE_IMAGE:String = "Image";
		public static const LIST_TYPE_CONTAINER:String = "Container";

		private var containers:Vector.<DisplayObjectContainer>;
		private var contentList:Vector.<DisplayObject>;
		private var contentListBoss:Vector.<DisplayObject>;
		private var contentType:String;

		public function StageContainer(type:String = LIST_TYPE_IMAGE)
		{
			containers = new Vector.<DisplayObjectContainer>(2);
			contentList = new Vector.<DisplayObject>();
			contentListBoss = new Vector.<DisplayObject>();
			contentType = type;

			for (var i:int = 0; i < containers.length; i++)
			{
				containers[i] = new Sprite();
				containers[i].width  = Starling.current.viewPort.width;
				containers[i].height = Starling.current.viewPort.height;
				containers[i].x = i * Starling.current.viewPort.width;
				addChild(containers[i]);
			}
		}

		public function fill(loadingList:Array, boss:Boolean):void
		{
			var path:String;
			switch(contentType)
			{
				case(LIST_TYPE_IMAGE):
					for each (path in loadingList)
						if(!boss)
							contentList.push(GraphicsManager.graphicsManager.getImage(path));
						else
							contentListBoss.push(GraphicsManager.graphicsManager.getImage(path));
					break;
				case(LIST_TYPE_CONTAINER):
					for each (var list:Array in loadingList)
					{
						if(!boss)
							contentList.push(new Sprite());
						else
							contentListBoss.push(new Sprite());
						for each (path in list)
							if(!boss)
								(contentList[contentList.length-1] as DisplayObjectContainer).addChild(GraphicsManager.graphicsManager.getImage(path));
							else
								(contentListBoss[contentListBoss.length-1] as DisplayObjectContainer).addChild(GraphicsManager.graphicsManager.getImage(path));
					}
			}
			for (var i:int = 0; i < containers.length; i++)
				if(!boss)
					containers[i].addChild(contentList.shift());
			for (i=0;i<contentList.length;i++)
				contentList[i].name = "normal";
			for (i=0;i<contentListBoss.length;i++)
				contentListBoss[i].name = "boss";
		}

		public function move(speed:Number):void
		{
			for (var i:int = 0; i < containers.length; i++)
				(containers[i].x > -containers[i].width) ? (containers[i].x -= speed) :
						(containers[i].x = (containers[(i==containers.length-1)?0:i+1].x + containers[(i==containers.length-1)?0:i+1].width) - speed);
		}

		public function swap(boss:Boolean):void
		{
			for (var i:int = 0; i < containers.length; i++)
			{
				if(containers[i].x <= -containers[i].width)
				{
					if(!boss)
					{
						contentList.push(containers[i].removeChildAt(0));
						containers[i].addChild(contentList.splice(Math.floor(Math.random()*contentList.length), 1)[0]);
					}
					else
					{
						if(containers[i].getChildAt(0).name == "boss")
							contentListBoss.push(containers[i].removeChildAt(0));
						else
							containers[i].removeChildAt(0);
						containers[i].addChild(contentListBoss.splice(Math.floor(Math.random()*contentListBoss.length), 1)[0]);
					}
				}
			}
		}
	}
}
