package;

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
	var selectMenu_normal:FlxSprite;
	var selectMenu_mask:FlxSprite;
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
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');
		// Background Shit \\
		sky = new FlxSprite();
		sky.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_BG.jpg');
		add(background);
		// Stupid masking because the actual images are jpegs and not pngs >:c \\

		selectMenu = new FlxSprite();
		selectMenu_normal = new FlxSprite();
		selectMenu_mask = new FlxSprite();
		selectMenu_normal.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_BG_Right.jpg');
		selectMenu_mask.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_BG_Right_.png');
		FlxSpriteUtil.alphaMaskFlxSprite(selectMenu_normal, selectMenu_mask, selectMenu);

		add(sky);
		add(selectMenu);
		selectMenu.y = 40;
		selectMenu.x = 70;
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
