package;


import flash.display.BitmapDataChannel;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.text.TextField;
import flash.text.TextFormat;

import openfl.Assets;

class Main extends Sprite {
	
	private var background:Sprite;
	private var channel:SoundChannel;
	private var debug:TextField;
	private var track:Int;
	private var numtracks:Int;
	
	public function new () {
		
		super ();
		
		track = 0;
		numtracks = 4;
		
		var font = Assets.getFont ("assets/VeraSeBd.ttf");
		var format1:TextFormat = new TextFormat (font.fontName, 25, 0xffffff);

		debug = new TextField();
		
		debug.defaultTextFormat = format1;
		debug.text = "Tap screen for new track.";
		debug.x = 0;
		debug.y = 0;
		debug.width = 500;
		debug.height = 50;

		background = new Sprite ();
		background.graphics.beginFill (0x00);
		background.graphics.drawRect (0, 0, stage.stageWidth, stage.stageHeight);
		background.alpha = 1.0;
		background.buttonMode = true;
		background.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
		
		background.addChild(debug);
		addChild (background);
	}
	
	private function play(track:Int = 0):Void {
		var filename:String = "assets/sound" + track + ".ogg";
		
		var sound:Sound = Assets.getSound(filename);
		
		debug.text = "playing sound " + filename;
		
		if (sound != null){
			channel = sound.play();
		}
	}
	
	private function this_onMouseDown (event:MouseEvent):Void {
		if (channel != null) {
			channel.stop();
			channel = null;
		}
		
		play(track%numtracks);
		track++;
	}
}