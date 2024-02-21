package;

import AngelUtils; // for masking lol
import discord_rpc.DiscordRpc;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import DebugUtils;

class LoadingState extends FlxState
{
	var loadingtxt:FlxText;
	var popcap_logo:FlxSprite;
	var popcap:FlxText;
	var eliana:FlxText;
	var eGunner:FlxText;
	var haxe_edition:FlxText;
	// PvZ Logo \\
	var pvz_logo:FlxSprite;
	// Loading Bar \\
	var bar_dirt:FlxSprite;
	var bar_grass:FlxSprite;
	var grass_ball:FlxSprite;
	var continueBttn:FlxButton;
	// fade shit \\
	var black:FlxSprite;

	override public function create()
	{
		super.create();
		DiscordRpc.start({
			clientID: "884169727415566417",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		DiscordRpc.presence({
			details: 'Version: [PRIVATE BETA 2]',
			state: 'Loading...',
			largeImageKey: 'discord_rpc_512',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});
		// Plays the Main Menu Theme (Dave Intro) \\
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');
		FlxAssets.FONT_DEFAULT = 'assets/fonts/Brianne_s_hand.ttf';
		popcap = new FlxText(260, 38, 339, 'Plants VS Zombies made by:', 24);
		popcap.alpha = 0;

		// Haxe Edition Creator
		eliana = new FlxText(237, 377, 433, 'Haxe Edition made by: Eliana', 24);
		eliana.alpha = 0;
		// Haxe Engine Creator (Thanks for continuing this :D)
		eGunner = new FlxText(237, 425, 433, 'Haxe Engine made by: Electr0Gunner', 24);
		eGunner.alpha = 0;

		popcap_logo = new FlxSprite(250, 65).loadGraphic('assets/images/menu/loading/PopCap_Logo.jpg');
		popcap_logo.alpha = 0;

		add(popcap);
		add(eliana);
		add(eGunner);
		add(popcap_logo);
		// Antialiasing \\
		popcap_logo.antialiasing = true;
		popcap.antialiasing = true;
		eliana.antialiasing = true;
		eGunner.antialiasing = true;
		fadeAnimation();
	}

	function fadeAnimation()
	{
		FlxTween.tween(popcap_logo, {alpha: 1}, 2, {ease: FlxEase.expoInOut});
		FlxTween.tween(popcap, {alpha: 1}, 2, {ease: FlxEase.expoInOut});

		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			FlxTween.tween(eliana, {alpha: 1}, 2, {ease: FlxEase.expoInOut});
			FlxTween.tween(eGunner, {alpha: 1}, 2.3, {ease: FlxEase.expoInOut});
		});

		new FlxTimer().start(2, function(tmr:FlxTimer) // 4 secs kinda long for this
		{
			textPlay();
		});
	};

	function textPlay()
	{
		new FlxTimer().start(4.0, function(tmr:FlxTimer)
		{
			trace('Should have switched to main loading');
			mainLoading();
		});
	};

	function mainLoading()
	{
		FlxTween.tween(popcap_logo, {alpha: 0}, 2, {ease: FlxEase.expoInOut});
		FlxTween.tween(popcap, {alpha: 0}, 2, {ease: FlxEase.expoInOut});
		FlxTween.tween(eliana, {alpha: 0}, 2, {ease: FlxEase.expoInOut});
		new FlxTimer().start(0.3, function(tmr:FlxTimer) { FlxTween.tween(eGunner, {alpha: 0}, 1.7, {ease: FlxEase.expoInOut}); });

		new FlxTimer().start(2, function(tmr)
		{
			// remove everything not needed \\
			remove(popcap);
			remove(popcap_logo);
			remove(eliana);
			remove(eGunner);
			// Loading Text Properties \\
			loadingtxt = new FlxText(347, 544, 0, "Loading...", 24);
			loadingtxt.color = FlxColor.fromRGB(217, 183, 32); // no more white loadingtxt
			// Contiue Button Properties \\
			continueBttn = new FlxButton(319, 553, "", continuefunc);
	
			// Load the start button image \\
			continueBttn.loadGraphic('assets/images/menu/loading/strtbttn.png', true, 165, 12);
			// add background \\
			var background:FlxSprite;
			background = new FlxSprite().loadGraphic('assets/images/menu/loading/titlescreen.jpg');
			// PvZ Logo \\
			pvz_logo = AngelUtils.fromAlphaMask('assets/images/menu/loading/PvZ_Logo.jpg', 'assets/images/menu/loading/PvZ_Logo_.png', 51, 10);
			add(background);
			add(pvz_logo);
			// Haxe Edition Text \\
			haxe_edition = new FlxText(305, 117, 216, 'Haxe Edition', 36);
			haxe_edition.color = FlxColor.BLACK;
			haxe_edition.font = 'assets/fonts/HouseofTerror-Regular.ttf';
			add(haxe_edition);
			// Loading Bar \\
	
			bar_dirt = new FlxSprite(244, 535).loadGraphic('assets/images/menu/loading/LoadBar_dirt.png');
			bar_grass = new FlxSprite(243, 520).loadGraphic('assets/images/menu/loading/LoadBar_grass.png');
			grass_ball = new FlxSprite(231, 484).loadGraphic('assets/images/menu/loading/SodRollCap.png');
			add(bar_dirt);
			add(bar_grass);
			add(grass_ball);
			add(loadingtxt);
			// Antialiasing \\
			loadingtxt.antialiasing = true;
			haxe_edition.antialiasing = true;
			bar_dirt.antialiasing = true;
			bar_grass.antialiasing = true;
			grass_ball.antialiasing = true;
			pvz_logo.antialiasing = true;
			// Moving the grass thing \\
			/* [INSERT GRASS MASKING CODE HERE] */
			FlxTween.tween(grass_ball, {angle: 360.0}, 5, {type: FlxTweenType.LOOPING}); // speeeen
			FlxTween.tween(grass_ball, {x: 508, y: 500}, 10, {type: FlxTweenType.ONESHOT}); // yo, he movin'
			FlxTween.tween(grass_ball.scale, {x: 0.4, y: 0.4}, 10, {type: FlxTweenType.ONESHOT}); // oh god he is shrinking oh god
			new FlxTimer().start(10, function(tmr:FlxTimer)
			{
				remove(loadingtxt);
				remove(grass_ball);
				add(continueBttn);
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
			});

			// fade shit \\
			black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			add(black);
			FlxTween.tween(black, {alpha: 0}, 2, {onComplete: function(tween) remove(black)});
		});
	}

	function continuefunc()
	{
		FlxG.switchState(new MainMenuState());
	}

	override public function update(elapsed:Float)
	{
		DebugUtils.debug(loadingtxt);
		super.update(elapsed);
		// keep it running when it's a live and kill it when it's not?????? \\
		DiscordRpc.process();
		if (false)
		{
			DiscordRpc.shutdown();
		};
		if (FlxG.keys.justReleased.R)
		{
			FlxG.switchState(new LoadingState());
		}
	}

	// Audio Pausing \\
	override public function onFocusLost()
	{
		super.onFocusLost();
		FlxG.sound.music.pause();
		trace("User Lost Focus the window");
	}

	override public function onFocus()
	{
		super.onFocus();
		FlxG.sound.music.resume();
		trace("User Focused the window");
	}

	// I just stole the fuckin' code from the github lol \\
	static function onReady()
	{
		// Updating Discord Rich Presence
		DiscordRpc.presence({
			details: 'Version: [PRIVATE BETA 2]',
			state: 'Loading...',
			largeImageKey: 'discord_rpc_512',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}
}