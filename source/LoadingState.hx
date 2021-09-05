package;

import AngelUtils; // for masking lol
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.actions.FlxAction;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

class LoadingState extends FlxState
{
	var popcap_logo:FlxSprite;
	var popcap:FlxText;
	var cheese:FlxText;
	// PvZ Logo \\
	var pvz_logo:FlxSprite;

	override public function create()
	{
		super.create();
		FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');
		FlxAssets.FONT_DEFAULT = 'assets/fonts/Brianne_s_hand.ttf';
		popcap = new FlxText(231, 38, 339, 'Plants VS Zombies made by:', 24);
		cheese = new FlxText(184, 377, 433, 'Haxe Edition made by: Cheese Curd', 24);

		popcap_logo = new FlxSprite(250, 65).loadGraphic('assets/images/menu/loading/PopCap_Logo.jpg');

		add(popcap);
		add(cheese);
		add(popcap_logo);
		fadeAnimation();

		// var fuckingbutton = new FlxButton(0, 0, 'Click me to Start!', function()
		// {
		// 	FlxG.switchState(new MainMenuState());
		// });
		// fuckingbutton.scale.set(1.5);
		// HAXE NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO #2
		// new FlxTimer().start(5, function(tmr:FlxTimer)
		// {
		// 	add(fuckingbutton);
		// });
	}

	function fadeAnimation()
	{
		var alpha = 0.0;
		while (alpha != 1)
		{
			popcap_logo.alpha = alpha;
			popcap.alpha = alpha;
			alpha += 0.1;
		};
		new FlxTimer().start(2.0, function(tmr:FlxTimer)
		{
			textPlay();
		});
	};

	function textPlay()
	{
		var alpha = 0.0;
		while (alpha != 1)
		{
			cheese.alpha = alpha;
			alpha += 0.1;
		};
		new FlxTimer().start(5.0, function(tmr:FlxTimer)
		{
			mainLoading();
		});
	};

	function mainLoading()
	{
		// remove everything not needed \\
		remove(cheese);
		remove(popcap_logo);
		remove(popcap);
		// add background \\
		var background:FlxSprite;
		background = new FlxSprite().loadGraphic('assets/images/menu/loading/titlescreen.jpg');
		// PvZ Logo \\
		pvz_logo = AngelUtils.fromAlphaMask('assets/images/menu/loading/PvZ_Logo.jpg', 'assets/images/menu/loading/PvZ_Logo_.png');
		add(pvz_logo);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	// Audio Pausing
	override public function onFocus()
	{
		super.onFocus();
	}

	override public function onFocusLost()
	{
		super.onFocusLost();
	}
}
