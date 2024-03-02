package;

import flixel.FlxSprite;
import haxe.Json;
import flixel.FlxState;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIDropDownMenu;

class LevelConfigState extends FlxState
{
    var background:FlxSprite;
    var titleTxt:FlxText;

    public function new()
    {
        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/minigames/Challenge_Background.png");
        add(background);

        titleTxt = new FlxText(305, 20, 216, 'Level Config', 36);
        titleTxt.color = FlxColor.WHITE;
        titleTxt.borderStyle = OUTLINE;
        titleTxt.borderSize = 2;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        titleTxt.screenCenter(X); //i can't see no diference
        add(titleTxt);






    }

}