package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

class LoadingState extends FlxState
{
	override public function create()
	{
		super.create();
		var fuckingbutton = new FlxButton(0, 0, 'Click me to Start!', function()
		{
			FlxG.switchState(new MainMenuState());
		});
		fuckingbutton.scale.set(1.5);
		// HAXE NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO #2
		new FlxTimer().start(5, function(tmr:FlxTimer)
		{
			add(fuckingbutton);
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	// Audio Pausing
	override public function onFocus()
	{
		super.onFocus();
	}

	override public function onFocusLost()
	{
		super.onFocusLost();
	}
}
