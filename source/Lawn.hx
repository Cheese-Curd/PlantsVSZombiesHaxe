package;

import flixel.FlxSprite;
import haxe.Json;

typedef LawnData =
{
    var cols:Int;
    var rows:Int;
    var type:String;
}

class Lawn extends FlxSprite{
    public var jsonSystem:LawnData;

    public function new(x:Float = -220, y:Float = 0, backgroundType:String = "grass", colsNum:Int, rowsNum:Int){
        super(x,y);
        this.loadGraphic('assets/images/levels/grassday/grassday.png');
    }

    public function reloadImage(imagePath:String){
        this.loadGraphic(imagePath);
    }


}