package;

import flixel.util.FlxSave;
import AngelUtils; // for json reading
import discord_rpc.DiscordRpc;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;
import DebugUtils; // Funny debug
import Plant;
import Lawn;
import SeedPacket;

typedef LevelJson= 
{
    var ?flags:Int;
    var lawn:String;
    var possibleZombies:Array<String>;
}

class LawnState extends FlxState
{
	override public function onFocus()
	{
		super.onFocus();
		FlxG.sound.music.resume();
		trace("[SYSTEM] User Focused the window");
	}

	override public function onFocusLost()
	{
		super.onFocusLost();
		FlxG.sound.music.pause();
		trace("[SYSTEM] User Lost Focus the window");
	}
    
    var lawnJson:LevelJson;

	var plant:Plant;
	var zombie:Zombie;
	var background:Lawn;

    public static var curLevel:String = '1-1'; 
	public static var displayLevel:String = "1-1";
    public var zombieList:Array<Zombie> = []; 
    public var plantList:Array<Plant> = []; 

	public static var houseTxt:FlxText;

    override public function create()
    {
        // lawnJson = AngelUtils.JsonifyFile('assets/data/levels/${curLevel}');
		// trace('playing currently ${curLevel}');

		background = new Lawn(-220, 0, "grass", 9,5);
		add(background);

        plant = new Plant(100,100,"peashooter",false);
		add(plant);

		zombie = new Zombie(600,100,"basic",true);

		houseTxt = new FlxText(100,100);
        houseTxt.color = FlxColor.WHITE;
        houseTxt.borderStyle = OUTLINE;
        houseTxt.borderSize = 2;
        houseTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
		houseTxt.text = displayLevel;
		houseTxt.size = 14;
		add(houseTxt);
    }

}