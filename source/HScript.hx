package;

#if sys
import hscript.Expr.Error;
import openfl.Assets;
import hscript.*;
#end

using StringTools;
    //504brandon's hscript implementation for fnf H-engine kinda ported to this
class HScript
{
	#if sys
	public static final allowedExtensions:Array<String> = ["hx", "hscript", "hxs", "script"];
	public static var parser:Parser;
	public static var staticVars:Map<String, Dynamic> = new Map();

	public var interp:Interp;
	public var expr:Expr;

	var initialLine:Int = 0;
	#end

	public var isBlank:Bool;

	var blankVars:Map<String, Null<Dynamic>>;
	public var path:String;

	private var flxSoundtxt:String = #if (flixel >= "5.3.0") "flixel.sound.FlxSound" #else "flixel.system.FlxSound" #end;

    #if sys
    public function new(scriptPath:String)
        {
            path = scriptPath;
            if (!scriptPath.startsWith("assets/"))
                scriptPath = "assets/" + scriptPath;
            var boolArray:Array<Bool> = [for (ext in allowedExtensions) Assets.exists('$scriptPath.$ext')];
            trace(scriptPath);
            isBlank = (!boolArray.contains(true));
            if (boolArray.contains(true))
            {
                interp = new Interp();
                interp.staticVariables = staticVars;
                interp.allowStaticVariables = true;
                interp.allowPublicVariables = true;
                interp.errorHandler = traceError;
                try
                {
                    var path = scriptPath + "." + allowedExtensions[boolArray.indexOf(true)];
                    parser.line = 1; // Reset the parser position.
                    expr = parser.parseString(Assets.getText(path));
                    interp.variables.set("trace", hscriptTrace);
                }
                catch (e)
                {
                    lime.app.Application.current.window.alert('Looks like the game couldn\'t parse your hscript file.\n$scriptPath\n${e.toString()}\n\nThe game will replace this\nscript with a blank script.',
                        'Failed to Parse $scriptPath');
                    isBlank = true;
                }
            }
            if (isBlank)
            {
                blankVars = new Map();
            }
            else
            {
                var defaultVars:Map<String, Dynamic> = [
                    "Http" => haxe.Http,
                    "Math" => Math,
                    "Std" => Std,
                    "FlxG" => flixel.FlxG,
                    "FlxSprite" => flixel.FlxSprite,
                    "FlxText" => flixel.text.FlxText,
                    "FlxTween" => flixel.tweens.FlxTween,
                    "FlxTrail" => flixel.addons.effects.FlxTrail,
                    "FlxSound" => flxSoundtxt,
                    "FlxBackdrop" => flixel.addons.display.FlxBackdrop,
                    "FlxTypedGroup" => flixel.group.FlxGroup.FlxTypedGroup,
                    "FlxBaseAnimation" => flixel.animation.FlxBaseAnimation,
                    "FlxAtlasFrames" => flixel.graphics.frames.FlxAtlasFrames,
                    "Json" => haxe.Json,
                    "Assets" => openfl.Assets,
                    "Paths" => Paths,
                    "Files" => Paths,
                    "PlayState" => PlayState,
                    "Lawn" => Lawn,
                    "Plant" => Plant,
                    "Zombie" => Zombie,
                    "Projectile" => Projectile,
                    "SeedPacket" => SeedPacket,
                ];
                for (va in defaultVars.keys())
                    setValue(va, defaultVars[va]);
            }
        }

        function hscriptTrace(v:Dynamic)
            trace(v);
    
        function traceError(e:Error)
        {
            var errorString:String = e.toString();
            trace(path + errorString.substr(7, errorString.length));
        }
    
        public function callFunction(name:String, ?params:Array<Dynamic>)
        {
            if (interp == null || parser == null)
                return null;
    
            var functionVar = (isBlank) ? blankVars.get(name) : interp.variables.get(name);
            var hasParams = (params != null && params.length > 0);
            if (functionVar == null || !Reflect.isFunction(functionVar))
                return null;
            return hasParams ? Reflect.callMethod(null, functionVar, params) : functionVar();
        }
    
        inline public function getValue(name:String)
            return (isBlank) ? blankVars.get(name) : (interp != null) ? interp.variables.get(name) : null;
    
        inline public function setValue(name:String, value:Dynamic)
            (isBlank) ? blankVars.set(name, value) : (interp != null) ? interp.variables.set(name, value) : null;
        #else
        public var interp:Null<Dynamic> = null;
        public var expr:Null<Dynamic> = null;
    
        public function new(scriptPath:String)
        {
            blankVars = new Map();
            isBlank = true;
        }
    
        inline public function getValue(name:String)
            return blankVars.get(name);
    
        public function setValue(name:String, value:Dynamic)
            blankVars.set(name, value);
        #end
    }
    