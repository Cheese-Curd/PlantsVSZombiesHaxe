package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	var planttype = 'peashooter';
	var plant:FlxSprite;

	// Character shit \\

	function framesArray(num:Int)
	{
		var array:Array<Int> = new Array<Int>();
		for (i in 0...num)
			array.push(i);
		return array;
	}

	override public function create()
	{
		super.create();
		FlxG.sound.playMusic('assets/music/grasswalk.ogg');
		plant = new FlxSprite();
	}

	function getPlant()
	{
		switch (planttype)
		{
			case 'sunflower':
				plant.loadGraphic('assets/images/plants/sunflower.png', true, 189, 189);
				plant.animation.add("idle", framesArray(54), 30, true);
			case 'peashooter':
				plant.loadGraphic('assets/images/plants/peashooter.png', true, 254, 254);
				plant.animation.add("idle", framesArray(49), 30, true);
		};
		add(plant);
		plant.antialiasing = true; // just so the sprites don't look bad when doing shit lol
		plant.animation.play("idle"); // play the animation so they don't stand still
		var menubutton = new FlxButton(0, 0, 'MainMenuState', function()
		{
			FlxG.switchState(new MainMenuState());
		});
		add(menubutton);
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
		if (FlxG.keys.justReleased.S)
		{
			planttype = 'sunflower';
			getPlant();
		}
		if (FlxG.keys.justReleased.P)
		{
			planttype = 'peashooter';
			getPlant();
		}
	}
}
