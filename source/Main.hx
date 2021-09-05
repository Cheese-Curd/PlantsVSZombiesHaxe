package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MainMenuState));
		FlxG.autoPause = false;

		// mouse \\
		FlxG.mouse.load('assets/images/cursor.png');
	}

	// HAXE NOOOOOOOOOOOOOOOOOOOOOOOOO
	public function onFocusLost()
	{
		FlxG.sound.music.pause();
		trace("User Lost Focus the window");
	}

	public function onFocus()
	{
		FlxG.sound.music.resume();
		trace("User Focused the window");
	}
}
