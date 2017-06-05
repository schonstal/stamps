package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class HUD extends FlxSpriteGroup {
  var scoreText:FlxBitmapText;
  var toolbar:FlxSprite;
  var thumbnailGroup:FlxSpriteGroup;

  var mode:String = "background";
  var index:Int = 0;

  public function new():Void {
    super();
    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    toolbar = new FlxSprite();
    toolbar.y = FlxG.height - 74;
    toolbar.loadGraphic("assets/images/ui/toolbars.png", true, 640, 74);
    toolbar.animation.add("wiggle", [0, 1, 2], 8, true);
    toolbar.animation.play("wiggle");
    add(toolbar);

    toolbar = new FlxSprite();
    toolbar.angle = 180;
    toolbar.y = -40;
    toolbar.loadGraphic("assets/images/ui/toolbars.png", true, 640, 74);
    toolbar.animation.add("wiggle", [2, 1, 0], 8, true);
    toolbar.animation.play("wiggle");
    add(toolbar);

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "0";
    scoreText.x = 4;
    scoreText.y = 4;
    // add(scoreText);

    thumbnailGroup = new FlxSpriteGroup();

    var backgroundThumbnails:Array<String> = PathHelper.imagesForPath(~/images\/backgrounds\/thumbs/);
    var i = 0;
    for (thumbnailPath in backgroundThumbnails) {
      var thumbnail = new ThumbnailFrame(thumbnailPath);
      thumbnail.x = 68 + ((i%6) * (thumbnail.width + 25));
      thumbnail.y = FlxG.height - thumbnail.height;

      thumbnailGroup.add(thumbnail);
      i++;
    }

    for (i in 0...6) {
      cast(thumbnailGroup.members[i], ThumbnailFrame).appear();
    }

    add(thumbnailGroup);
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Reg.score;

    if (FlxG.mouse.y < 24) {
      FlxTween.tween(toolbar, { y: 0 }, 0.25, { ease: FlxEase.quadOut });
    } else {
      FlxTween.tween(toolbar, { y: -40 }, 0.25, { ease: FlxEase.quadOut });
    }

    if (FlxG.keys.justPressed.SPACE) {
      for (thumbnail in thumbnailGroup.members) {
        cast(thumbnail, ThumbnailFrame).appear();
      }
    }

    super.update(elapsed);

    if (FlxG.mouse.y > FlxG.height - 74) {
      FlxG.mouse.visible = true;
      Reg.stamp.visible = false;
    } else {
      FlxG.mouse.visible = false;
      Reg.stamp.visible = true;
    }
  }
}
