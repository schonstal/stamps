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
  var background:Background;
  var hud:HUD;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();
    Reg.score = 0;

    background = new Background();
    hud = new HUD();

    add(background);
    add(pointGroup);
    add(hud);
  }

  private function registerServices():Void {
    pointGroup = new FlxSpriteGroup();
    Reg.pointService = new PointService(pointGroup);
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

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
