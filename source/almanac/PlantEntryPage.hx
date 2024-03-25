package almanac;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;

typedef AlmanacJsonPlants = {
    var namePlant:String; //plant display name
    var plantReference:String; //what plant will be loading
    var description:String; //plant display name
	var found:Bool;
    var row:Int;
    var col:Int;
}
typedef PageEntryPlants = {
    var page:Array<AlmanacJsonPlants>;
}

class PlantEntryPage extends FlxState{
    var background:FlxSprite;
    var titleTxt:FlxText;

    var exitButton:FlxButton;
    var exitText:FlxText;
    public static var buttonColor:FlxColor = FlxColor.fromRGB(41,39,97);
    var indexButton:FlxButton;
    var indexText:FlxText;

    var curPlantSelected:String;

    override public function create()
    {
        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/almanac/Almanac_PlantBack.png");
        add(background);

        titleTxt = new FlxText(305,15, 356, 'Suburban Almanac - Plants', 36);
        titleTxt.color = FlxColor.WHITE;
        titleTxt.borderStyle = OUTLINE;
        titleTxt.borderSize = 2;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        titleTxt.screenCenter(X); //i can't see no diference
        add(titleTxt);

        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/almanac/Almanac_PlantBack.png");
        add(background);

        exitButton = new FlxButton(700, FlxG.height - 35, "", exitAlmanac);
		exitButton.loadGraphic('assets/images/menu/almanac/Almanac_CloseButton.png', true, 89, 26);
        add(exitButton);

        exitText = new FlxText(exitButton.x + 10, exitButton.y + 4);
        exitText.text = "CLOSE";
        exitText.font = 'assets/fonts/Brianne_s_hand.ttf';
        exitText.color = buttonColor;
        exitText.size = 16;
        add(exitText);


        indexButton = new FlxButton(10, FlxG.height - 35, "", goToIndex);
		indexButton.loadGraphic('assets/images/menu/almanac/Almanac_IndexButton.png', true, 164, 26);
        add(indexButton);

        indexText = new FlxText(indexButton.x + 30, indexButton.y + 4);
        indexText.text = "ALMANAC INDEX";
        indexText.font = 'assets/fonts/Brianne_s_hand.ttf';
        indexText.color = buttonColor;
        indexText.size = 16;
        add(indexText);
    }

    function exitAlmanac()
        {
            FlxG.sound.play('assets/sounds/buttonclick.ogg'); // button sound
            FlxG.switchState(new MainMenuState());
        }

    function goToIndex()
        {
            FlxG.sound.play('assets/sounds/buttonclick.ogg'); // button sound
            FlxG.switchState(new AlmanacState());
        }
}

class AlmanacEntry extends FlxSpriteGroup
{   
    var backgroundSprite:FlxSprite;
    var plant:Plant;
    var overlay:FlxSprite;
    var plantTitle:FlxText;
    var descriptionTxt:FlxText;
    var costTxt:FlxText;
    var rechargeTxt:FlxText;

    public function new(x:Float, y:Float, character:String, description:String, cost:String, recharge:String, background:String){
        super(x,y);
        backgroundSprite = new FlxSprite(x,y);
        backgroundSprite.loadGraphic("assets/images/menu/almanac/backgrounds/" + background + ".png");
        add(backgroundSprite);

        plant = new Plant(x, y);
        add(plant);

        overlay = new FlxSprite(x,y);
        overlay.loadGraphic("assets/images/menu/almanac/Almanac_PlantCard");
        overlay.alpha = 0.3;
        add(overlay);
    }



}