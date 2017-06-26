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

class OptionGroup extends FlxSpriteGroup {
  static inline var GROUP_SIZE:Int = 6;

  var groupIndex:Int = 0;
  var numGroups:Int = 0;
  var leftArrow:SelectionArrow;
  var rightArrow:SelectionArrow;

  var thumbnails:FlxSpriteGroup;

  public function new(thumbnailPaths:Array<String>, type:String, Y:Float = 0):Void {
    super(0, Y);

    numGroups = Std.int((thumbnailPaths.length - 1) / GROUP_SIZE);

    thumbnails = new FlxSpriteGroup();
    add(thumbnails);

    leftArrow = new SelectionArrow(0, 8);
    leftArrow.facing = FlxObject.LEFT;
    leftArrow.visible = false;
    leftArrow.clickCallback = function():Void {
      if (groupIndex > 0) {
        groupIndex--;
        hide();
        show(FlxObject.LEFT);
      }
    };
    add(leftArrow);

    rightArrow = new SelectionArrow(FlxG.width - 64, 8);
    rightArrow.visible = false;
    rightArrow.clickCallback = function():Void {
      if (groupIndex < numGroups) {
        groupIndex++;
        hide();
        show(FlxObject.RIGHT);
      }
    };
    add(rightArrow);

    var i = 0;
    var regex = ~/thumbs\//;

    for (thumbnailPath in thumbnailPaths) {
      var thumbnail = new ThumbnailFrame(thumbnailPath);
      thumbnail.x = 68 + ((i%GROUP_SIZE) * (thumbnail.width + 25));
      thumbnail.clickCallback = function():Void {
        var path = regex.replace(thumbnailPath, "");

        // Avoiding reflection if possible
        if (type == "background") {
          Reg.background.loadGraphic(path);
        } else {
          Reg.stamp.loadGraphic(path);
        }
      }

      thumbnails.add(thumbnail);

      i++;
    }
  }

  public function show(direction:Int = 0):Void {
    rightArrow.visible = (groupIndex <= 0);
    leftArrow.visible = (groupIndex >= numGroups);

    var start:Int = GROUP_SIZE * groupIndex;
    var end:Int = start + GROUP_SIZE;

    for (i in start...end) {
      if (thumbnails.members[i] != null) {
        var increment:Float = 0;
        if (direction == FlxObject.RIGHT) {
          increment = (i % GROUP_SIZE) * 0.025;
        } else if (direction == FlxObject.LEFT) {
          increment = (GROUP_SIZE - (i % GROUP_SIZE)) * 0.025;
        }

        cast(thumbnails.members[i], ThumbnailFrame).appear(increment);
      }
    }
  }

  public function hide():Void {
    for (thumb in thumbnails.members) {
      cast(thumb, ThumbnailFrame).disappear();
    }

    leftArrow.visible = false;
    rightArrow.visible = false;
  }

  function showArrows():Void {
    leftArrow.visible = (groupIndex > 0);
    rightArrow.visible = (groupIndex < numGroups);
  }
}
