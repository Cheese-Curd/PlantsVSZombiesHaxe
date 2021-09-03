package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class MainMenuState extends FlxState
{
	override public function create()
	{
		super.create();

		var sprite_test:FlxSprite;
		var cursor:FlxSprite;

		// Plays the Main Menu Theme (Dave Intro)
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');

		sprite_test = new FlxSprite();
		cursor = new FlxSprite();

		sprite_test.loadGraphic('assets/images/peashooter_placeholder.png');
		sprite_test.x = 100;
		sprite_test.y = 0;

		cursor.loadGraphic('icons/cursor.png');

		FlxG.mouse.load(cursor);

		add(sprite_test);

		FlxTween.tween(sprite_test, {x: FlxG.width - sprite_test.width, y: FlxG.height - sprite_test.height, angle: 360.0}, 5, {type: FlxTweenType.PINGPONG});
	}

	// HAXE NOOOOOOOOOOOOOOOOOOOOOOOOO
	override public function onFocusLost()
	{
		super.onFocusLost();
		FlxG.sound.music.pause();
		trace("User Lost Focus the window");
	}

	override public function onFocus()
	{
		super.onFocus();
		FlxG.sound.music.resume();
		trace("User Focused the window");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
