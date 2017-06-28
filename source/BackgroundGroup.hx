package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class BackgroundGroup extends OptionGroup {
  public function new():Void {
    super();

    prefix = "backgrounds";
    thumbnailPaths = [
      "notebook",
      "blue",
      "green",
      "red",
      "white",
      "yellow",
      "moda",
      "parchment",
      "steve",
      "stone"
    ];

    clickCallback = onClick;
    loadThumbnails();
  }

  function onClick(path:String):Void {
    Reg.background.loadGraphic('assets/images/backgrounds/$path.png');
  }
}
