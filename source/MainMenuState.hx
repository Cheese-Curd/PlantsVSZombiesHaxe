package;

import AngelUtils; // for masking lol
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

#if windows
import discord_rpc.DiscordRpc;
#end

class MainMenuState extends FlxState
{
	// background stuff \\
	var selectMenu:FlxSprite;
	var sky:FlxSprite;
	var background:FlxSprite;

	override public function create()
	{
		background = new FlxSprite();
		background.makeGraphic(800, 600, FlxColor.WHITE);
		super.create();
		#if windows
		// Updating Discord Rich Presence
		DiscordRpc.presence({
			details: 'PvZ:Haxe Edition Version [PRIVATE BETA 1]',
			state: 'In the Main Menu.',
			largeImageKey: 'logo_haxe',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});
		#end

		// Plays the Main Menu Theme (Dave Intro) \\
		// FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');
		// Background Shit \\
		sky = new FlxSprite();
		sky.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_BG.jpg');
		add(background);
		// Stupid masking because the actual images are jpegs and not pngs >:c \\

		selectMenu = AngelUtils.fromAlphaMask('assets/images/menu/mainmenu/SelectorScreen_BG_Center.jpg',
			'assets/images/menu/mainmenu/SelectorScreen_BG_Center_.png'); // haxe what the fuck is wrong with you

		add(sky);
		add(selectMenu); // thank you Angel for helping me to get the masks to work, and for the Utils <3
		selectMenu.y = 40;
		selectMenu.x = 70;
		sky.scale.set(FlxG.width);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// Debug \\
		if (FlxG.keys.justReleased.ENTER)
		{
			trace('Y: ' + selectMenu.y);
			trace('X: ' + selectMenu.x);
		}
		// y \\
		if (FlxG.keys.justReleased.UP)
		{
			selectMenu.y++;
		}
		if (FlxG.keys.justReleased.DOWN)
		{
			selectMenu.y--;
		}
		// x \\
		if (FlxG.keys.justReleased.RIGHT)
		{
			selectMenu.x++;
		}
		if (FlxG.keys.justReleased.LEFT)
		{
			selectMenu.x--;
		}
	}
}
