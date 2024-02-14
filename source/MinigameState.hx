package;

import haxe.Json;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.text.FlxText;

typedef MinigameJson = {
    var name:String;
    var levelName:String;
	var order:Int;
    var image:String;
	var locked:Bool;
}
typedef Page= {
    var page:Array<MinigameJson>;
}

class MinigameState extends FlxState{
    var background:FlxSprite;
    var titleTxt:FlxText; //minigame text at the top of screen
    //
    var pages:Array<Page>;

    override public function create(){
        super.create();

        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/minigames/Challenge_Background.png");
        add(background);

        titleTxt = new FlxText(305, 117, 216, 'Minigames', 36);
        titleTxt.color = FlxColor.BLACK;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        add(titleTxt);

    }



}