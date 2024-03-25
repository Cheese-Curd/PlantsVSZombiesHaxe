package;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class SleepingSubState extends FlxSubState
{

	override public function create():Void
	{
		super.create();

		if (_parentState != null)
		{
			// you can keep updating parent state if you want to, but keep in mind that
			// if you will update parent state then you will update buttons in it,
			// so you need to deactivate buttons in parent state
			_parentState.persistentUpdate = !_parentState.persistentUpdate;
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function onClick()
	{
		close();
	}

	// This function will be called by substate right after substate will be closed
	public static function onSubstateClose():Void {}
}
