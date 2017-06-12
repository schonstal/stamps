package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class OptionGroup extends FlxSpriteGroup {
  public function new(thumbnailPaths:Array<String>):Void {
    super();

    var i = 0;
    var regex = ~/thumbs\//;

    for (thumbnailPath in thumbnailPaths) {
      var thumbnail = new ThumbnailFrame(thumbnailPath);
      thumbnail.x = 68 + ((i%6) * (thumbnail.width + 25));
      thumbnail.y = FlxG.height - thumbnail.height;
      thumbnail.clickCallback = function():Void {
        Reg.background.loadGraphic(regex.replace(thumbnailPath, ""));
      }

      add(thumbnail);

      i++;
    }
  }

  public function appear():Void {
    for (i in 0...6) {
      cast(members[i], ThumbnailFrame).appear();
    }
  }
}
