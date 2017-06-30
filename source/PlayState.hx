package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState {
  var pointGroup:FlxSpriteGroup;
  var hud:HUD;
  var canvas:Canvas;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();
    Reg.score = 0;

    registerServices();

    Reg.stamp = new FlxSprite();
    Reg.stamp.makeGraphic(8, 8, 0);
    Reg.stamp.setFacingFlip(FlxObject.LEFT, true, false);
    Reg.stamp.setFacingFlip(FlxObject.RIGHT, false, false);

    Reg.background = new FlxSprite();
    Reg.background.loadGraphic("assets/images/backgrounds/notebook.png");
    canvas = new Canvas();
    Reg.canvas = canvas;
    hud = new HUD();

    add(Reg.background);
    add(canvas);
    add(Reg.stamp);
    // add(pointGroup);
    add(hud);

    FlxG.mouse.load("assets/images/ui/pointer.png");

    FlxG.sound.playMusic("assets/music/music.ogg", 0.8);
  }

  private function registerServices():Void {
    pointGroup = new FlxSpriteGroup();
    Reg.pointService = new PointService(pointGroup);
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    Reg.stamp.x = FlxG.mouse.x - Reg.stamp.width / 2;
    Reg.stamp.y = FlxG.mouse.y - Reg.stamp.height / 2;

    super.update(elapsed);

    if (FlxG.mouse.justReleased) {
      var points:Int = Reg.random.int(2, 10) * 50;
      Reg.score += points;
      Reg.pointService.showPoints(Reg.stamp.x, Reg.stamp.y, points, 0xffaa22cc);
    }

    if (FlxG.keys.justPressed.SPACE) {
      Reg.stamp.facing = (Reg.stamp.facing == FlxObject.LEFT ? FlxObject.RIGHT : FlxObject.LEFT);
      FlxG.sound.play("assets/sounds/select.ogg");
    }

    recordHighScores();
  }

  private function recordHighScores():Void {
    if (FlxG.save.data.highScore == null) {
      FlxG.save.data.highScore = 0;
    }
    if (Reg.score > FlxG.save.data.highScore) {
      FlxG.save.data.highScore = Reg.score;
    }
  }
}
