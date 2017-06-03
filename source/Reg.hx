package;

import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;

class Reg {
  public static var playerProjectileService:ProjectileService;
  public static var enemyProjectileService:ProjectileService;
  public static var enemyExplosionService:EnemyExplosionService;
  public static var pointService:PointService;
  public static var spawnService:SpawnService;

  public static var random:FlxRandom;

  public static var started:Bool = false;
  public static var difficulty:Float = 1;
  public static var player:Player;
  public static var score:Int;
  public static var combo:Int;

  public static var TAU:Float = 6.28318530718;
}
