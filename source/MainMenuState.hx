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
	var peashooter:FlxSprite;
	var frame = 0;
	var framerate = 30;

	override public function create()
	{
		super.create();

		var cursor:FlxSprite;

		// Plays the Main Menu Theme (Dave Intro) \\
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');

		peashooter = new FlxSprite();

		// mouse \\
		cursor = new FlxSprite();
		cursor.loadGraphic('assets/images/cursor.png');
		FlxG.mouse.load(cursor);

		peashooter.loadGraphic('assets/images/peashooter.png', true, 250, 250);

		// Animation \\
		peashooter.animation.add("idle", framesArray(49), 30, true);

		add(peashooter);
		peashooter.x = 0;
		peashooter.y = 0;
	}

	// stuff for animation that might be scrapped lol \\
	function framesArray(num:Int)
	{
		var array:Array<Int> = new Array<Int>();
		for (i in 0...num)
			array.push(i);
		return array;
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
		if (FlxG.keys.justReleased.SPACE)
		{
			if (peashooter.animation.name == "idle")
			{
				peashooter.animation.pause();
			}
			else
			{
				peashooter.animation.play("idle");
			}
		}
		if (FlxG.keys.justReleased.RIGHT)
		{
			peashooter.animation.curAnim.curFrame = frame;
			peashooter.animation.pause();
			frame++;
			if (frame > 48)
			{
				frame = 0;
			}
			trace('frame = ' + frame);
		}
		if (FlxG.keys.justReleased.LEFT)
		{
			peashooter.animation.curAnim.curFrame = frame;
			peashooter.animation.pause();
			frame--;
			if (frame < 0)
			{
				frame = 48;
			}
			trace('frame = ' + frame);
		}
		if (FlxG.keys.justReleased.ESCAPE)
		{
			peashooter.animation.curAnim.curFrame = frame;
			peashooter.animation.resume();
		}
		if (FlxG.keys.justReleased.UP)
		{
			peashooter.animation.resume();
			peashooter.animation.curAnim.frameRate = framerate;
			framerate++;
			trace('framerate =' + framerate);
		}
		if (FlxG.keys.justReleased.DOWN)
		{
			peashooter.animation.resume();
			peashooter.animation.curAnim.frameRate = framerate;
			framerate--;
			if (framerate < 0)
			{
				framerate = 1;
			}
			trace('framerate =' + framerate);
		}
	}
}
