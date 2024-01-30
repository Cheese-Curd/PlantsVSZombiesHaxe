package;

import flixel.util.FlxTimer;
import flixel.system.FlxAssets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import AngelUtils; // for masking and reading json lol
import flixel.FlxState;
import DebugUtils;

using flixel.util.FlxSpriteUtil;

#if windows
import discord_rpc.DiscordRpc;
#end

class HelpState extends FlxState
{
	var bg:FlxSprite;
	var paper:FlxSprite;
	var text:FlxSprite;
	var fade:FlxSprite;
	var button:FlxButton;

	override public function create()
	{
		super.create();
		FlxAssets.FONT_DEFAULT = 'assets/fonts/DWARVESC.ttf';
		DiscordRpc.start({
			clientID: "884169727415566417",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		DiscordRpc.presence({
			details: 'Version: [PRIVATE BETA 2]',
			state: 'Reading Help.',
			largeImageKey: 'discord_rpc_512',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});

		button = new FlxButton(325, 521, '', goBack);
		button.loadGraphic('assets/images/notes/help_Button.png', true, 156, 42);
		bg = new FlxSprite().loadGraphic('assets/images/levels/grassday/grassday.png');
		paper = AngelUtils.fromAlphaMask('assets/images/notes/ZombieNote.jpg', 'assets/images/notes/ZombieNote_.png', 80, 79.5);
		text = new FlxSprite(130.5, 131.5).loadGraphic('assets/images/notes/text/ZombieNoteHelp.png');
		fade = new FlxSprite().loadGraphic('assets/images/notes/text/ZombieNoteHelpBlack.png');

		FlxG.sound.play('assets/sounds/paper.ogg');

		add(bg);
		add(paper);
		add(text);
		add(button);
		bg.screenCenter();
		add(fade);
		fade.width = FlxG.width;
		fade.height = FlxG.height;
		fade.screenCenter();
		fade.setGraphicSize(3000); // just want to fill the screen tbh
		bg.setGraphicSize(3000);
		fadeAnimation();
	}

	function fadeAnimation()
	{
		fade.alpha = 1;
		FlxTween.tween(fade, {alpha: 0}, 0.5, {ease: FlxEase.expoInOut});
	};

	function goBack()
	{
		trace("go back! I want to be MONKE!"); // I wrote this at school, end me
		FlxG.sound.play('assets/sounds/tap.ogg'); // button sound
		new FlxTimer().start(0.2, (tmr:FlxTimer) ->
		{
			FlxG.switchState(new MainMenuState());
		});
	};

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		DebugUtils.debug(text);
	}

	// I just stole the fuckin' code from the github lol \\
	static function onReady()
	{
		// Updating Discord Rich Presence
		DiscordRpc.presence({
			details: 'Version: [PRIVATE BETA 2]',
			state: 'Reading help.',
			largeImageKey: 'discord_rpc_512',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('[DISCORD RPC] Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('[DISCORD RPC] Disconnected! $_code : $_message');
	}
}
