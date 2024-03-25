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
import flixel.ui.FlxButton;
import sys.io.File;
import sys.FileSystem;

using StringTools;

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
    var exitButton:FlxButton;
    var exitText:FlxText;
    var pageLeftButton:FlxButton;
    var pageLeftText:FlxText;
    var pageRightButton:FlxButton;
    var pageRightText:FlxText;
    var windowGroup:FlxTypedGroup<ChallengeWindow>;
    var curPage:Int = 0;
    var pageCount:Int = 0;
    public static var buttonColor:FlxColor = FlxColor.fromRGB(41,39,97);

    public var minigameJson:Page;

    override public function create(){
        super.create();

        for (file in sys.FileSystem.readDirectory("assets/data/minigames")){
            if(file.endsWith('.json'))
                pageCount++;
        }
        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/minigames/Challenge_Background.png");
        add(background);

        titleTxt = new FlxText(305, 20, 216, 'Minigames', 36);
        titleTxt.color = FlxColor.WHITE;
        titleTxt.borderStyle = OUTLINE;
        titleTxt.borderSize = 2;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        titleTxt.screenCenter(X); //i can't see no diference
        add(titleTxt);

        windowGroup = new FlxTypedGroup<ChallengeWindow>();
        add(windowGroup);

        exitButton = new FlxButton(10, FlxG.height - 35, "", exitMinigames);
		exitButton.loadGraphic('assets/images/ui/SeedChooser_Button2.png', true, 111, 26);
        add(exitButton);

        exitText = new FlxText(exitButton.x + 15, exitButton.y + 5);
        exitText.text = "Back to Menu";
        exitText.color = buttonColor;
        exitText.size = 14;
        add(exitText);

        pageLeftButton = new FlxButton(140, FlxG.height - 35, "", movePageLeft);
		pageLeftButton.loadGraphic('assets/images/ui/SeedChooser_Button2.png', true, 111, 26);
        add(pageLeftButton);

        pageLeftText = new FlxText(pageLeftButton.x + 15, pageLeftButton.y + 5);
        pageLeftText.text = 'Page ${curPage - 1}';
        pageLeftText.color = buttonColor;
        pageLeftText.size = 14;
        add(pageLeftText);



        pageRightButton = new FlxButton(600, FlxG.height - 35, "", movePageRight);
		pageRightButton.loadGraphic('assets/images/ui/SeedChooser_Button2.png', true, 111, 26);
        add(pageRightButton);

        pageRightText = new FlxText(pageRightButton.x + 15, pageRightButton.y + 5);
        pageRightText.text = 'Page ${curPage + 1}';
        pageRightText.color = buttonColor;
        pageRightText.size = 14;
        add(pageRightText);
        


        changePage(0);
    }

    function exitMinigames()
        {
            FlxG.sound.play('assets/sounds/buttonclick.ogg'); // button sound
            FlxG.switchState(new MainMenuState());
        }

    private function changePage(pageInt:Int = 0){
        minigameJson = AngelUtils.JsonifyFile('assets/data/minigames/page${curPage}.json');
        windowGroup.clear();

        for (pageData in minigameJson.page){
            var minigameWindow:ChallengeWindow = new ChallengeWindow(70 * pageData.col + 10, pageData.row * 60 + 50, pageData.name, pageData.levelName, pageData.locked, pageData.textOffsetX,pageData.textOffsetY);
            windowGroup.add(minigameWindow);
        }

    }
    private function movePageLeft():Void
        {
            curPage -= 1;
            changePage(curPage - 1);
        }
    private function movePageRight():Void
        {
            curPage++;
            changePage(curPage + 1);
        }

    override public function update(elapsed:Float)
    {
        pageLeftText.text = 'Page ${curPage - 1}';
        pageRightText.text = 'Page ${curPage + 1}';
        if (curPage == 0){
            pageLeftButton.active = false;
            pageLeftText.active = false;
            pageLeftButton.alpha = 0;
            pageLeftText.alpha = 0;
        }
        else
        {
            pageLeftButton.active = true;
            pageLeftText.active = true;
            pageLeftButton.alpha = 1;
            pageLeftText.alpha = 1;
        }


        if (curPage == pageCount - 1){
            pageRightButton.active = false;
            pageRightText.active = false;
            pageRightButton.alpha = 0;
            pageRightText.alpha = 0;
        }
        else
        {
            pageRightButton.active = true;
            pageRightText.active = true;
            pageRightButton.alpha = 1;
            pageRightText.alpha = 1;
        }
        super.update(elapsed);
    }
}

class ChallengeWindow extends FlxSpriteGroup{
	public var window:FlxSprite;
    public var portrait:FlxSprite;
    public var minigameName:FlxText;
    public var lockSprite:FlxSprite;
    public var whatMinigame:String = "Zombatony";
    public var minigameDisplay:String = "Zombatony";
    public var lockedGame:Bool;

    override public function new(x:Float,y:Float, minigame:String, goToLevel:String, isLocked:Bool, textOffsetX:Float, textOffsetY:Float){
        super(x,y);
        whatMinigame = goToLevel;
        minigameDisplay = minigame;
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
        minigameName.color = MinigameState.buttonColor;
        minigameName.font = "assets/fonts/Brianne_s_hand.ttf";
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
                minigameName.color = MinigameState.buttonColor;
            }
            if (FlxG.mouse.pressed && FlxG.mouse.overlaps(this))
                {
                    LawnState.curLevel = whatMinigame;
                    LawnState.displayLevel = minigameDisplay;
                    trace('going to ${whatMinigame}');
                    FlxG.switchState(new LawnState());
                }
        }
        super.update(elapsed);
    }

}