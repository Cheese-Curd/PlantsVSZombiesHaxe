package;

import haxe.Json;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import openfl.Assets;

typedef MinigameJson = {
    var name:String;
    var levelName:String;
	var order:Int;
    var image:String;
	var locked:Bool;
}
typedef Page = {
    var page:Array<MinigameJson>;
}

class MinigameState extends FlxState{
    var background:FlxSprite;
    var titleTxt:FlxText; //minigame text at the top of screen
    //
    var pages:Array<Page>;
    var windowGroup:FlxTypedGroup<ChallengeWindow>;
    var curPage:Int = 0;

    public var jsonSystem:Page;

    override public function create(){
        super.create();



        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/minigames/Challenge_Background.png");
        add(background);

        titleTxt = new FlxText(305, 117, 216, 'Minigames', 36);
        titleTxt.color = FlxColor.BLACK;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        add(titleTxt);

        windowGroup = new FlxTypedGroup<ChallengeWindow>();
        add(windowGroup);

        changePage(0);
    }

    private function changePage(pageInt:Int = 0){
        jsonSystem = Json.parse(Assets.getText(Paths.json('page${pageInt}', 'data/minigames')));

        for (pageData in jsonSystem.page){
            var minigameWindow:ChallengeWindow = new ChallengeWindow(20 * pageInt,0, "zombotany");
            windowGroup.add(minigameWindow);
        }

    }


}

class ChallengeWindow extends FlxSpriteGroup{
	public var window:FlxSprite;
    public var portrait:FlxSprite;

    override public function new(x:Float,y:Float, minigame:String){
        super(x,y);
        portrait = new FlxSprite().loadGraphic('assets/images/menu/minigames/portraits/${minigame}.png');
		add(portrait);

        window = new FlxSprite().loadGraphic("assets/images/menu/minigames/Challenge_Window.png");
		add(window);
        
    }

}