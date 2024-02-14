package;

import flixel.FlxSprite;
import haxe.Json;

typedef LawnData =
{
    var cols:Int;
    var rows:Int;
    var type:String;
}

enum TileType {
    PLANTABLE;
    UNPLANTABLE;
}

class Lawn extends FlxSprite{
    public var jsonSystem:LawnData;

    public var colsNumber:Int;
    public var rowsNumber:Int;

    public function new(x:Float = -220, y:Float = 0, backgroundType:String = "grass", colsNum:Int = 5, rowsNum:Int = 9){
        super(x,y);

        colsNumber = colsNum;
        rowsNumber = rowsNum;

        this.loadGraphic('assets/images/levels/grassday/grassday.png');
    }

    public function reloadImage(imagePath:String){
        this.loadGraphic(imagePath);
    }


}