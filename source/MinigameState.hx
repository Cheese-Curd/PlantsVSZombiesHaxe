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
	var locked:Bool;
    var row:Int;
    var col:Int;
    var textOffsetX:Float;
    var textOffsetY:Float;
}
typedef Page = {
    var page:Array<MinigameJson>;
}

class MinigameState extends FlxState{
    var background:FlxSprite;
    var titleTxt:FlxText; //minigame text at the top of screen
    //
    var windowGroup:FlxTypedGroup<ChallengeWindow>;
    var curPage:Int = 0;

    public var minigameJson:Page;

    override public function create(){
        super.create();

        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/minigames/Challenge_Background.png");
        add(background);

        titleTxt = new FlxText(305, 20, 216, 'Minigames', 36);
        titleTxt.color = FlxColor.WHITE;
        titleTxt.borderStyle = OUTLINE;
        titleTxt.borderSize = 1.7;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        add(titleTxt);

        windowGroup = new FlxTypedGroup<ChallengeWindow>();
        add(windowGroup);

        changePage(0);
    }

    private function changePage(pageInt:Int = 0){
        minigameJson = AngelUtils.JsonifyFile('assets/data/minigames/page${curPage}.json');

        for (pageData in minigameJson.page){
            var minigameWindow:ChallengeWindow = new ChallengeWindow(70 * pageData.col + 10, pageData.row * 60 + 40, pageData.name, pageData.levelName, pageData.locked, pageData.textOffsetX,pageData.textOffsetY);
            windowGroup.add(minigameWindow);
        }

    }

}

class ChallengeWindow extends FlxSpriteGroup{
	public var window:FlxSprite;
    public var portrait:FlxSprite;
    public var minigameName:FlxText;
    public var lockSprite:FlxSprite;
    public var whatMinigame:String = "Zombatony";
    public var lockedGame:Bool;

    override public function new(x:Float,y:Float, minigame:String, goToLevel:String, isLocked:Bool, textOffsetX:Float, textOffsetY:Float){
        super(x,y);
        whatMinigame = goToLevel;
        lockedGame = isLocked;
        window = new FlxSprite(x,y).loadGraphic("assets/images/menu/minigames/Challenge_Window.png");

        portrait = new FlxSprite(window.x + 20, window.y + 8).loadGraphic('assets/images/menu/minigames/portraits/${goToLevel}.png');
		add(portrait);


		add(window);

        lockSprite = new FlxSprite(x + 20,y).loadGraphic("assets/images/menu/minigames/lock.png");
        lockSprite.scale.set(0.7,0.7);
        if (isLocked)
		    add(lockSprite);

        minigameName = new FlxText(x + 15 + textOffsetX,y + 80 + textOffsetY);
        minigameName.text = minigame;
        minigameName.size = 17;
        minigameName.color = FlxColor.BLUE;
        //minigameName.fieldWidth = 20;
        minigameName.alignment = CENTER;
        if (isLocked){
            minigameName.text = "?";
            minigameName.x -= textOffsetX;
            minigameName.y -= textOffsetY;
            minigameName.x += 40;
        }
        add(minigameName);
    }
    override public function update(elapsed:Float)
    {
        if (!lockedGame){
            if(FlxG.mouse.overlaps(this)){
                window.loadGraphic("assets/images/menu/minigames/Challenge_Window_Highlight.png");
                minigameName.color = FlxColor.RED;
            }
            else{
                window.loadGraphic("assets/images/menu/minigames/Challenge_Window.png");
                minigameName.color = FlxColor.BLUE;
            }
            if (FlxG.mouse.pressed)
                {
                    //LawnState.curLevel = whatMinigame;
                    trace('going to ${whatMinigame}');
                }
        }
        super.update(elapsed);
    }

}