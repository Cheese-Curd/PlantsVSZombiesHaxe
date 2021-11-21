package;

import AngelUtils; // for masking and reading json lol
import DataShit; // getting data
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIInputText;
import DebugUtils;

using flixel.util.FlxSpriteUtil;

#if windows
import discord_rpc.DiscordRpc;
#end

class DevStart extends FlxState
{
	var logintext:FlxText;
	var loginbutton:FlxButton;
	var loginbox:FlxUIInputText; // no fucking idea if this is the actuall thing for a text box, probably not, but can't check ;)
	var password = 'hehedev';
	
	override public function create()
	{
		logintext = new FlxText(0,0, 'PRIVATE DEV BUILD 2 LOGIN');
		loginbutton = new FlxButton(27,36, 'LOGIN', check);
		loginbox = new FlxUIInputText(15,16, 100, 'yes');
		add(logintext);
		add(loginbutton);
		add(loginbox);
	}
	
	function check()
	{
		if (loginbox.text == password)
		{
			trace('[SYSTEM] User logged into Dev Build succesfully');
			FlxG.switchState(new LoadingState());
		}
		else 
		{
			trace('[SYSTEM] User Failed to login into Dev build');
			loginbox.text = 'Wrong password dumbass';
		}
	}
	
	override public function update(elapsed:Float)
	{
		DebugUtils.debug(loginbutton);
		// funny update function
		super.update(elapsed);
	}
}