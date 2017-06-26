package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class TopToolbar extends FlxSpriteGroup {
  public function new(thumbnailPaths:Array<String>, targetSprite:FlxSprite, Y:Float = 0):Void {
    super(0, Y);

    var i = 0;
    var regex = ~/thumbs\//;

    for (thumbnailPath in thumbnailPaths) {
      var thumbnail = new ThumbnailFrame(thumbnailPath);
      thumbnail.x = 68 + ((i%6) * (thumbnail.width + 25));
      thumbnail.clickCallback = function():Void {
        targetSprite.loadGraphic(regex.replace(thumbnailPath, ""));
      }

      add(thumbnail);

      i++;
    }
  }

  public function appear():Void {
    for (i in 0...6) {
      if (members[i] != null) {
        cast(members[i], ThumbnailFrame).appear();
      }
    }
  }
}
