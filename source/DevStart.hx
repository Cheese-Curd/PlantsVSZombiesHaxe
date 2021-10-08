package;

import AngelUtils; // for masking and reading json lol
import DataShit; // getting data
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.ui.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

using flixel.util.FlxSpriteUtil;

#if windows
import discord_rpc.DiscordRpc;
#end

class MainMenuState extends FlxState
{
	var logintext:FlxText;
	var loginbutton:FlxButton;
	var loginbox:FlxTextBox; // no fucking idea if this is the actuall thing for a text box, probably not, but can't check ;)
	var password = 'hehedev'
	logintext = new FlxText(0,0 'PRIVATE DEV BUILD 2 LOGIN');
	loginbutton = new FlxButton(0,-200, 'LOGIN')
	loginbox = new FlxTextBox(0,-100, 'Insert password dumbass')
	
	override public function create()
	{
		add(logintext)
		add(loginbutton)
		add(loginbox)
	}
	
	function check()
	{
		if (loginbox.text == password) 
		{
			trace('[SYSTEM] User logged into Dev Build succesfully');
			FlxG.switchState(new MainMenuState());
		}
		else 
		{
			trace('[SYSTEM] User Failed to login into Dev build');
			loginbox.text = 'Wrong password dumbass'
		}
	}
	
	override public function update(elapsed:Float)
	{
		// funny update function
		super.update(elapsed);
	}
}