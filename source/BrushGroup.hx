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

class BrushGroup extends OptionGroup {
  var activePalette:FlxSprite;
  var lastPath:String = "black";

  public function new():Void {
    super();

    prefix = "palette";
    thumbnailPaths = [
      "red",
      "blue",
      "green",
      "yellow",
      "lavendar",
      "pink",
      "black",
      "white",
      "darkBlue",
      "darkBrown",
      "tan",
      "peach"
    ];

    clickCallback = onClick;
    loadThumbnails();

    activePalette = new FlxSprite();
    activePalette.loadGraphic("assets/images/palettes/black.png");
  }

  function onClick(path:String):Void {
    lastPath = path;
    Reg.continuous = true;
    activePalette.loadGraphic('assets/images/palette/$path.png');

    Reg.stamp.makeGraphic(8, 8, activePalette.pixels.getPixel32(0, 0));
  }
}
