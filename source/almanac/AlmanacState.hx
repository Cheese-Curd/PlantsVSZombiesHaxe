package almanac;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class AlmanacState extends FlxState{
    var background:FlxSprite;
    var titleTxt:FlxText;

    var exitButton:FlxButton;
    var exitText:FlxText;
    public static var buttonColor:FlxColor = FlxColor.fromRGB(41,39,97);

    var plantButton:FlxButton;

    override public function create()
    {
        background = new FlxSprite(0,0).loadGraphic("assets/images/menu/almanac/Almanac_IndexBack.png");
        add(background);

        titleTxt = new FlxText(305, 20, 356, 'Suburban Almanac - Index', 36);
        titleTxt.color = FlxColor.WHITE;
        titleTxt.borderStyle = OUTLINE;
        titleTxt.borderSize = 2;
        titleTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
        titleTxt.screenCenter(X); //i can't see no diference
        add(titleTxt);

        exitButton = new FlxButton(700, FlxG.height - 35, "", exitAlmanac);
		exitButton.loadGraphic('assets/images/menu/almanac/Almanac_CloseButton.png', true, 89, 26);
        add(exitButton);

        exitText = new FlxText(exitButton.x + 10, exitButton.y + 4);
        exitText.text = "CLOSE";
        exitText.color = buttonColor;
        exitText.size = 16;
        add(exitText);

        plantButton = new FlxButton(130, FlxG.height - 245, "", exitAlmanac);
		plantButton.loadGraphic('assets/images/menu/almanac/viewplant.png', true, 156, 42);
        add(plantButton);

    }

    function exitAlmanac()
        {
            FlxG.sound.play('assets/sounds/buttonclick.ogg'); // button sound
            FlxG.switchState(new PlantEntryPage());
        }

}