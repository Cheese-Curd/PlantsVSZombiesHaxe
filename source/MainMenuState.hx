package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class MainMenuState extends FlxState
{
	override public function create()
	{
		super.create();

		var sprite_test:FlxSprite;

		// Plays the Main Menu Theme (Dave Intro)
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg', 1, true);

		sprite_test = new FlxSprite();
		sprite_test.loadGraphic('assets/images/peashooter_placeholder.png');
		sprite_test.x = 100;
		sprite_test.y = 0;

		add(sprite_test);

		FlxTween.tween(sprite_test, {x: FlxG.width - sprite_test.width, y: FlxG.height - sprite_test.height, angle: 360.0}, 5, {type: FlxTweenType.PINGPONG});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
