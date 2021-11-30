package;

class DataShit
{
	/* Some info 
		So the reason I'm doing this is because some stupid error that may or not be an issue, and if you want to error here it is:
		Module MainMenuState does not define type MainMenuState For function argument 'nextState'

		This is at line 56 in PlayState.hx

		UPDATE: it fixed bruh
	 */
	public static var zombieType = [
		'basic', 'conehead', 'buckethead', 'pogo', 'gargantuar', 'ladder', 'digger', 'screendoor', 'football', 'polevault', 'newspaper', 'zombony', 'flag',
		'fucking_zomboss_lol'
	];
	public static var plantType = [
		'peashooter', 'sunflower', 'repeater', 'potato_mine', 'icepea', 'wallnut', 'tallnut', 'hypnoshroom', 'threepeater', 'puffshroom', 'cattail',
		'lilypad', 'squash'
	];
}

typedef Zombie =
{
	// health dumbass \\
	var health:Int;
	// zombie type \\
	var flag:Bool;
	var screendoor:Bool;
	var bucket:Bool;
	var cone:Bool;
	var football:Bool;
	var vault:Bool;
	var pogo:Bool;
	var ladder:Bool;
	var miner:Bool;
	var newspaper:Bool;
	var zombony:Bool;
	// speed lol \\
	var speed:String;
}

// Depricated, due to new saving process. \\

// typedef GameData =
// {
// 	var newgame:Bool;
// 	var world:Int;
// 	var level:Int;
// 	var minigames:Bool;
// 	var survival:Bool;
// 	var fastpool:Bool;
// }
