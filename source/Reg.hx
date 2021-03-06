package;

import flixel.util.FlxSave;
import flixel.math.FlxRandom;
import flixel.FlxSprite;
import flixel.system.FlxSound;

class Reg {
  public static var pointService:PointService;
  public static var random:FlxRandom;
  public static var score:Int;
  public static var canvas:Canvas;

  public static var stamp:FlxSprite;
  public static var background:FlxSprite;

  public static var continuous:Bool = true;

  public static var stampSound:FlxSound;
}
