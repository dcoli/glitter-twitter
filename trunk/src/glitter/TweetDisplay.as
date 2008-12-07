package glitter
{
	import flash.events.MouseEvent;
	import flash.filters.*;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.core.Application;
	import mx.styles.StyleManager;
	
	public class TweetDisplay extends Canvas
	{
		static private var MAX_TWEET:Number = 200;
		private var disp:Canvas;
		private var username:String;
		private var password:String;
		private var selected:Object;
		private var controller:ApplicationController;
		
		public function TweetDisplay()
		{
			// obtain the controller
			controller = Application.application.getController();
			
			disp = new Canvas();
			disp.setStyle("left", 10);
			disp.setStyle("right", 10);
			disp.setStyle("bottom", 110);
			disp.setStyle("top", 20);
			disp.setStyle("backgroundColor", 0x6aaec7);
			disp.verticalScrollPolicy = "on";
			
			addChild(disp);
		}
		
		public function getUserUpdates(username:String):void {
			controller.getUserUpdates(username);
			
		}
		
		public function showTweets(statuses:ArrayCollection):void {
		 	disp.removeAllChildren();
			disp.graphics.clear();
				
			var tweets:ArrayCollection = statuses;
			var counter:uint = 2;
			var i:int;
			var j:int = 19;
				
			for(i =0; i<MAX_TWEET; i++){
				if(tweets.length <= i) break;
				else{
					//var item:Object = tweets.getItemAt(i);
					var st:Status = tweets.getItemAt(i) as Status;
					var t:Tweet = new Tweet(st, this);
					t.setStyle("left", 0);
					t.setStyle("right", 0);
					t.y = counter;		
					disp.addChild(t);
					counter += t.getHeight() + 2;
					t.addEventListener(MouseEvent.CLICK, clicked);
				}
			}
		}
		
		private function clicked(e:MouseEvent):void {
			var glow:GlowFilter = new GlowFilter();
            glow.color = StyleManager.getColorName("lime");
            glow.alpha = 0.8;
            glow.blurX = 4;
            glow.blurY = 4;
            glow.strength = 4;
            glow.quality = BitmapFilterQuality.HIGH;
            
			if(e.currentTarget.isReply){
				if(selected!=null)
					selected.filters = null;
				e.currentTarget.filters = [glow];
				selected = e.currentTarget;
			}
		}
	}
}
