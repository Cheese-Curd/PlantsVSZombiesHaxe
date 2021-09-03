package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class MainMenuState extends FlxState
{
	var peashooter:FlxSprite;
	var sunflower:FlxSprite;
	var frame = 0;
	var framerate = 30;

	override public function create()
	{
		super.create();

		// Plays the Main Menu Theme (Dave Intro) \\
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');

		peashooter = new FlxSprite();
		sunflower = new FlxSprite();

		peashooter.loadGraphic('assets/images/plants/peashooter.png', true, 254, 254);
		sunflower.loadGraphic('assets/images/plants/sunflower.png', true, 189, 189);

		// Animation \\
		peashooter.animation.add("idle", framesArray(49), 30, true);
		sunflower.animation.add("idle", framesArray(54), 30, true);
		// Antialiasing \\
		peashooter.antialiasing = true;
		sunflower.antialiasing = true;

		add(peashooter);
		add(sunflower);
		peashooter.x = 0;
		peashooter.y = 0;
		sunflower.x = 100;
		sunflower.y = 0;
		sunflower.animation.play("idle");
		peashooter.animation.play("idle");
		var playbutton = new FlxButton(0, 0, 'MainMenuState', function()
		{
			FlxG.switchState(new PlayState());
			FlxG.sound.music.stop();
		});
		add(playbutton);
	}

	// Animation Frames shit so it doesn't make the file giant \\
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
