package;

class DataShit
{
	/* Some info 
		So the reason I'm doing this is because some stupid error that may or not be an issue, and if you want to error here it is:
		Module MainMenuState does not define type MainMenuState For function argument 'nextState'

		This is at line 56 in PlayState.hx

		UPDATE: it fixed bruh
	 */
}

typedef Zombie =
{
	// health dumbass \\
	var health:Int;
	// zombie type \\
	var screendoor:Bool;
	var bucket:Bool;
	var cone:Bool;
	var footbal:Bool;
	var vault:Bool;
	var pogo:Bool;
	var ladder:Bool;
	var miner:Bool;
	var newspaper:Bool;
	var zombony:Bool;
	// speed lol \\
	var speed:String;
}

typedef GameData =
{
	var newgame:Bool;
	var world:String;
	var level:String;
	var minigames:Bool;
	var survival:Bool;
}
