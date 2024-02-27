package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.display.FPS;

class Main extends Sprite
{
	public static var fpsCounter:FPS;

	public function new()
	{
		super();
		addChild(new FlxGame(800, 600, LoadingState, 60, 60, false, false));
		FlxG.autoPause = false;

		// mouse \\
		FlxG.mouse.load('assets/images/cursor.png');

		#if !mobile
		fpsCounter = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsCounter);
		#end
	}
}
