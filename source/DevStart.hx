package;

import flixel.util.FlxTimer;
import flixel.addons.ui.FlxUIInputText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
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
	var defaultlogintext = 'login';
	var password = 'hehedev';
	
	override public function create()
	{
		logintext = new FlxText(0,0, defaultlogintext);
		loginbutton = new FlxButton(27,36, 'LOGIN', check);
		loginbox = new FlxUIInputText(15,16, 100);
		loginbox.passwordMode = true;
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
			// loginbox.text = 'Wrong password dumbass';
			logintext.text = 'WRONG PASSWORD DUMBASS';
			logintext.color = 0xFFFF0000;
			new FlxTimer().start(1, function(tmr)
			{
				logintext.text = defaultlogintext;
				logintext.color = 0xFFFFFFFF;
			});
		}
		loginbox.text = '';
	}
	
	override public function update(elapsed:Float)
	{
		DebugUtils.debug(loginbutton);
		// funny update function
		super.update(elapsed);
	}
}